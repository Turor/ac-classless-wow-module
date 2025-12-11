#include "ClasslessPlayerScripts.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "DBCStores.h"
#include "SpellMgr.h"
#include "AchievementMgr.h"
#include "SpellAuraEffects.h"
#include "Unit.h"

enum MyPlayerAcoreString {
    HELLO_WORLD = 35410
};

ClasslessPlayerScripts::ClasslessPlayerScripts() : PlayerScript("MyPlayer") {
}

void ClasslessPlayerScripts::SetTalentYieldAchievements(std::unordered_set<uint32> ids) {
    achievements_which_yield_talents_ = std::move(ids);
}

void ClasslessPlayerScripts::OnPlayerLogin(Player *player) {
    if (sConfigMgr->GetOption<bool>("MyModule.Enable", false))
        ChatHandler(player->GetSession()).PSendSysMessage(HELLO_WORLD);
}

Optional<bool> ClasslessPlayerScripts::OnPlayerIsClass(Player const *, Classes, ClassContext context) {
    switch (context) {
        case CLASS_CONTEXT_QUEST:
        case CLASS_CONTEXT_TAXI:
        case CLASS_CONTEXT_TALENT_POINT_CALC:
        case CLASS_CONTEXT_ABILITY:
        case CLASS_CONTEXT_ABILITY_REACTIVE:
        case CLASS_CONTEXT_EQUIP_RELIC:
        case CLASS_CONTEXT_EQUIP_SHIELDS:
        case CLASS_CONTEXT_EQUIP_ARMOR_CLASS:
        case CLASS_CONTEXT_WEAPON_SWAP:
        case CLASS_CONTEXT_CLASS_TRAINER:
            return true;
        default:
            return std::nullopt;
    }
}

bool ClasslessPlayerScripts::OnPlayerLearnTalentUseAlternativeLogic(Player *player, uint32 talentId, uint32 talentRank,
                                                                    bool command) {
    // ... original logic kept unchanged ...
    uint32 CurTalentPoints = player->GetFreeTalentPoints();
    if (!command) {
        if (!CurTalentPoints) return true;
        if (talentRank >= MAX_TALENT_RANK) return true;
    }

    TalentEntry const *talentInfo = sTalentStore.LookupEntry(talentId);
    if (!talentInfo) return true;

    TalentTabEntry const *talentTabInfo = sTalentTabStore.LookupEntry(talentInfo->TalentTab);
    if (!talentTabInfo) return true;

    if ((player->getClassMask() & talentTabInfo->ClassMask) == 0) return true;

    uint32 currentTalentRank = 0;
    for (uint8 rank = 0; rank < MAX_TALENT_RANK; ++rank)
        if (talentInfo->RankID[rank] && player->HasTalent(talentInfo->RankID[rank], player->GetActiveSpec())) {
            currentTalentRank = rank + 1;
            break;
        }

    if (currentTalentRank >= talentRank + 1) return true;

    uint32 talentPointsChange = (talentRank - currentTalentRank + 1);
    if (!command && CurTalentPoints < talentPointsChange) return true;

    if (talentInfo->DependsOn > 0)
        if (TalentEntry const *depTalentInfo = sTalentStore.LookupEntry(talentInfo->DependsOn)) {
            bool hasEnoughRank = false;
            for (uint8 rank = talentInfo->DependsOnRank; rank < MAX_TALENT_RANK; rank++)
                if (depTalentInfo->RankID[rank] && player->HasTalent(depTalentInfo->RankID[rank],
                                                                     player->GetActiveSpec())) {
                    hasEnoughRank = true;
                    break;
                }
            if (!hasEnoughRank) return true;
        }

    if (!command) {
        uint32 spentPoints = 0;
        if (talentInfo->Row > 0) {
            const PlayerTalentMap &talentMap = player->GetTalentMap();
            for (auto const &it: talentMap)
                if (TalentSpellPos const *pos = GetTalentSpellPos(it.first))
                    if (TalentEntry const *t = sTalentStore.LookupEntry(pos->talent_id))
                        if (it.second->State != PLAYERSPELL_REMOVED && it.second->IsInSpec(player->GetActiveSpec()))
                            spentPoints += pos->rank + 1;
        }
        if (spentPoints < (talentInfo->Row * MAX_TALENT_RANK)) return true;
    }

    uint32 spellId = talentInfo->RankID[talentRank];
    if (!spellId) return true;

    SpellInfo const *spellInfo = sSpellMgr->GetSpellInfo(spellId);
    if (!spellInfo) return true;

    bool learned = false;
    if (talentInfo->addToSpellBook)
        if (!spellInfo->HasAttribute(SPELL_ATTR0_PASSIVE) && !spellInfo->HasEffect(SPELL_EFFECT_LEARN_SPELL)) {
            player->learnSpell(spellId);
            learned = true;
        }

    if (!learned) player->SendLearnPacket(spellId, true);

    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        if (spellInfo->Effects[i].Effect == SPELL_EFFECT_LEARN_SPELL)
            if (sSpellMgr->IsAdditionalTalentSpell(spellInfo->Effects[i].TriggerSpell))
                player->learnSpell(spellInfo->Effects[i].TriggerSpell);

    player->addTalent(spellId, player->GetActiveSpecMask(), currentTalentRank);

    if (!command) player->SetFreeTalentPoints(CurTalentPoints - talentPointsChange);

    sScriptMgr->OnPlayerLearnTalents(player, talentId, talentRank, spellId);
    return true;
}

void ClasslessPlayerScripts::OnPlayerCalculateTalentsPoints(Player const *player, uint32 &talentPointsForLevel) {
    uint32 talentPoints = player->GetLevel();
    CompletedAchievementMap const &completed = player->GetAchievementMgr()->GetCompletedAchievements();
    for (auto const &kv: completed)
        if (achievements_which_yield_talents_.find(kv.first) != achievements_which_yield_talents_.end())
            ++talentPoints;
    talentPointsForLevel = talentPoints;
}

bool ClasslessPlayerScripts::OnUpdateAttackPowerAndDamageReplaceWithAlternativeCalculation(
    Player *player, bool ranged) {
    float baseAttackPower = 0.0f;
    float level = float(player->GetLevel());

    sScriptMgr->OnPlayerBeforeUpdateAttackPowerAndDamage(player, level, baseAttackPower, ranged);

    UnitMods unitMod = ranged ? UNIT_MOD_ATTACK_POWER_RANGED : UNIT_MOD_ATTACK_POWER;

    uint16 index = UNIT_FIELD_ATTACK_POWER;
    uint16 index_mod = UNIT_FIELD_ATTACK_POWER_MODS;
    uint16 index_mult = UNIT_FIELD_ATTACK_POWER_MULTIPLIER;

    if (ranged) {
        index = UNIT_FIELD_RANGED_ATTACK_POWER;
        index_mod = UNIT_FIELD_RANGED_ATTACK_POWER_MODS;
        index_mult = UNIT_FIELD_RANGED_ATTACK_POWER_MULTIPLIER;

        switch (player->GetShapeshiftForm()) {
            case FORM_CAT:
            case FORM_BEAR:
            case FORM_DIREBEAR:
                baseAttackPower = 0.0f;
                break;
            default:
                baseAttackPower = baseAttackPower = level * 2.0f + player->GetStat(STAT_AGILITY) - 10.0f;
                break;
        }
    } else {
        float mLevelMult = 0.0f;
        float weapon_bonus = 0.0f;
        if (player->IsInFeralForm()) {
                Unit::AuraEffectList const &mDummy = player->GetAuraEffectsByType(SPELL_AURA_DUMMY);
                for (Unit::AuraEffectList::const_iterator itr = mDummy.begin(); itr != mDummy.end(); ++itr) {
                    AuraEffect *aurEff = *itr;
                    if (aurEff->GetSpellInfo()->SpellIconID == 1563) {
                        switch (aurEff->GetEffIndex()) {
                            case 0: // Predatory Strikes (effect 0)
                                mLevelMult = CalculatePct(1.0f, aurEff->GetAmount());
                                break;
                            // case 1: // Predatory Strikes (effect 1)
                            //     if (Item *mainHand = player->GetItemByPos()[EQUIPMENT_SLOT_MAINHAND]) {
                            //         // also gains % attack power from equipped weapon
                            //         ItemTemplate const *proto = mainHand->GetTemplate();
                            //         if (!proto)
                            //             continue;
                            //
                            //         uint32 ap = proto->getFeralBonus();
                            //         // Get AP Bonuses from weapon
                            //         for (uint8 i = 0; i < MAX_ITEM_PROTO_STATS; ++i) {
                            //             if (i >= proto->StatsCount)
                            //                 break;
                            //
                            //             if (proto->ItemStat[i].ItemStatType == ITEM_MOD_ATTACK_POWER)
                            //                 ap += proto->ItemStat[i].ItemStatValue;
                            //         }
                            //
                            //         // Get AP Bonuses from weapon spells
                            //         for (uint8 i = 0; i < MAX_ITEM_PROTO_SPELLS; ++i) {
                            //             // no spell
                            //             if (!proto->Spells[i].SpellId || proto->Spells[i].SpellTrigger !=
                            //                 ITEM_SPELLTRIGGER_ON_EQUIP)
                            //                 continue;
                            //
                            //             // check if it is valid spell
                            //             SpellInfo const *spellproto = sSpellMgr->GetSpellInfo(proto->Spells[i].SpellId);
                            //             if (!spellproto)
                            //                 continue;
                            //
                            //             for (uint8 j = 0; j < MAX_SPELL_EFFECTS; ++j)
                            //                 if (spellproto->Effects[j].ApplyAuraName == SPELL_AURA_MOD_ATTACK_POWER)
                            //                     ap += spellproto->Effects[j].CalcValue();
                            //         }
                            //
                            //         weapon_bonus = CalculatePct(float(ap), aurEff->GetAmount());
                            //     }
                            //     break;
                            default:
                                mLevelMult = CalculatePct(1.0f, aurEff->GetAmount());
                                break;
                        }
                    }
                }
            }
        switch (player->GetShapeshiftForm()) {
            case FORM_CAT:
                baseAttackPower = (player->GetLevel() * mLevelMult) + player->GetStat(STAT_STRENGTH) * 2.0f + player->GetStat(STAT_AGILITY)
                                  - 20.0f + weapon_bonus;// + player->m_baseFeralAP;
                break;
            case FORM_BEAR:
            case FORM_DIREBEAR:
                baseAttackPower = (player->GetLevel() * mLevelMult) + player->GetStat(STAT_STRENGTH) * 2.0f - 20.0f + weapon_bonus;
                                  //m_baseFeralAP;
                break;
            case FORM_MOONKIN:
                baseAttackPower = (player->GetLevel() * mLevelMult) + player->GetStat(STAT_STRENGTH) * 2.0f - 20.0f;// + m_baseFeralAP;
                break;
            default:
                baseAttackPower = level * 3.0f + player->GetStat(STAT_STRENGTH) * 1.5f + player->GetStat(STAT_AGILITY) * 1.5f  - 20.0f;
                break;
        }
    }

    player->SetStatFlatModifier(unitMod, BASE_VALUE, baseAttackPower);

    float base_attPower = player->GetFlatModifierValue(unitMod, BASE_VALUE) * player->GetPctModifierValue(unitMod, BASE_PCT);
    float attPowerMod = player->GetFlatModifierValue(unitMod, TOTAL_VALUE);

    //add dynamic flat mods
    if (ranged) {
        std::vector<AuraEffect*> const &mRAPbyStat = player->GetAuraEffectsByType(SPELL_AURA_MOD_RANGED_ATTACK_POWER_OF_STAT_PERCENT);
        for (std::vector<AuraEffect*>::const_iterator i = mRAPbyStat.begin(); i != mRAPbyStat.end(); ++i)
            attPowerMod += CalculatePct(player->GetStat(Stats((*i)->GetMiscValue())), (*i)->GetAmount());

    } else {
        std::vector<AuraEffect*> const &mAPbyStat = player->GetAuraEffectsByType(SPELL_AURA_MOD_ATTACK_POWER_OF_STAT_PERCENT);
        for (std::vector<AuraEffect*>::const_iterator i = mAPbyStat.begin(); i != mAPbyStat.end(); ++i)
            attPowerMod += CalculatePct(player->GetStat(Stats((*i)->GetMiscValue())), (*i)->GetAmount());

        std::vector<AuraEffect*> const &mAPbyArmor = player->GetAuraEffectsByType(SPELL_AURA_MOD_ATTACK_POWER_OF_ARMOR);
        for (std::vector<AuraEffect*>::const_iterator iter = mAPbyArmor.begin(); iter != mAPbyArmor.end(); ++iter)
            // always: ((*i)->GetModifier()->m_miscvalue == 1 == SPELL_SCHOOL_MASK_NORMAL)
            attPowerMod += int32(player->GetArmor() / (*iter)->GetAmount());
    }

    float attPowerMultiplier = player->GetPctModifierValue(unitMod, TOTAL_PCT) - 1.0f;

    sScriptMgr->OnPlayerAfterUpdateAttackPowerAndDamage(player, level, base_attPower, attPowerMod, attPowerMultiplier,
                                                        ranged);
    player->SetInt32Value(index, (uint32) base_attPower); //UNIT_FIELD_(RANGED)_ATTACK_POWER field
    player->SetInt32Value(index_mod, (uint32) attPowerMod); //UNIT_FIELD_(RANGED)_ATTACK_POWER_MODS field
    player->SetFloatValue(index_mult, attPowerMultiplier); //UNIT_FIELD_(RANGED)_ATTACK_POWER_MULTIPLIER field

    //automatically update weapon damage after attack power modification
    if (ranged) {
        player->UpdateDamagePhysical(RANGED_ATTACK);
    } else {
        player->UpdateDamagePhysical(BASE_ATTACK);
        if (player->CanDualWield() && player->HasOffhandWeaponForAttack())
            //allow update offhand damage only if player knows DualWield Spec and has equipped offhand weapon
           player->UpdateDamagePhysical(OFF_ATTACK);
            player->UpdateSpellDamageAndHealingBonus();
    }
    return true;
}


ClasslessPlayerScripts *AddClasslessPlayerScripts() {
    auto *cps = new ClasslessPlayerScripts(); // ScriptMgr takes ownership
    return cps;
}

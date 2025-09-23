#include "ClasslessPlayerScripts.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "DBCStores.h"
#include "SpellMgr.h"
#include "AchievementMgr.h"

enum MyPlayerAcoreString
{
    HELLO_WORLD = 35410
};

ClasslessPlayerScripts::ClasslessPlayerScripts() : PlayerScript("MyPlayer") { }

void ClasslessPlayerScripts::SetTalentYieldAchievements(std::unordered_set<uint32> ids)
{
    achievements_which_yield_talents_ = std::move(ids);
}

void ClasslessPlayerScripts::OnPlayerLogin(Player* player)
{
    if (sConfigMgr->GetOption<bool>("MyModule.Enable", false))
        ChatHandler(player->GetSession()).PSendSysMessage(HELLO_WORLD);
}

Optional<bool> ClasslessPlayerScripts::OnPlayerIsClass(Player const*, Classes, ClassContext context)
{
    switch (context)
    {
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

bool ClasslessPlayerScripts::OnPlayerLearnTalentUseAlternativeLogic(Player* player, uint32 talentId, uint32 talentRank, bool command)
{
    // ... original logic kept unchanged ...
    uint32 CurTalentPoints = player->GetFreeTalentPoints();
    if (!command)
    {
        if (!CurTalentPoints) return true;
        if (talentRank >= MAX_TALENT_RANK) return true;
    }

    TalentEntry const* talentInfo = sTalentStore.LookupEntry(talentId);
    if (!talentInfo) return true;

    TalentTabEntry const* talentTabInfo = sTalentTabStore.LookupEntry(talentInfo->TalentTab);
    if (!talentTabInfo) return true;

    if ((player->getClassMask() & talentTabInfo->ClassMask) == 0) return true;

    uint32 currentTalentRank = 0;
    for (uint8 rank = 0; rank < MAX_TALENT_RANK; ++rank)
        if (talentInfo->RankID[rank] && player->HasTalent(talentInfo->RankID[rank], player->GetActiveSpec()))
        { currentTalentRank = rank + 1; break; }

    if (currentTalentRank >= talentRank + 1) return true;

    uint32 talentPointsChange = (talentRank - currentTalentRank + 1);
    if (!command && CurTalentPoints < talentPointsChange) return true;

    if (talentInfo->DependsOn > 0)
        if (TalentEntry const* depTalentInfo = sTalentStore.LookupEntry(talentInfo->DependsOn))
        {
            bool hasEnoughRank = false;
            for (uint8 rank = talentInfo->DependsOnRank; rank < MAX_TALENT_RANK; rank++)
                if (depTalentInfo->RankID[rank] && player->HasTalent(depTalentInfo->RankID[rank], player->GetActiveSpec()))
                { hasEnoughRank = true; break; }
            if (!hasEnoughRank) return true;
        }

    if (!command)
    {
        uint32 spentPoints = 0;
        if (talentInfo->Row > 0)
        {
            const PlayerTalentMap& talentMap = player->GetTalentMap();
            for (auto const& it : talentMap)
                if (TalentSpellPos const* pos = GetTalentSpellPos(it.first))
                    if (TalentEntry const* t = sTalentStore.LookupEntry(pos->talent_id))
                        if (it.second->State != PLAYERSPELL_REMOVED && it.second->IsInSpec(player->GetActiveSpec()))
                            spentPoints += pos->rank + 1;
        }
        if (spentPoints < (talentInfo->Row * MAX_TALENT_RANK)) return true;
    }

    uint32 spellId = talentInfo->RankID[talentRank];
    if (!spellId) return true;

    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
    if (!spellInfo) return true;

    bool learned = false;
    if (talentInfo->addToSpellBook)
        if (!spellInfo->HasAttribute(SPELL_ATTR0_PASSIVE) && !spellInfo->HasEffect(SPELL_EFFECT_LEARN_SPELL))
        { player->learnSpell(spellId); learned = true; }

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

void ClasslessPlayerScripts::OnPlayerCalculateTalentsPoints(Player const* player, uint32& talentPointsForLevel)
{
    uint32 talentPoints = player->GetLevel();
    CompletedAchievementMap const& completed = player->GetAchievementMgr()->GetCompletedAchievements();
    for (auto const& kv : completed)
        if (achievements_which_yield_talents_.find(kv.first) != achievements_which_yield_talents_.end())
            ++talentPoints;
    talentPointsForLevel = talentPoints;
}

ClasslessPlayerScripts* AddClasslessPlayerScripts()
{
    auto* cps = new ClasslessPlayerScripts(); // ScriptMgr takes ownership
    return cps;
}
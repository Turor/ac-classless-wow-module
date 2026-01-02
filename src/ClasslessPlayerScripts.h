#pragma once

#include "ScriptMgr.h"
#include "SharedDefines.h"
#include <unordered_set>

class Player;

class ClasslessPlayerScripts : public PlayerScript
{
public:
    ClasslessPlayerScripts();

    void SetTalentYieldAchievements(std::unordered_set<uint32> ids);

    void OnPlayerLogin(Player* player) override;
    Optional<bool> OnPlayerIsClass(Player const*, Classes, ClassContext context) override;
    bool OnPlayerLearnTalentUseAlternativeLogic(Player* player, uint32 talentId, uint32 talentRank, bool command) override;
    void OnPlayerCalculateTalentsPoints(Player const* player, uint32& talentPointsForLevel) override;
    bool OnUpdateAttackPowerAndDamageReplaceWithAlternativeCalculation(Player* player, bool ranged) override;
    bool OnPlayerHasActivePowerType(Player const* player, Powers power) override;

private:
    std::unordered_set<uint32> achievements_which_yield_talents_;
};

// factory (returns the created/registered script)
ClasslessPlayerScripts* AddClasslessPlayerScripts();
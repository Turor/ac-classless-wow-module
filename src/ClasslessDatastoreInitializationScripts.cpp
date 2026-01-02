#include "ClasslessDatastoreInitializationScripts.h"

#include "ScriptMgr.h"
#include "DatabaseEnv.h"
#include <unordered_set>

void ClasslessDatastoreInitializationScripts::OnAfterDatabasesLoaded(uint32) {
    uint32 oldMSTime = getMSTime();
    std::unordered_set<uint32> ids;
    LOG_INFO("server.loading", "Loading achievements for talent point calculations");
    if (QueryResult r = WorldDatabase.Query("SELECT achievement_id FROM acore_world.classless_achievements_which_yield_talents")) {
        do { ids.insert(r->Fetch()[0].Get<uint32>()); } while (r->NextRow());
    } else {
        LOG_ERROR("server.loading", "Could not load achievements for talent point calculations");
    }
    if (cps_) cps_->SetTalentYieldAchievements(ids);
    LOG_INFO("server.loading", ">> Loaded achievements for talent point calculations in {} ms", GetMSTimeDiffToNow(oldMSTime));
}

void AddClasslessDatastoreInitializationScripts(ClasslessPlayerScripts* classless_player_scripts)
{
    new ClasslessDatastoreInitializationScripts(classless_player_scripts);
}

//
// Created by Drago on 9/23/2025.
//

#ifndef AZEROTHCORE_CLASSLESSDATASTOREINITIALIZATIONSCRIPTS_H
#define AZEROTHCORE_CLASSLESSDATASTOREINITIALIZATIONSCRIPTS_H
#include "ClasslessPlayerScripts.h"

class ClasslessDatastoreInitializationScripts : public DatabaseScript
{
public:
    explicit ClasslessDatastoreInitializationScripts(ClasslessPlayerScripts* cps) : DatabaseScript("ClasslessDB"), cps_(cps) {}

private:
    ClasslessPlayerScripts* cps_;

    void OnAfterDatabasesLoaded(uint32) override;
};

void AddClasslessDatastoreInitializationScripts(ClasslessPlayerScripts* classless_player_scripts);

#endif //AZEROTHCORE_CLASSLESSDATASTOREINITIALIZATIONSCRIPTS_H
/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */


#include "ClasslessPlayerScripts.h"

void AddClasslessDatastoreInitializationScripts(ClasslessPlayerScripts*);

void Addac_classless_wow_moduleScripts()
{
    ClasslessPlayerScripts* classless_player_scripts = AddClasslessPlayerScripts();
    AddClasslessDatastoreInitializationScripts(classless_player_scripts);
}


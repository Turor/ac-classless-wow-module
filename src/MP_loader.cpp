/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#include "ClasslessPetScripts.h"
#include "ClasslessPlayerScripts.h"
#include "ClasslessUnitScripts.h"
#include "ClasslessDatastoreInitializationScripts.h"

void Addmod_classlessScripts()
{
    ClasslessPlayerScripts* classless_player_scripts = AddClasslessPlayerScripts();
    AddClasslessDatastoreInitializationScripts(classless_player_scripts);
    ClasslessUnitScripts* classless_unit_scripts = AddClasslessUnitScripts();
    ClasslessPetScripts* classless_pet_scripts = AddClasslessPetScripts(classless_player_scripts);
}


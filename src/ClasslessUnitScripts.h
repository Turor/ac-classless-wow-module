#pragma once
#include "UnitScript.h"

class Unit;

class ClasslessUnitScripts : public UnitScript
{
public:
    ClasslessUnitScripts();

    bool OnExtraProcHandleReactionStates(Unit* unit, Unit* target, bool isVictim, uint32 procs) override;
};

ClasslessUnitScripts* AddClasslessUnitScripts();
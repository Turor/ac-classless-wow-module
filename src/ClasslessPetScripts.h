#pragma once
#include "ClasslessPlayerScripts.h"
#include "PetScript.h"

class Pet;


class ClasslessPetScripts : public PetScript {
public:
    ClasslessPetScripts(ClasslessPlayerScripts* cps);
    void OnCalculateMaxTalentPointsForLevel(Pet* pet, uint8 level, uint8& points) override;

private:
    ClasslessPlayerScripts* cps_;
};

ClasslessPetScripts* AddClasslessPetScripts(ClasslessPlayerScripts* classless_player_scripts);

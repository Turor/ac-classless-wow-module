# Classless Wow Module

[English](README.md)

## Introduction
The goal of this module is to provide a classless version of the Wotlk version of AzerothCore. The gameplay experience will
be curated for small groups of players, and there will be no PvP balance. The purpose of this module is to develop overpowered
builds.

Progression is primarily handled through talent points which are computed based off of the level of the player + the number of
unlocked achievements. There is currently no cap- although a configuration setting for a talent cap is planned.

## Implemented Features
- Talent points are computed based off of the player's achievements and level.
- Trainers can train any class
- Players can learn any talent from any tree

## TODOS
- A UI mod to allow players to select talents from any tree
- A UI mod to allow players to see their mana, rage, energy, and runic power
- A UI mod to allow players to access all their spells.
- Configuration setting to set talent cap
- Unify the attack power/damage calculations for every class
- Overhaul the pet system
- A UI mod to allow players to equip bows/guns/wands/relics/totems/ammunition/etc as any class
- Validate the dbc files necessary to handle classless wow- a guide to be written for sure: Talent.dbc, TalentTab.dbc, 
  SkillLineAbility.dbc, SkillRaceClassInfo.dbc, (maybe spell.dbc? I might've modified it unnecessarily)

## Licensing

The default license of the skeleton-module template is the MIT but you can use a different license for your own modules.

So modules can also be kept private. However, if you need to add new hooks to the core, as well as improving existing ones, you have to share your improvements because the main core is released under the AGPL license. Please [provide a PR](https://www.azerothcore.org/wiki/How-to-create-a-PR) if that is the case.

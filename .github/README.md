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
- A UI mod to allow players to access all their spells.
- Configuration setting to set talent cap
- Overhaul the pet system

- Portal Master to dungeons
- Teleport spell to atrain/htrain
- Movement speed QoL spell (AuraInterruptFlags 32)
- TotemBar added to bartender for every class
  - Totem vendor
  - Modify totems to not be soulbound or bind on pickup and be destroyable
- MythicPlus
- AuctionHousePlus

## Useful commands
- cargo run -p wow_custom_dbc -- wrath -o /usr/games/wow/server/data -i /usr/games/wow/

## Licensing

The default license of the skeleton-module template is the MIT but you can use a different license for your own modules.

So modules can also be kept private. However, if you need to add new hooks to the core, as well as improving existing ones, you have to share your improvements because the main core is released under the AGPL license. Please [provide a PR](https://www.azerothcore.org/wiki/How-to-create-a-PR) if that is the case.

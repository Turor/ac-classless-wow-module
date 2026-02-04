delete from npc_trainer where SpellID in (712,697,691,883,982, 1515, 2641, 6991, 71, 2458, 5487, 8071,3599,5394);

select id, SpellID from npc_trainer where SpellID in (8154, 6363, 6375);

insert into npc_trainer
values
    (200010, 712, 0, 0, 0, 20, 0), -- succubus
    (200010, 697, 0, 0, 0, 10, 0), -- voidwalker
    (200010, 691, 0, 0, 0, 30, 0),  -- felhunter
    (200014, 883, 0, 0, 0, 10, 0), -- 883 Call Pet
    (200014, 982, 0, 0, 0, 10, 0), -- 982 Revive Pet
    (200014, 1515, 0, 0, 0, 10, 0), -- 1515 Tame Beast
    (200014, 2641, 0, 0, 0, 10, 0),  -- 2641 Dismiss Pet
    (200014, 6991, 0, 0, 0, 10, 0),  -- 6991 Feed Pet
    (200002, 71, 0, 0, 0, 10, 0),  -- 71 Defensive Stance
    (200001, 2458, 0, 0, 0, 30, 0),  -- 2458 Berserker Stance
    (200006, 5487, 0, 0, 0, 10, 0),  -- 5487 Bear Form
    (200018, 5394, 0, 0, 0, 20, 0),  -- 5394 Healing Stream
    (200018, 3599, 0, 0, 0, 10, 0),  -- 3599 Searing Totem
    (200018, 8071, 0, 0, 0, 4, 0)  -- 8071 Stoneskin Totem
;
-- Growl and Maul


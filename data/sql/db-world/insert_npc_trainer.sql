delete from trainer_spell where SpellID in (712,697,691,883,982, 1515, 2641, 6991, 71, 2458, 5487, 8071,3599,5394,6807,1853);

update trainer set Requirement=0;

insert into trainer_spell(TrainerId, SpellId, MoneyCost, ReqSkillLine, ReqSkillRank, ReqAbility1, ReqAbility2, ReqAbility3, ReqLevel, VerifiedBuild)
values
    (31, 712, 0, 0, 0, 0, 0, 0,20, 0), -- succubus
    (31, 697, 0, 0, 0, 0, 0,0,10,0), -- voidwalker
    (31, 691, 0, 0, 0, 0, 0,0,30,0),  -- felhunter
    (32, 712, 0, 0, 0, 0, 0, 0,20, 0), -- succubus
    (32, 697, 0, 0, 0, 0, 0,0,10,0), -- voidwalker
    (32, 691, 0, 0, 0, 0, 0,0,30,0),  -- felhunter
    (7, 883, 0, 0, 0, 0, 0,0,10,0), -- 883 Call Pet
    (7, 982, 0, 0, 0, 0, 0,0,10,0), -- 982 Revive Pet
    (7, 1515, 0, 0, 0, 0, 0,0,10,0), -- 1515 Tame Beast
    (7, 2641, 0, 0, 0, 0,0,0,10, 0),  -- 2641 Dismiss Pet
    (7, 6991, 0, 0, 0, 0,0,0,10, 0),  -- 6991 Feed Pet
    (8, 883, 0, 0, 0, 0, 0,0,10,0), -- 883 Call Pet
    (8, 982, 0, 0, 0, 0, 0,0,10,0), -- 982 Revive Pet
    (8, 1515, 0, 0, 0, 0, 0,0,10,0), -- 1515 Tame Beast
    (8, 2641, 0, 0, 0, 0,0,0,10, 0),  -- 2641 Dismiss Pet
    (8, 6991, 0, 0, 0, 0,0,0,10, 0),  -- 6991 Feed Pet
    (1, 71, 0, 0, 0, 0,0,0,10, 0),  -- 71 Defensive Stance
    (1, 2458, 0, 0, 0, 0,0,0,30, 0),  -- 2458 Berserker Stance
    (2, 71, 0, 0, 0, 0,0,0,10, 0),  -- 71 Defensive Stance
    (2, 2458, 0, 0, 0, 0,0,0,30, 0),  -- 2458 Berserker Stance
    (33, 5487, 0, 0, 0, 0,0,0,10, 0),  -- 5487 Bear Form
    (33, 1853, 0, 0, 0, 0,0,0,10, 0),  -- 1853 Growl
    (33, 6807, 0, 0, 0, 0,0,0,10, 0),  -- 1853 Maul
    (34, 5487, 0, 0, 0, 0,0,0,10, 0),  -- 5487 Bear Form
    (34, 1853, 0, 0, 0, 0,0,0,10, 0),  -- 1853 Growl
    (34, 6807, 0, 0, 0, 0,0,0,10, 0),  -- 1853 Maul
    (14, 5394, 0, 0, 0, 0,0,0,20, 0),  -- 5394 Healing Stream
    (14, 3599, 0, 0, 0, 0,0,0,10, 0),  -- 3599 Searing Totem
    (14, 8071, 0, 0, 0, 0,0,0,4, 0),  -- 8071 Stoneskin Totem
    (15, 5394, 0, 0, 0, 0,0,0,20, 0),  -- 5394 Healing Stream
    (15, 3599, 0, 0, 0, 0,0,0,10, 0),  -- 3599 Searing Totem
    (15, 8071, 0, 0, 0, 0,0,0,4, 0)  -- 8071 Stoneskin Totem
;

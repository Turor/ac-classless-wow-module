update acore_world.playercreateinfo_skills
set classMask = 2047, raceMask = 1791
where  comment not like '%Racial%' and comment not like '%Language%';

-- 473
insert ignore acore_world.playercreateinfo_skills values(1791,2047,473,0,'Fist Weapons');

update acore_world.playercreateinfo_skills set raceMask = 1791 where skill in (109,98);

-- 109 Language: Orcish
select * from acore_world.playercreateinfo_skills order by comment;

select ch.guid, cs.* from acore_characters.characters ch
join acore_characters.character_skills cs on ch.guid = cs.guid
where name = 'Bragisa'
order by cs.skill;

insert into acore_characters.character_skills values (89,109,300,300);
select * from acore_characters.character_skills;
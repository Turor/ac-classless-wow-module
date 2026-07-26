-- 51459, 51462, 51463, 51464, 51465

select * from acore_world.spell_proc_event where entry in (-51459, -51462, -51463, -51464, -51465);
update acore_world.spell_proc_event set procFlags = 340 where entry in (-51459, -51462, -51463, -51464, -51465);
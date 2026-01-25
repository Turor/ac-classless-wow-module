select * from spell_pet_auras spa;
select distinct pet from spell_pet_auras;
--  pet in (0, 416, 417, 1860, 1863, 17252)
-- pet id 0 means all

select faction,creature_template.*
from acore_world.creature_template where entry = 2404;


update creature_template set faction = 1774 where entry = 2404;


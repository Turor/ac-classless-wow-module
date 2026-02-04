-- Add ability power scaling to thorns
-- in (467,782,1075,8914,9756,9910,26992,53307) THORNS
-- in (7294, 10298, 10299, 10300, 10301, 27150, 54043)

select Spell.name_lang_en_gb,effect_bonus_coefficient_0 from spell where id in (467,782,1075,8914,9756,9910,26992,53307);
select Spell.name_lang_en_gb,effect_bonus_coefficient_0 from spell where id in (7294, 10298, 10299, 10300, 10301, 27150, 54043);
update spell set effect_bonus_coefficient_0 = 0.033 where id in (467,782,1075,8914,9756,9910,26992,53307);


-- Add Ability power scaling to Shadow Word Pain .1 per tick
select id,effect_bonus_coefficient_0 from spell where id in(589,594,970,992,2767,10892,10893,10894,15275,25367,25368,48124,48125);
update spell set effect_bonus_coefficient_0 = 0.1 where id in(589,594,970,992,2767,10892,10893,10894,15275,25367,25368,48124,48125);

-- Add Ability power scaling to corruption .06 per tick
select id, Spell.effect_bonus_coefficient_0 from spell where id in (172,6222,6223,7648,11671,11672,27216,25311,47812,47813);
update spell set effect_bonus_coefficient_0 = 0.06 where id in (172,6222,6223,7648,11671,11672,27216,25311,47812,47813);

-- Add ability power scaling to immolate tick damage .06 per tick
select id, Spell.effect_bonus_coefficient_0 from spell where id in (348,707,1094,2941,11665,11667,11668,25309,27215);
update spell set effect_bonus_coefficient_0 = 0.06 where id in (348,707,1094,2941,11665,11667,11668,25309,27215);


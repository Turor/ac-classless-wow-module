-- Add ability power scaling to thorns
-- in (467,782,1075,8914,9756,9910,26992,53307) THORNS
-- in (7294, 10298, 10299, 10300, 10301, 27150, 54043)

select Spell.name_lang_en_gb,effect_bonus_coefficient_0 from spell where id in (467,782,1075,8914,9756,9910,26992,53307);
select Spell.name_lang_en_gb,effect_bonus_coefficient_0 from spell where id in (7294, 10298, 10299, 10300, 10301, 27150, 54043);
update spell set effect_bonus_coefficient_0 = 0.033 where id in (467,782,1075,8914,9756,9910,26992,53307);
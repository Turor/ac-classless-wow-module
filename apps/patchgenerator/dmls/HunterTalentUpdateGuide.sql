-- Careful Aim needs effect 2 268
select * from spell where id in (34482,34483,34484);

select id,
       effect_aura_0, effect_die_sides_0, effect_base_points_0, implicit_target_a_0, effect_bonus_coefficient_0, effect_chain_amplitude_0, effect_misc_value_0, effect_misc_value_b_0,
       effect_aura_1, effect_die_sides_1, effect_base_points_1, implicit_target_a_1, effect_bonus_coefficient_1, effect_chain_amplitude_1, effect_misc_value_1, effect_misc_value_b_1,
       name_lang_en_gb, description_lang_en_gb
from Spell where id in (34482,34483,34484);

update Spell
Set effect_aura_1 = 268, effect_misc_value_1=3, effect_misc_value_b_1=3, /*effect_die_sides_1=1,*/ implicit_target_a_1=1, effect_base_points_1=0, effect_bonus_coefficient_1=1, effect_chain_amplitude_1=1,
    description_lang_en_gb = 'Increases your Ranged and Melee Attack Power by $s1% of your Intellect.'
where id in (34482,34483,34484);

update Spell set effect_base_points_1 = 99 where id = 34482;
update Spell set effect_base_points_1 = 199 where id = 34483;
update Spell set effect_base_points_1 = 299 where id = 34484;

-- Change Serpent's Swiftness to be 5% haste per and affect both melee and ranged

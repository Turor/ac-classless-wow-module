-- Elemental Devastation (WORKS)
-- Elemental Fury
select id, Spell.effect_aura_0, Spell.effect_misc_value_0, spell.proc_type_mask, Spell.effect_spell_class_mask_a_0, Spell.effect_spell_class_mask_b_0,
       Spell.effect_spell_class_mask_c_0, name_lang_en_gb, description_lang_en_gb
from Spell where id in (16089,60184,60185,60187,60188);

update Spell
set effect_aura_0 = 163, effect_misc_value_0 = 126, effect_spell_class_mask_a_0=997, effect_spell_class_mask_b_0=0, effect_spell_class_mask_c_0=0
where id in (16089,60184,60185,60187,60188);

-- Elemental Focus (WORKS)
-- Novas sharing cooldown??
-- Fire Blast and Fire Shock sharing same cooldowns??
-- Elemental Precision (WORKS)
-- Elemental oath
select id, Spell.effect_aura_0, Spell.effect_misc_value_0, spell.proc_type_mask, Spell.effect_spell_class_mask_a_0, Spell.effect_spell_class_mask_b_0,
       Spell.effect_spell_class_mask_c_0, name_lang_en_gb, description_lang_en_gb
from Spell where id in (51466,51470);

update Spell
set effect_aura_0 = 57, effect_misc_value_0 = 126, effect_spell_class_mask_a_0=0, effect_spell_class_mask_b_0=0, effect_spell_class_mask_c_0=0
where id in (51466,51470);

update Spell
set effect_aura_1 = 79, effect_misc_value_1 = 126, effect_spell_class_mask_a_1=0, effect_spell_class_mask_b_1=0, effect_spell_class_mask_c_1=0
where id in (51466,51470);

-- Tidal Mastery
select id, Spell.effect_die_sides_0, Spell.effect_base_points_0, Spell.effect_aura_0, Spell.effect_misc_value_0, spell.proc_type_mask, Spell.effect_spell_class_mask_a_0, Spell.effect_spell_class_mask_b_0,
       Spell.effect_spell_class_mask_c_0, name_lang_en_gb, description_lang_en_gb
from Spell where id in (16194,16218,16219,16220,16221);

update Spell
set effect_aura_0 = 57, effect_misc_value_0 = 126, effect_spell_class_mask_a_0=0, effect_spell_class_mask_b_0=0, effect_spell_class_mask_c_0=0, effect_base_points_0 = 1,
    description_lang_en_gb = 'Increases the critical effect chance of your spells by $s1%.'
where id in (16194,16218,16219,16220,16221);

update Spell set effect_base_points_0 = 3 where id = 16218;
update Spell set effect_base_points_0 = 5 where id = 16219;
update Spell set effect_base_points_0 = 7 where id = 16220;
update Spell set effect_base_points_0 = 9 where id = 16221;

-- Purification
select id, Spell.effect_aura_0, Spell.effect_misc_value_0, spell.proc_type_mask, Spell.effect_spell_class_mask_a_0, Spell.effect_spell_class_mask_b_0,
       Spell.effect_spell_class_mask_c_0, name_lang_en_gb, description_lang_en_gb
from Spell where id in (16178,16210,16211,16212,16213);

update Spell
set effect_aura_0 = 118, effect_misc_value_0 = 126, effect_spell_class_mask_a_0=0, effect_spell_class_mask_b_0=0, effect_spell_class_mask_c_0=0
where id in (16178,16210,16211,16212,16213);

-- Blessing of the Eternals
select id, Spell.effect_aura_0, Spell.effect_misc_value_0, spell.proc_type_mask, Spell.effect_spell_class_mask_a_0, Spell.effect_spell_class_mask_b_0,
       Spell.effect_spell_class_mask_c_0, name_lang_en_gb, description_lang_en_gb
from Spell where id in (51554,51555);

update Spell
set effect_aura_0 = 57, effect_misc_value_0 = 126, effect_spell_class_mask_a_0=0, effect_spell_class_mask_b_0=0, effect_spell_class_mask_c_0=0
where id in (51554,51555);

-- Mental Dexterity needs effect 2 with 212
select * from spell where id in (51883,51884,51885);

select id,
       effect_aura_0, effect_die_sides_0, effect_base_points_0, implicit_target_a_0, effect_bonus_coefficient_0, effect_chain_amplitude_0, effect_misc_value_0, effect_misc_value_b_0,
       effect_aura_1, effect_die_sides_1, effect_base_points_1, implicit_target_a_1, effect_bonus_coefficient_1, effect_chain_amplitude_1, effect_misc_value_1, effect_misc_value_b_1,
       name_lang_en_gb, description_lang_en_gb
from Spell where id in (51883,51884,51885);

update Spell
Set effect_aura_1 = 212, effect_misc_value_1=3, effect_misc_value_b_1=3, effect_die_sides_1=1, implicit_target_a_1=1, /*effect_base_points_1=0,*/ effect_bonus_coefficient_1=0, effect_chain_amplitude_1=1,
    description_lang_en_gb = 'Increases your Ranged and Melee Attack Power by $s1% of your Intellect.'
where id in (51883,51884,51885);

update Spell set effect_base_points_1 = 99 where id = 51883;
update Spell set effect_base_points_1 = 199 where id = 51884;
update Spell set effect_base_points_1 = 299 where id = 51885;

-- Shaman Flurry to proc on ranged crits and add ranged haste
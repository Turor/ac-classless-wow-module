-- Make Mace Specialization and Hack and Slash be consistent
-- Mace Specialization
select * from ItemSubClass where display_name_lang_en_gb like '%Mace%';

select id, equipped_item_subclass, Spell.effect_aura_0, Spell.effect_misc_value_0, spell.proc_type_mask, Spell.effect_spell_class_mask_a_0, Spell.effect_spell_class_mask_b_0,
       Spell.effect_spell_class_mask_c_0, name_lang_en_gb, description_lang_en_gb
from Spell where id in (13709,13800,13801,13802,13803);

update Spell
set equipped_item_subclass = 48
where id in (13709,13800,13801,13802,13803);

-- Hack and Slash
select * from ItemSubClass where display_name_lang_en_gb like '%Sword%' or display_name_lang_en_gb like '%Axe%';
-- 1+2+2^7+2^8 = 387

select id, equipped_item_subclass, Spell.effect_aura_0, Spell.effect_misc_value_0, spell.proc_type_mask, Spell.effect_spell_class_mask_a_0, Spell.effect_spell_class_mask_b_0,
       Spell.effect_spell_class_mask_c_0, name_lang_en_gb, description_lang_en_gb
from Spell where id in (13960,13961,13962,13963,13964);

update Spell
set equipped_item_subclass = 387
where id in (13960,13961,13962,13963,13964);

-- Malice Update to total crit change
-- 52 for melee
-- 57 for spell

select * from spell where id in (14138,14139,14140,14141,14142);

select id,
       effect_aura_0, effect_die_sides_0, effect_base_points_0, implicit_target_a_0, effect_bonus_coefficient_0, effect_chain_amplitude_0,
       effect_aura_1, effect_die_sides_1, effect_base_points_1, implicit_target_a_1, effect_bonus_coefficient_1, effect_chain_amplitude_1,
        name_lang_en_gb, description_lang_en_gb
from Spell where id in (14138,14139,14140,14141,14142);

update Spell
Set effect_aura_1 = 57, effect_die_sides_1=1, implicit_target_a_1=1, effect_base_points_1=1, effect_bonus_coefficient_1=1, effect_chain_amplitude_1=1,
    description_lang_en_gb = 'Increases your chance to get a critical strike with all spells and attacks by $s1%.'
where id in (14138,14139,14140,14141,14142);

update Spell set effect_base_points_1 = 0 where id = 14138;
update Spell set effect_base_points_1 = 1 where id = 14139;
update Spell set effect_base_points_1 = 2 where id = 14140;
update Spell set effect_base_points_1 = 3 where id = 14141;
update Spell set effect_base_points_1 = 4 where id = 14142;
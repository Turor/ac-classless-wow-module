-- Ice Shards
select id, Spell.effect_aura_0, Spell.effect_misc_value_0, spell.proc_type_mask, Spell.effect_spell_class_mask_a_0, Spell.effect_spell_class_mask_b_0,
       Spell.effect_spell_class_mask_c_0, name_lang_en_gb, description_lang_en_gb
from Spell where id in (11207,12672,15047);

update Spell
set effect_aura_0 = 163, effect_misc_value_0 = 16, effect_spell_class_mask_a_0=997, effect_spell_class_mask_b_0=0, effect_spell_class_mask_c_0=0
where id in (11207,12672,15047);

-- Piercing Ice
select id, Spell.effect_aura_0, Spell.effect_misc_value_0, spell.proc_type_mask, Spell.effect_spell_class_mask_a_0, Spell.effect_spell_class_mask_b_0,
       Spell.effect_spell_class_mask_c_0, name_lang_en_gb, description_lang_en_gb
from Spell where id in (11207,12672,15047);

update Spell
set effect_aura_0 = 79, effect_misc_value_0 = 16, effect_spell_class_mask_a_0=997, effect_spell_class_mask_b_0=0, effect_spell_class_mask_c_0=0
where id in (11151,12952,12953);

-- Frost Channeling
select id, Spell.effect_aura_0, Spell.effect_misc_value_0, spell.proc_type_mask, Spell.effect_spell_class_mask_a_0, Spell.effect_spell_class_mask_b_0,
       Spell.effect_spell_class_mask_c_0, name_lang_en_gb, description_lang_en_gb
from Spell where id in (11160,12518,12519);

update Spell
set description_lang_en_gb = 'Reduces the mana cost of all Mage Frost Spells by $s1% and reduces the threat caused by your Frost spells by $s2%.'
where id in (11160,12518,12519);

-- Shatter (NEEDS TESTING)
-- select id, Spell.effect_aura_0, Spell.effect_misc_value_0, spell.proc_type_mask, Spell.effect_spell_class_mask_a_0, Spell.effect_spell_class_mask_b_0,
--        Spell.effect_spell_class_mask_c_0, name_lang_en_gb, description_lang_en_gb
-- from Spell where id in (11207,12672,15047);
--
-- update Spell
-- set effect_aura_0 = 79, effect_misc_value_0 = 16, effect_spell_class_mask_a_0=997, effect_spell_class_mask_b_0=0, effect_spell_class_mask_c_0=0
-- where id in (11151,12952,12953);

-- Arctic Winds (WORKS)
-- Arcane Focus (WORKS)
-- Arcane Concentration (NEEDS TESTING)
-- Focus Magic (WORKS)
-- Arcane Potency (WORKS)
-- Arcane Power (WORKS)
-- Spell Power
select id, Spell.effect_aura_0, Spell.effect_misc_value_0, spell.proc_type_mask, Spell.effect_spell_class_mask_a_0, Spell.effect_spell_class_mask_b_0,
       Spell.effect_spell_class_mask_c_0, name_lang_en_gb, description_lang_en_gb
from Spell where id in (35578,35581);

update Spell
set effect_aura_0 = 163, effect_misc_value_0 = 16, effect_spell_class_mask_a_0=997, effect_spell_class_mask_b_0=0, effect_spell_class_mask_c_0=0
where id in (35578,35581);

-- REDO fire talents if needed
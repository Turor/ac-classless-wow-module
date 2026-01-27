-- Holy Power
select id, Spell.effect_aura_0, Spell.effect_misc_value_0, spell.proc_type_mask, Spell.effect_spell_class_mask_a_0, Spell.effect_spell_class_mask_b_0,
       Spell.effect_spell_class_mask_c_0, name_lang_en_gb, description_lang_en_gb
from Spell where id in (5923,5924,5925,5926,25829);

update Spell
set effect_aura_0 = 57, effect_misc_value_0 = 2, effect_spell_class_mask_a_0=0, effect_spell_class_mask_b_0=0, effect_spell_class_mask_c_0=0
where id in (5923,5924,5925,5926,25829);

-- Judgements of the pure to affect ranged haste as well
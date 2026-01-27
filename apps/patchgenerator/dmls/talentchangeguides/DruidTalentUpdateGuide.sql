-- Omen of Clarity (WORKS)
-- Gift of Nature
select id, Spell.effect_aura_0, Spell.effect_misc_value_0, spell.proc_type_mask, Spell.effect_spell_class_mask_a_0, Spell.effect_spell_class_mask_b_0,
       Spell.effect_spell_class_mask_c_0, name_lang_en_gb, description_lang_en_gb
from Spell where id in (17104,24943, 24944,24945,24946);

update Spell
set description_lang_en_gb='Increases the effect of all nature healing spells by $s1%.'
where id in (17104,24943, 24944,24945,24946);
-- Natural Perfection (WORKS)
-- Genesis
select id, Spell.effect_aura_0, Spell.effect_misc_value_0, spell.proc_type_mask, Spell.effect_spell_class_mask_a_0, Spell.effect_spell_class_mask_b_0,
       Spell.effect_spell_class_mask_c_0, name_lang_en_gb, description_lang_en_gb
from Spell where id in (57810,57811, 57812,57813,57814);

update Spell
set description_lang_en_gb='Increases the damage and healing done by your periodic nature spell damage and healing effects by $s1%.'
where id in (57810,57811, 57812,57813,57814);
-- Nature's Grace (WORKS- Needs testing)
-- Starlight Wrath
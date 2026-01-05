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
select id, Spell.effect_aura_0, Spell.effect_misc_value_0, spell.proc_type_mask, Spell.effect_spell_class_mask_a_0, Spell.effect_spell_class_mask_b_0,
       Spell.effect_spell_class_mask_c_0, name_lang_en_gb, description_lang_en_gb
from Spell where id in (16194,16218,16219,16220,16221);

update Spell
set effect_aura_0 = 57, effect_misc_value_0 = 126, effect_spell_class_mask_a_0=0, effect_spell_class_mask_b_0=0, effect_spell_class_mask_c_0=0, effect_base_points_0 = 1,
    description_lang_en_gb = 'Increases the critical effect chance of your spells by $s1%.'
where id in (16194,16218,16219,16220,16221);

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
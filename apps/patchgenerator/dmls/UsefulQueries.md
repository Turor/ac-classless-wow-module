

# Skill Line Ability
```sql
update SkillLineAbility
set class_mask=2047
where SkillLineAbility.id in (
    select SkillLineAbility.id
    from SkillLineAbility
        join SkillLine on SkillLine.id=skill_line
        JOIN SkillLineCategory on SkillLine.category_id=SkillLineCategory.id
    WHERE SkillLine.display_name_lang_en_gb not like '%Racial%'
        AND SkillLine.display_name_lang_en_gb not like '%Language%'
        AND SkillLine.display_name_lang_en_gb not like '%Pet%');
```

Currently working:
- Talent
- SkillLineAbility
- ChrClasses
- SkillRaceClassInfo

Order:
Affliction
Arcane
Arms
Assassination
Balance
Beast Mastery
Blood
Combat
Demonology
Destruction
Discipline
Elemental
Enhancement
Feral Combat
Fire
Frost
Frost
Fury
Holy
Holy
Marksmanship
Protection
Protection
Restoration
Restoration
Retribution
Shadow
Subtlety
Survival
Unholy

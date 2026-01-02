-- 8 has lowest mana - Change all classes to this
-- 1 has highest hp  - Change all classes to this

UPDATE player_class_stats t1
    INNER JOIN player_class_stats t2
    ON t1.level = t2.level
        AND t2.class = 8
SET t1.BaseMana = t2.BaseMana
WHERE t1.class <> 8;

UPDATE player_class_stats t1
    INNER JOIN player_class_stats t2
    ON t1.level = t2.level
        AND t2.class = 1
SET t1.BaseHP = t2.BaseHP
WHERE t1.class <> 1;

update conditions con
set ConditionValue1 = 2047
where con.ConditionTypeOrReference = 15 -- All conditions related to class
  AND con.SourceTypeOrReferenceId = 14  -- All Gossip Menu related conditions
  AND comment not like '%%not%%';       -- All the class specific gossip menus

DELETE FROM conditions
WHERE ConditionTypeOrReference = 15     -- All conditions related to class
 AND SourceTypeOrReferenceId = 14       -- All Gossip Menu related conditions
 AND Comment LIKE '%%not%%';            -- All the non class specific gossip menus

update conditions con
set ConditionValue1 = 2047              -- Enable all classes
where con.ConditionTypeOrReference = 15 -- All conditions related to class
  AND con.SourceTypeOrReferenceId = 15; -- All gossip menu items
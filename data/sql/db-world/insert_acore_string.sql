SET @ENTRY:=35410;
DELETE FROM `acore_string` WHERE `entry`=@ENTRY;
INSERT INTO `acore_string` (`entry`, `content_default`, `locale_koKR`, `locale_frFR`, `locale_deDE`, `locale_zhCN`, `locale_zhTW`, `locale_esES`, `locale_esMX`, `locale_ruRU`) VALUES
(@ENTRY, 'Hello, welcome to our classless WoW experience! Trainers, Transmogrifiers, and Dungeon teleporter can be found in Stormwind Keep and Orgrimmar. Have fun! Take a look at who\'s online and message them to get an intro. Join our Discord at https://discord.gg/jFwS9CBx', '', '', '', '', '', '', '', '');

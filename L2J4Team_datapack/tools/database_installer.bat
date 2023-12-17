@echo off

REM ############################################
REM ## You can change here your own DB params ##
REM ############################################
echo Checking environment...
mysql --help >nul 2>nul
if errorlevel 1 goto nomysql
echo   - MySQL: OK

REM LOGINSERVER
set lsuser=root
set lspass=
set lsdb=l2jdb
set lshost=localhost

REM GAMESERVER
set gsuser=root
set gspass=Sa@26071989
set gsdb=l2jdb
set gshost=localhost
REM ############################################

echo.
echo.                        L2J4Team database installation
echo.                        __________________________
echo.
echo OPTIONS : (f) full install, it will destroy all (need validation).
echo           (s) skip characters data, it will install only static server tables.
echo.
:asklogin
set loginprompt=x
set /p loginprompt=Installation type: (f) full, (s) skip or (q) quit? 
if /i %loginprompt%==f goto fullinstall
if /i %loginprompt%==s goto lskip
if /i %loginprompt%==q goto end
goto asklogin

REM ############################################
:fullinstall

:validation
set jaja=x
set /p jaja=Are you sure to delete all databases, even characters (y/n) ? 
if /i %jaja%==y goto destruction
if /i %jaja%==n goto lskip
goto validation

:destruction
echo.
echo.
echo Deleting characters-related tables.
mysql -h %lshost% -u %lsuser% --password=%lspass% -D %lsdb% < full_install.sql
echo Done.
echo.
echo Installing empty character-related tables.
mysql -h %lshost% -u %lsuser% --password=%lspass% -D %lsdb% < ../sql/accounts.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/auctions.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/auction_table.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/augmentations.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/bookmarks.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/buffer_schemes.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/buylists.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/castle_doorupgrade.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/castle_manor_procure.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/castle_manor_production.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/castle_trapupgrade.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/character_friends.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/character_hennas.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/character_kills_info.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/character_kills_snapshot.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/character_macroses.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/character_mail.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/character_memo.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/character_offline_trade_items.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/character_offline_trade.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/character_quests.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/character_raid_points.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/character_recipebook.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/character_recommends.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/character_shortcuts.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/character_skills.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/character_skills_save.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/character_subclasses.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/characters.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/clan_data.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/clan_privs.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/clan_skills.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/clan_subpledges.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/clan_wars.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/clanhall.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/clanhall_functions.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/clanhall_siege_attackers.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/clanhall_siege_guards.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/cursed_weapons.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/fishing_championship.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/forums.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/games.sql
mysql -h %lshost% -u %lsuser% --password=%lspass% -D %lsdb% < ../sql/gameservers.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/grandboss_list.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/heroes_diary.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/heroes.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/items.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/items_on_ground.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/mdt_bets.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/mdt_history.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/mods_wedding.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/olympiad_data.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/olympiad_fights.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/olympiad_nobles_eom.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/olympiad_nobles.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/pets.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/posts.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/rainbowsprings_attacker_list.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/server_memo.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/seven_signs.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/seven_signs_festival.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/seven_signs_status.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/siege_clans.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/topic.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/hwid_bans.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/hwid_info.sql

echo Done.
echo.

REM ############################################
:lskip
echo Deleting server tables.
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < gs_install.sql
echo Done.
echo.
echo Installing server tables.
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/castle.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/grandboss_data.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/raidboss_spawnlist.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/random_spawn.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/random_spawn_loc.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/spawnlist_4s.sql
mysql -h %gshost% -u %gsuser% --password=%gspass% -D %gsdb% < ../sql/spawnlist.sql
REM ############################################
:end
echo.
echo Was fast, isn't it ?
pause

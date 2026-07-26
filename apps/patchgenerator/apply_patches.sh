#!/bin/bash

# Default database settings
SQLITE_DB=${SQLITE_DB:-"./wow_dbc/wrath_dbcs.sqlite"}

# Directory where this script is located
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

apply_sql_file() {
    local file_path="$1"
    if [ -f "$file_path" ]; then
        echo "Applying $file_path..."
        sqlite3 "$SQLITE_DB" < "$file_path"
        if [ $? -ne 0 ]; then
            echo "Error: Failed to apply $file_path"
        fi
    else
        echo "Warning: File not found $file_path"
    fi
}

apply_sql_dir() {
    local dir_name="$1"
    local target_dir="$BASE_DIR/$dir_name"
    if [ -d "$target_dir" ]; then
        echo "Applying all SQL files in $target_dir..."
        for f in "$target_dir"/*.sql; do
            [ -e "$f" ] || continue
            apply_sql_file "$f"
        done
    else
        echo "Warning: Directory not found $target_dir"
    fi
}

# 1. required patches
apply_sql_dir "required"

# 2. spellchangeguides
apply_sql_dir "spellchangeguides"

# 3. statfilemodifications
apply_sql_dir "statfilemodifications"

# 4. talentchangeguides (non-recursive)
echo "Applying SQL files in $BASE_DIR/talentchangeguides..."
for f in "$BASE_DIR/talentchangeguides"/*.sql; do
    [ -e "$f" ] || continue
    apply_sql_file "$f"
done

# 5. customtalents
apply_sql_dir "talentchangeguides/CustomTalents"

# 6. TalentTabTweaks.sql
apply_sql_file "$BASE_DIR/TalentTabTweaks.sql"

# 7. SkillRaceClassInfoUpdateGuide.sql
apply_sql_file "$BASE_DIR/SkillRaceClassInfoUpdateGuide.sql"

echo "Finished applying patches."

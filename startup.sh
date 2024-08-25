#! /bin/bash
echo "Path Of Titans Egg by Marcel Baumgartner"
echo "(c) Copyright 2022 endelon-hosting.de"
echo "Checking for updates"
SERVER_NAME=${SERVER_NAME:-MyPathOfTitansServer}
MAX_PLAYERS=${MAX_PLAYERS:-100}
SERVER_MAP=${SERVER_MAP:-Island}
./AlderonGamesCmd --game path-of-titans --server true --beta-branch $BETA_BRANCH --install-dir .
UE_TRUE_SCRIPT_NAME=$(echo \"$0\" | xargs readlink -f)
UE_PROJECT_ROOT=$(dirname "$UE_TRUE_SCRIPT_NAME")
chmod +x "$UE_PROJECT_ROOT/PathOfTitans/Binaries/Linux/PathOfTitansServer-Linux-Shipping"
"$UE_PROJECT_ROOT/PathOfTitans/Binaries/Linux/PathOfTitansServer-Linux-Shipping" PathOfTitans -log -ServerListIP=104.234.220.122 -Port=$SERVER_PORT -BranchKey=$BETA_BRANCH -AuthToken=$AG_AUTH_TOKEN -ServerGUID=$SERVER_GUID -Database=Local ${SERVER_MAP}?listen?MaxPlayers=${MAX_PLAYERS} -ServerName="${SERVER_NAME}" -log

#! /bin/bash
echo "Path Of Titans Egg by Marcel Baumgartner"
echo "(c) Copyright 2022 endelon-hosting.de"
echo "Checking for updates"
SERVER_NAME=${SERVER_NAME:-MyPathOfTitansServer}
MAX_PLAYERS=${MAX_PLAYERS:-100}
SERVER_MAP=${SERVER_MAP:-Island}
CONFIG_FILE="/home/container/PathOfTitans/Saved/Config/LinuxServer/Game.ini"
./AlderonGamesCmd --game path-of-titans --server true --beta-branch $BETA_BRANCH --install-dir .
UE_TRUE_SCRIPT_NAME=$(echo \"$0\" | xargs readlink -f)
UE_PROJECT_ROOT=$(dirname "$UE_TRUE_SCRIPT_NAME")
mkdir -p /home/container/PathOfTitans/Saved/Config/LinuxServer
touch $CONFIG_FILE
if ! grep -q "^\[\/Script\/PathOfTitans.POTServerSettings\]" $CONFIG_FILE; then
    echo -e "\n[/Script/PathOfTitans.POTServerSettings]" >> $CONFIG_FILE
fi

# Replace or append the necessary settings in the correct section
sed -i "/^\[\/Script\/PathOfTitans.POTServerSettings\]/,/^\[/{s/^ServerName=.*/ServerName=${SERVER_NAME}/}" $CONFIG_FILE
sed -i "/^\[\/Script\/PathOfTitans.POTServerSettings\]/,/^\[/{s/^MaxPlayers=.*/MaxPlayers=${MAX_PLAYERS}/}" $CONFIG_FILE
sed -i "/^\[\/Script\/PathOfTitans.POTServerSettings\]/,/^\[/{s/^ServerMap=.*/ServerMap=${SERVER_MAP}/}" $CONFIG_FILE

# If the keys don't exist in the section, add them
if ! grep -q "ServerName=" $CONFIG_FILE; then
    sed -i "/^\[\/Script\/PathOfTitans.IGameSession\]/a ServerName=${SERVER_NAME}" $CONFIG_FILE
fi

if ! grep -q "MaxPlayers=" $CONFIG_FILE; then
    sed -i "/^\[\/Script\/PathOfTitans.IGameSession\]/a MaxPlayers=${MAX_PLAYERS}" $CONFIG_FILE
fi

if ! grep -q "ServerMap=" $CONFIG_FILE; then
    sed -i "/^\[\/Script\/PathOfTitans.IGameSession\]/a ServerMap=${SERVER_MAP}" $CONFIG_FILE
fi
chmod +x "$UE_PROJECT_ROOT/PathOfTitans/Binaries/Linux/PathOfTitansServer-Linux-Shipping"
"$UE_PROJECT_ROOT/PathOfTitans/Binaries/Linux/PathOfTitansServer-Linux-Shipping" PathOfTitans -log -ServerListIP=104.234.220.122 -Port=$SERVER_PORT -BranchKey=$BETA_BRANCH -AuthToken=$AG_AUTH_TOKEN -ServerGUID=$SERVER_GUID -Database=Local

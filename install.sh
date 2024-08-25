cd /mnt/server
apt update
apt install -y wget
wget -O AlderonGamesCmd https://launcher-cdn.alderongames.com/AlderonGamesCmd-Linux-x64
chmod +x AlderonGamesCmd
export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1
./AlderonGamesCmd --game path-of-titans --server true --beta-branch $BETA_BRANCH --install-dir .
echo "Creating folder for config files because this game is a weird one"
mkdir -p /mnt/server/PathOfTitans
mkdir -p /mnt/server/PathOfTitans/Saved
mkdir -p /mnt/server/PathOfTitans/Saved/Config
mkdir -p /mnt/server/PathOfTitans/Saved/Config/LinuxServer
wget -O /mnt/server/PathOfTitans/Saved/Config/LinuxServer/Game.ini https://raw.githubusercontent.com/Endelon-Hosting/eggs/main/pathoftitans/Game.ini
wget -O /mnt/server/startup.sh https://raw.githubusercontent.com/Endelon-Hosting/eggs/main/pathoftitans/startup.sh
echo "Installed"

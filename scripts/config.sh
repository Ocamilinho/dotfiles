#!/bin/bash
set -e

# Funções auxiliares
check_command() {
    if ! command -v "$1" &>/dev/null; then
        echo "Instalando dependência: $1"
        sudo apt install -y "$1"
    fi
}

check_github_authentication() {
    gh auth status &> /dev/null
    if [ $? -ne 0 ]; then
        echo "Faça login usando 'gh auth login'."
        exit 1 
    fi
}

# Verifica se o usuário está autenticado no GitHub
check_github_authentication


echo "Atualizando sistema e instalando ferramentas essenciais..."
sudo apt update && sudo apt upgrade -y
check_command git
check_command curl
check_command wget
check_command flatpak
check_command pip
check_command gpg

# Habilita Flathub
if ! flatpak remote-list | grep -q flathub; then
    echo "Adicionando repositório Flathub..."
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
fi

# Flatpak installs
echo "Instalando apps via Flatpak..."

FLATPAK_APPS=(
    one.ablaze.floorp
    com.discordapp.Discord
    de.haeckerfelix.Shortwave 
    org.localsend.localsend_app
    md.obsidian.Obsidian
    com.github.flxzt.rnote
    net.lutris.Lutris
    io.github.hrkfdn.ncspot
    com.github.tchx84.Flatseal
    org.telegram.desktop
    io.freetubeapp.FreeTube
)


for app in "${FLATPAK_APPS[@]}"; do
    flatpak install -y flathub "$app"
done

# Apt installs
echo "Instalando pacotes via APT..."

APT_APPS_INSTALL=(
    taskwarrior
    geany
    keepassxc
    okular
    tlp
    bat
    btop
    gparted
    vlc
    geany-plugins
    gh
    octave
    stow
    transmission
    tree
)

sudo apt install -y "${APT_APPS_INSTALL[@]}"

APT_APPS_REMOVE=(
    firefox
    libreoffice-*
    thunderbird
)

sudo apt remove -y "${APT_APPS_REMOVE[@]}"

# Ativando TLP
check_command tlp
echo "Configurando e ativando TLP..."
sudo systemctl enable tlp
sudo systemctl start tlp

# Geany themes
mkdir -p "$HOME/.config/geany/colorschemes/"
curl -o "$HOME/.config/geany/colorschemes/monokai.conf" https://raw.githubusercontent.com/geany/geany-themes/master/colorschemes/monokai.conf


# Positron (w)
echo "Baixando e instalando Positron..."

wget -q https://cdn.posit.co/positron/prereleases/deb/x86_64/Positron-2025.04.0-250-x64.deb
sudo apt install -y ./positron-2025.05.0-58.deb
rm positron-2025.05.0-58.deb

# Quarto (w)
echo "Baixando e instalando Quarto..."

wget https://quarto.org/download/latest/quarto-linux-amd64.deb
sudo apt install -y ./quarto-linux-amd64.deb
rm quarto-linux-amd64.deb

# FOLDERS
for dir in */ ; do
    if [ -d "$dir" ] && [ -z "$(ls -A "$dir")" ]; then
        rmdir "$dir"
    fi
done

FOLDERS=(
	tor
	tor/complete
	tor/incomplete
	docs
	downloads
	img
	data
)

for folder in "${FOLDERS[@]}"; do
	echo "Criando pasta: $folder"
    mkdir -v "$folder"
done


# Clonar repositórios
gh repo clone Ocamilinho/drive
gh repo clone Ocamilinho/pw

echo "All right!"


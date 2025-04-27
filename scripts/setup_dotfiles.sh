#!/bin/bash

DOTFILES_DIR='$HOME/dotfiles'
if ! command -v stow > /dev/null
then
	echo "stow não está instalado"
	sudo apt install stow
	exit 1
fi

apply_stow(){
	for dir in "$DOTFILES_DIR"/*; do
		if [ -d "$dir" ]; then
			echo "aplicando stow para $dir..."
			cd "$dir" && stow --adopt --targe="$HOME".
		fi
	done
}
echo "Este script vai vincular seus dotfiles para o diretório HOME."
read -p "Você quer continuar? (s/n): " resposta
if [[ "$resposta" =~ ^[Ss]$ ]]; then
    apply_stow
else
    echo "Cancelado."
    exit 0
fi

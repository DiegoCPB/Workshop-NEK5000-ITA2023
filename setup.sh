#!/usr/bin/bash

# Script para configuracao do ambiente NEK5000 no Ubuntu 22.04 e no Cluster home69 do ITA

# Parametros
TARGET="$HOME/Apps" # Pasta dos aplicativos

# Cria a pasta onde serao salvos os arquivos dos aplicativos
if [ ! -d $TARGET ]; then
    mkdir $TARGET
fi

# Para o caso de uma distribuicao Debian-like com acesso root 
# Pede senha do usuário
if [ "$(grep -Ei 'debian|buntu|mint' /etc/*release)" ]; then
    echo -e "\n######################"
    echo "Atualizacao do sistema"
    echo -e "######################\n"

    sudo apt update
    sudo apt -y upgrade

    echo -e "\n############"
    echo "Dependencias"
    echo -e "############\n"

    sudo apt -y install build-essential gfortran libopenmpi-dev # NEK5000
    sudo apt -y install cmake libx11-dev libxt-dev qtbase5-dev x11-apps # NEKtools e VisIt

    echo -e "\n#####################################"
    echo "Python, Numpy, MatPlotLib, Gmsh e Git"
    echo -e "#####################################\n"

    sudo apt -y install python3 python3-numpy python3-matplotlib gmsh git
fi

# Baixa o NEK5000 e o KTH_toolbox do repositorio do github
if [ ! -d "$TARGET/KTH_Framework" ]; then
    echo -e "\n#####################"
    echo "KTH_Toolbox e Nek5000"
    echo -e "#####################\n"
    git clone --recursive https://github.com/KTH-Nek5000/KTH_Framework $TARGET/KTH_Framework
fi

# Adiciona o NEK na path do sistema para o usuario atual
if [[ ":$PATH:" != *":$TARGET/KTH_Framework/Nek5000/bin:"* ]]; then
    echo -e '\n# Adiciona o caminho para a pasta do NEK5000' >> "$HOME/.bashrc"
    echo "export PATH=$TARGET/KTH_Framework/Nek5000/bin:\$PATH" >> "$HOME/.bashrc"
fi

# Instala o visit v3.3.3
if [ ! -d "$TARGET/Visit" ]; then
    echo -e "\n#####"
    echo "VisIt"
    echo -e "#####\n"
    wget --content-disposition https://github.com/visit-dav/visit/releases/download/v3.3.3/visit-install3_3_3
    chmod +x visit-install3_3_3
    if [ "$(grep -Ei 'buntu|mint' /etc/*release)" ]; then # Ubuntu ou Linux Mint
        wget --content-disposition https://github.com/visit-dav/visit/releases/download/v3.3.3/visit3_3_3.linux-x86_64-ubuntu20.tar.gz
        printf '1\n' | ./visit-install3_3_3 3.3.3 linux-x86_64-ubuntu20 "$TARGET/Visit"
        rm visit3_3_3.linux-x86_64-ubuntu20.tar.gz
    elif [ "$(grep -Ei 'rhel|fedora' /etc/*release)" ]; then # Cluster ITA-home69
        wget --content-disposition https://github.com/visit-dav/visit/releases/download/v3.3.3/visit3_3_3.linux-x86_64-rhel7-wmesa.tar.gz
        printf '1\n' | ./visit-install3_3_3 3.3.3 linux-x86_64-rhel7-wmesa "$TARGET/Visit"
        rm visit3_3_3.linux-x86_64-rhel7-wmesa.tar.gz
    fi
    rm visit-install3_3_3
fi

# Adiciona o Visit na path do sistema para o usuario atual
if [[ ":$PATH:" != *":$TARGET/Visit/bin:"* ]]; then
    echo -e '\n# Adiciona o caminho para a pasta do VisIt' >> "$HOME/.bashrc"
    echo "export PATH=$TARGET/Visit/bin:\$PATH" >> "$HOME/.bashrc"
fi

echo -e "\n#######################"
echo "Configuracao concluida!"
echo "#######################"

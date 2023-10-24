#!/usr/bin/bash

# Script para configuracao do ambiente NEK5000 no Ubuntu 22.04
# com aplicativos de visualizacao e geracao de malha

# Parametros
TARGET="$HOME/Apps" # Pasta dos aplicativos

###############################################################################
# Comandos que pedem senha de usuario

# Atualiza o sistema
sudo apt update

# Instala dependencias
sudo apt -y install build-essential gfortran libopenmpi-dev # NEK5000
sudo apt -y install cmake libx11-dev libxt-dev qtbase5-dev # NEKtools e VisIt

# Instala Python, Gmsh e Git
sudo apt -y install python3 gmsh git
###############################################################################

# Cria a pasta onde serao salvos os arquivos dos aplicativos
if [ ! -d $TARGET ]; then
    mkdir $TARGET
fi

# Baixa o NEK5000 v19 do repositorio do github e descompacta os arquivos
if [ ! -d "$TARGET/Nek5000" ]; then
    echo -e "\n#######"
    echo "Nek5000"
    echo -e "#######\n"
    wget --content-disposition "https://github.com/Nek5000/Nek5000/releases/download/v19.0/Nek5000-19.0.tar.gz"
    tar -xvf Nek5000-19.0.tar.gz -C $TARGET
    rm Nek5000-19.0.tar.gz
fi

# Adiciona o NEK na path do sistema para o usuario atual
if [[ ":$PATH:" != *":$TARGET/Nek5000/bin:"* ]]; then
    echo -e '\n# Adiciona o caminho para a pasta do NEK5000' >> ~/.bashrc
    echo "export PATH=$TARGET/Nek5000/bin:\$PATH" >> ~/.bashrc
fi

# Instala o visit v3.3.3
if [ ! -d "$TARGET/Visit" ]; then
    echo -e "\n#####"
    echo "VisIt"
    echo -e "#####\n"
    wget --content-disposition https://github.com/visit-dav/visit/releases/download/v3.3.3/visit3_3_3.linux-x86_64-ubuntu20.tar.gz
    wget --content-disposition https://github.com/visit-dav/visit/releases/download/v3.3.3/visit-install3_3_3
    chmod +x visit-install3_3_3
    printf '1\n' | ./visit-install3_3_3 3.3.3 linux-x86_64-ubuntu20 "$TARGET/Visit"
    rm visit3_3_3.linux-x86_64-ubuntu20.tar.gz
    rm visit-install3_3_3
fi

# Adiciona o Visit na path do sistema para o usuario atual
if [[ ":$PATH:" != *":$TARGET/Visit/bin:"* ]]; then
    echo -e '\n# Adiciona o caminho para a pasta do VisIt' >> ~/.bashrc
    echo "export PATH=$TARGET/Visit/bin:\$PATH" >> ~/.bashrc
fi

# Instala o Paraview v5.11.2
# A versao do Paraview disponivel no repositorio do Ubuntu nao tras suporte ao NEK5000
if [ ! -d "$TARGET/Paraview" ]; then
    echo -e "\n########"
    echo "ParaView"
    echo -e "########\n"
    wget --content-disposition "https://www.paraview.org/paraview-downloads/download.php?submit=Download&version=v5.11&type=binary&os=Linux&downloadFile=ParaView-5.11.2-MPI-Linux-Python3.9-x86_64.tar.gz"
    tar -xvf ParaView-5.11.2-MPI-Linux-Python3.9-x86_64.tar.gz -C $TARGET 
    mv $TARGET/ParaView-5.11.2-MPI-Linux-Python3.9-x86_64 $TARGET/Paraview 
    rm ParaView-5.11.2-MPI-Linux-Python3.9-x86_64.tar.gz
fi

# Adiciona o Paraview na path do sistema para o usuario atual
if [[ ":$PATH:" != *":$TARGET/Paraview/bin:"* ]]; then
    echo -e '\n# Adiciona o caminho para a pasta do Paraview' >> ~/.bashrc
    echo "export PATH=$TARGET/Paraview/bin:\$PATH" >> ~/.bashrc
fi

echo -e "\n#######################"
echo "Configuracao concluida!"
echo "#######################"
#!/bin/bash

###########################################################
#
# OpenCV 3.0.0 alpha - instala��o
# http://opencv.org/
#
###########################################################

#----------------------------------------------------------
# Criando um logger para registrar a instala��o
#----------------------------------------------------------
# Tempo: in�cio
dateformat="+%a %b %-eth %Y %I:%M:%S %p %Z"
starttime=$(date "$dateformat")
starttimesec=$(date +%s)

# Pega o diret�rio atual
curdir=$(cd `dirname $0` && pwd)

# Cria o arquivo onde as a��es ficar�o registradas
logfile="$curdir/install-opencv.log"
rm -f $logfile

# Logger simples
log(){
	timestamp=$(date +"%Y-%m-%d %k:%M:%S")
	echo "\n$timestamp $1"
	echo "$timestamp $1" >> $logfile 2>&1
}
 
# Iniciando a instala��o do OpenCV 2.3.1
log "Iniciando a instala��o do OpenCV 2.3.1"


#----------------------------------------------------------
# Assegurando um ambiente atualizado
#----------------------------------------------------------

# Informa ao usu�rio a pr�xima a��o
log "Executando apt-get update e apt-get upgrade"
 
# Executa a a��o
sudo apt-get update
sudo apt-get upgrade

 
#----------------------------------------------------------
# Instalando os pacotes das depend�ncias
#----------------------------------------------------------

log "Instalando as depend�ncias"
 
# Executa a a��o
sudo apt-get -y install libopencv-dev build-essential cmake git libgtk2.0-dev pkg-config python-dev python-numpy libdc1394-22 libdc1394-22-dev libjpeg-dev libpng12-dev libtiff4-dev libjasper-dev libavcodec-dev libavformat-dev libswscale-dev libxine-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libv4l-dev libtbb-dev libqt4-dev libfaac-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev libvorbis-dev libxvidcore-dev x264 v4l-utils unzip
 
 
#----------------------------------------------------------
# Instalando OpenCV
#----------------------------------------------------------

log "Baixando a biblioteca OpenCV 2.3.1"
 
# Defini��o de constante
FOLDER_NAME="opencv"
 
# Cria um novo diret�rio para armazenar o c�digo-fonte
mkdir ${FOLDER_NAME}
 
# Entra no diret�rio
cd ${FOLDER_NAME}
 
# Baixa o c�digo-fonte
#wget https://github.com/Itseez/opencv/archive/3.0.0-alpha.zip -O opencv-3.0.0-alpha.zip
wget http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/2.3.1/OpenCV-2.3.1a.tar.bz2/download
 
# Extrai o conte�do
tar -jxvf OpenCV-2.3.1a.tar.bz2

log "Instalando a biblioteca OpenCV 2.3.1"
 
# Entra no diret�rio
cd OpenCV-2.3.1a
 
# Cria um diret�rio chamado 'build'
mkdir build
 
# Entra no diret�rio
cd build
 
# Constr�i o projeto usando CMake
#cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_TBB=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D WITH_V4L=ON -D WITH_QT=ON -D WITH_OPENGL=ON -D WITH_FFMPEG=OFF ..
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_TBB=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D WITH_V4L=ON -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=ON -D WITH_QT=ON -D WITH_OPENGL=ON -DENABLE_PRECOMPILED_HEADERS=OFF ..
 
# Compila o projeto
make -j $(nproc)
 
# Instala as bibliotecas na pasta apropriada
sudo make install
 
# Adiciona o caminho das bibliotecas do OpenCV aos caminhos de pesquisa de biblioteca padr�o do Ubuntu
sudo /bin/bash -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf'
 
# Atualiza os caminhos de pesquisa de biblioteca padr�o do Ubuntu
sudo ldconfig
 
# Informa ao usu�rio que o OpenCV foi instalado com sucesso!
log "OpenCV 2.3.1 foi instalado com sucesso!"

#----------------------------------------------------------
# Mostra tempo gasto com a instala��o
#----------------------------------------------------------

# Tempo: fim
endtime=$(date "$dateformat")
endtimesec=$(date +%s)

# Mostra tempo gasto com a instala��o
elapsedtimesec=$(expr $endtimesec - $starttimesec)
ds=$((elapsedtimesec % 60))
dm=$(((elapsedtimesec / 60) % 60))
dh=$((elapsedtimesec / 3600))
displaytime=$(printf "%02d:%02d:%02d" $dh $dm $ds)
log "Tempo gasto: $displaytime\n"

sudo apt update
sudo apt -y upgrade

sudo apt -y install nvidia-driver-418
sudo apt -y install nvidia-cuda-toolkit clinfo
sudo apt -y install build-essential cmake pkg-config unzip yasm git gfortran
sudo apt -y install libjpeg-turbo8-dev libtiff5-dev libpng-dev
sudo apt -y install libavcodec-dev libavformat-dev libswscale-dev
sudo apt -y install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev
sudo apt -y install libxvidcore-dev x264 libx264-dev libfaac-dev libmp3lame-dev libtheora-dev libvorbis-dev
sudo apt -y install libdc1394-22 libdc1394-22-dev libxine-dev libv4l-dev v4l-utils
sudo apt -y install libgtk-3-dev
sudo apt -y install python-dev python-pip python3-dev python3-pip

pip2 install numpy
pip3 install numpy

sudo apt -y install libtbb-dev
sudo apt -y install libatlas-base-dev gfortran
sudo apt -y install libprotobuf-dev protobuf-compiler
sudo apt -y install libgoogle-glog-dev libgflags-dev
sudo apt -y install libgphoto2-dev libeigen3-dev libhdf5-dev doxygen

sudo rm -rf opencv*-3.4.5

wget -O opencv.zip https://github.com/opencv/opencv/archive/3.4.5.zip
wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/3.4.5.zip

echo Unzipping files
unzip opencv.zip > /dev/null
unzip opencv_contrib.zip > /dev/null

cd opencv-3.4.5
mkdir build
cd build

PY2INCLUDE=$(python2 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())")
PY2LIB=$(python2 -c "import distutils.sysconfig as sysconfig; print(sysconfig.get_config_var('LIBDIR'))")
PY3INCLUDE=$(python3 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())")
PY3LIB=$(python3 -c "import distutils.sysconfig as sysconfig; print(sysconfig.get_config_var('LIBDIR'))")

PYTHON3_INCLUDE_DIRS=$(python3 -c "import distutils.sysconfig as sysconfig; print(sysconfig.get_config_var('LIBDIR'))")
PYTHON3_LIBRARIES=$(locate libpython3 | grep 'anaconda3/lib/lib' |grep m.so$)

NUMPY_INCLUDE=$(locate numpy | grep anaconda3/lib | grep 'numpy/core/include$')

echo
echo \n\nLIB LOCATIONS.......
echo $PY2INCLUDE
echo $PY2LIB
echo $PY3INCLUDE
echo $PY3LIB


cmake \
    -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D WITH_CUDA=ON \
    -D ENABLE_FAST_MATH=1 \
    -D CUDA_FAST_MATH=1 \
    -D WITH_CUBLAS=1 \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D WITH_TBB=ON \
    -D WITH_V4L=ON \
    -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-3.4.5/modules \
    -D BUILD_EXAMPLES=ON .. \
    -D BUILD_NEW_PYTHON_SUPPORT=ON \
    -D BUILD_opencv_python3=ON \
    -D HAVE_opencv_python3=ON \
    -D PYTHON_INCLUDE_DIR=$PY2INCLUDE \
    -D PYTHON_LIBRARY=$PY2LIB \
    -D PYTHON3_INCLUDE_DIR=$PY3INCLUDE \
    -D PYTHON3_LIBRARY=$PY3LIB \
    -D PYTHON3_NUMPY_INCLUDE_DIRS=$NUMPY_INCLUDE \
    -D BUILD_SHARED_LIBS=ON  \
    -D OPENCV_ENABLE_NONFREE=ON  \
    -D PYTHON_DEFAULT_EXECUTABLE=`which python3` \
    -D BUILD_opencv_cudacodec=OFF
    	

make -j 16 -l 8.0 
sudo make install

cd ~/anaconda3/lib/python3.6/site-packages/
ln -s /usr/local/lib/python3.6/site-packages/cv2/python-3.6/cv2.cpython-36m-x86_64-linux-gnu.so cv2.so

echo If you want to use the compiled cv2.so in a future environment, the path is:
echo /usr/local/lib/python3.6/site-packages/cv2/python-3.6/cv2.cpython-36m-x86_64-linux-gnu.so
echo 
echo You will want to ln -s the file into your 
echo ~/anaconda3/envs/ENVNAME/lib/python3.6/site-packages/ directory.
echo
echo Please make a note of it.
echo 

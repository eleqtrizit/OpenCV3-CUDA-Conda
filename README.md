# OpenCV3-CUDA-Conda
A installation script for environments where Ubuntu 19.04, Python 3, CUDA 10.+ and Anaconda3 are installed.

If you want to use the compiled cv2.so in another conda environment, the path is:
**/usr/local/lib/python3.6/site-packages/cv2/python-3.6/cv2.cpython-36m-x86_64-linux-gnu.so**

You will want to ln -s the file into your
**~/anaconda3/envs/ENVNAME/lib/python3.6/site-packages/** directory.

Example sequence of commands:<br>
**cd ~/anaconda3/envs/ENVNAME/lib/python3.6/site-packages/;<br>
ln -s /usr/local/lib/python3.6/site-packages/cv2/python-3.6/cv2.cpython-36m-x86_64-linux-gnu.so**

The script installs the library in the base Anaconda environment.

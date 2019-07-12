# OpenCV3-CUDA-Conda
A installation script for environments where Python 3.6, CUDA 10.0 and Anaconda3 is installed.

If you use another Python, the changes in the script are minor.  Just search and replace 3.6 with your version.  I will make the update to eliminate this extra step in the future.

If you want to use the compiled cv2.so in a future environment, the path is:
/usr/local/lib/python3.6/site-packages/cv2/python-3.6/cv2.cpython-36m-x86_64-linux-gnu.so

You will want to ln -s the file into your
~/anaconda3/envs/ENVNAME/lib/python3.6/site-packages/ directory.

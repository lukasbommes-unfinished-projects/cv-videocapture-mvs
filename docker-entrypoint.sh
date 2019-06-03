#!/bin/sh
set -e

# build shared library (h264extract.so)
#g++ -I ~/boost -I /usr/include/python3.6m/ -fpic video_cap.cpp h264extract.cpp -shared -o h264extract.so -L ~/boost/stage/lib -lboost_python36 -lboost_numpy36 -lpython3.6m `pkg-config --cflags --libs libavformat libswscale opencv4` -Wl,-Bsymbolic
#python3 setup.py install


# build C++ demo (main.cpp)
#g++ -I ~/boost -I /usr/include/python3.6m/ -fpic main.cpp video_cap.cpp -o main -L ~/boost/stage/lib -lboost_python36 -lboost_numpy36 -lpython3.6m `pkg-config --cflags --libs libavformat libswscale opencv4` -Wl,-Bsymbolic


#g++ -I ~/boost -I /usr/include/python3.6m/ -fpic video_cap.cpp python_nogil.cpp -shared -o python_nogil.so -L ~/boost/stage/lib -lboost_python36 -lboost_numpy36 -lpython3.6m `pkg-config --cflags --libs libavformat libswscale opencv4` -Wl,-Bsymbolic
#g++ -I ~/boost -I /usr/include/python3.6m/ -fpic python_nogil.cpp video_cap.cpp -o python_nogil -L ~/boost/stage/lib -lboost_python36 -lboost_numpy36 -lpython3.6m `pkg-config --cflags --libs libavformat libswscale opencv4` -Wl,-Bsymbolic


exec "$@"

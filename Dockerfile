FROM ubuntu:18.04

ENV HOME "/home"


# Install tools
RUN \
  apt-get update && apt-get upgrade -y && \
  apt-get install -y \
    wget \
    unzip \
    build-essential \
    cmake \
    git \
    pkg-config \
    autoconf \
    automake \
    git-core


# Install gstreamer and opencv dependencies
RUN \
  apt-get update && apt-get upgrade -y && \
  apt-get install -y \
    libgtk-3-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libv4l-dev \
    libxvidcore-dev \
    libx264-dev \
    libx265-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libgtk-3-dev \
    libatlas-base-dev \
    gfortran \
    openexr \
    libatlas-base-dev \
    libtbb2 \
    libtbb-dev \
    libdc1394-22-dev \
    python3-dev \
    python3-pip \
    python3-numpy


# Download OpenCV and build from source
RUN \
  cd ${HOME} && \
  wget -O ${HOME}/opencv.zip https://github.com/opencv/opencv/archive/4.1.0.zip && \
  unzip ${HOME}/opencv.zip && \
  mv ${HOME}/opencv-4.1.0/ ${HOME}/opencv/ && \
  rm -rf ${HOME}/opencv.zip && \
  wget -O ${HOME}/opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.1.0.zip && \
  unzip ${HOME}/opencv_contrib.zip && \
  mv ${HOME}/opencv_contrib-4.1.0/ ${HOME}/opencv_contrib/ && \
  rm -rf ${HOME}/opencv_contrib.zip && \
  \
  cd ${HOME}/opencv && \
  mkdir build && \
  cd build && \
  cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D OPENCV_GENERATE_PKGCONFIG=YES \
    -D CMAKE_INSTALL_PREFIX=/usr/local
    -D INSTALL_C_EXAMPLES=ON \
    -D OPENCV_ENABLE_NONFREE=ON \
    -D INSTALL_PYTHON_EXAMPLES=OFF \
    -D OPENCV_EXTRA_MODULES_PATH=${HOME}/opencv_contrib/modules \
    -D WITH_GSTREAMER=ON \
    -D WITH_GSTREAMER_0_10=OFF \
    -D BUILD_EXAMPLES=ON .. && \
  \
  cd ${HOME}/opencv/build && \
  make -j $(nproc) && \
  make install && \
  ldconfig


# Install Python packages
COPY requirements.txt /
RUN pip3 install --upgrade pip
RUN pip3 install -r /requirements.txt

WORKDIR /development

COPY docker-entrypoint.sh /development
RUN chmod +x /development/docker-entrypoint.sh

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD ["sh", "-c", "tail -f /dev/null"]

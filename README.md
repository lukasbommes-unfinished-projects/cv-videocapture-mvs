This project is a fork of OpenCV 4.1.0 which provides two additional methods for the cv::VideoCapture class.

---

### virtual bool cv::VideoCapture::grabMVS( )

Grabs the next frame including it's motion vectors from the video file or capturing device.

**Returns:** true (non-zero) in case of success

The method/function grabs the next frame and it's motion vectors from video file or camera and returns true (non-zero) in the case of success.

The primary use of the function is in multi-camera environments, especially when the cameras do not have hardware synchronization. That is, you call VideoCapture::grab() for each camera and after that call the slower method VideoCapture::retrieve() to decode and get frame from each camera. This way the overhead on demosaicing or motion jpeg decompression etc. is eliminated and the retrieved frames from different cameras will be closer in time.

Also, when a connected camera is multi-head (for example, a stereo camera or a Kinect device), the correct way of retrieving data from it is to call VideoCapture::grab() first and then call VideoCapture::retrieve() one or more times with different values of the channel parameter.

---

### virtual bool cv::VideoCapture::retrieveMVS( OutputArray image, OutputArray motionvectors, int flag = 0 )

Decodes and returns the grabbed video frame and it's motion vectors.

**Parameters:**
    [out] image: the video frame is returned here. If no frames has been grabbed the image will be empty.
    [out] motionvectors: the motion vectors are returned here. If no frames has been grabbed the image will be empty.
    flag: it could be a frame index or a driver specific flag

**Returns:** false if no frames has been grabbed

The method decodes and returns the just grabbed frame. If no frames has been grabbed (camera has been disconnected, or there are no more frames in video file), the method returns false and the function returns an empty image (with cv::Mat, test it with Mat::empty()).

### readMVS()

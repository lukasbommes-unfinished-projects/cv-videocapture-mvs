import numpy as np
import cv2
import time


if __name__ == "__main__":

    # filename of the video file
    url = "vid.mp4"

    cap = cv2.VideoCapture(url)

    if not cap.isOpened():
        raise RuntimeError("Could not open the video url")

    else:

        print("Sucessfully opened video file")

        step = 0
        times = []

        # continuously read and display video frames and motion vectors
        while True:

            print("####################")
            print("Step: ", step)

            tstart = time.time()

            # read next video frame and corresponding motion vectors
            #ret, frame, motion_vectors, frame_type = cap.read()
            #ret, frame = cap.read()

            ret_grab = cap.grabMVS()
            print("ret_grab: ", ret_grab)
            ret_retr, frame = cap.retrieveMVS()
            print("ret_retr: ", ret_retr)

            tend = time.time()
            telapsed = tend - tstart
            times.append(telapsed)
            print("Elapsed time: {} s".format(telapsed))

            # if there is an error reading the frame
            if not ret_grab or not ret_retr:
                break;

            print("Frame shape: ", np.shape(frame))
            print("Frame Flags: ", frame.flags)
            print("Frame dtype: ", frame.dtype)

            #time.sleep(0.025);

            step += 1

            # show frame
            cv2.imshow("Frame", frame)

            # if user presses "q" key stop program
            if cv2.waitKey(1) & 0xFF == ord('q'):
               break

    print("average dt: ", np.mean(times))

    # when everything done, release the video capture object
    cap.release()

    # close the GUI window
    cv2.destroyAllWindows()

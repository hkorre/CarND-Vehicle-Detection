# Write-Up

## Data Investigation
First I print out a sample of the vehicle and non-vehicle images.
This can be seen in the python notebook.

## HOG Feature Extraction
I then define a function to do HOG feature extraction.
* I chose the Lab color space, because it seemed to do well in the paper 'Color exploitation in hog-based traffic sign detection'
* I ran HOG on each of the Lab channels and then concatenated the result to get the feature vector
* For other parameters (i.e. orient, pix_per_cell, cell_per_block) I kept the defaults from the lesson.
Lastly I preprocess the features to get mean=0 and variance=1
An example can be seen in the python notebook.

## Training
I split the data in training and test sets.
Then I train a Linear Support Vector Classifier. I also wrap this classifier in a callibrated classifier (CalibratedClassifierCV).
The calibrated classifier: 
* Turns the probability curve of the SVC from sigmoidal to linear
  * http://scikit-learn.org/stable/auto_examples/calibration/plot_calibration_curve.html#sphx-glr-auto-examples-calibration-plot-calibration-curve-py
* Provides a simple function to retrieve the classification probability

## Detection Cars
I used the sliding window approach described in the lessons. Some notable parts are:
* I chose windows of size 64x64 and 128x128. 64x64 was default and 128x128 was just twice as wide and high
* I allow for custom overlap percentages and custom start and stop heights for each window size.
* I only allow detections that have a confidence above 75%
I draw some boxes in the python notebook to show things are working.

## Hard-Negative Mining
I created a set of functions to use for hard-negative mining. On each detection: 
* I display the image
* Then answer is it a true detection or not
* If the answer is false the image is saved in the 'false_positives' folder
I can then add the false_positives folder to the non-vehicles directory and use the images in training

## Combining Detections
I create a heatmap from detections by taking a blank image and increasing the intensity at pixels within detection windows. 
I threshold the heatmap and then find the bounding box that includes all pixels above the threshold.
An example is included in the python notebook.

## Creating a video
I create a VideoProcessor class. This class:
* Finds detections in each frame using the feature extractor, scaler, and classifier.
* Detections are aggregated over multiple frames and then thresholded in order to remove some false positives.
* After a certain number of frames we create a bounding box around the detections and then draw bounding boxes.

## Remove for improvement
There is remove for improvement in the following areas:
* There are still a few false positives. We could try to get rid of them with
  * More hard-negative mining
  * Increasing the detection threshold
  * Checking out new color space (e.g. YCbCr)
* The algorithm runs very slow (7-8 secs/frame). We could try:
  * Batch classification
  * Trying to use less windows (i.e. less overlap)
  * Trying to decrease the size of the feature list through parameters
  * Trying to see if there is a dominant HOG channel and only processing that channel

## Final Video
The solution video is the file project_video_soln.mp4

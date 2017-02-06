#!/bin/bash

apt-get install unzip

# vehicles labeled data
curl -LOk https://s3.amazonaws.com/udacity-sdc/Vehicle_Tracking/vehicles.zip
unzip vehicles.zip

# non-vehicle labeled data
curl -LOk https://s3.amazonaws.com/udacity-sdc/Vehicle_Tracking/non-vehicles.zip
unzip non-vehicles.zip
cp -r false_positives non-vehicles/

# clean-up
rm vehicles.zip
rm non-vehicles.zip
rm -rf __MACOSX/

# Integrated Wearable Feedback Device for Human Walking 

Markerless pose estimation
======================
Documentation for a project that I'm using as an edge example: Realtime joint markerless poisedetection with DeepLabCut 33 running on a Jetson Nano.
The interest on the research side is to get a realtime readout of 

## Table of contents

- [Hardware Components](hardware-components)
    - [Additional Notes](#additional-notes)
- [Software Components](software-components)
    - [Additional Notes](#additional-notes)
- [Install Jetpack](install-jetpack)
- [Install Tensorflow](#install-tensorflow)
- [Links](#links)
- [Acknowledgements](acknowledgements)

## Hardware Components 

* Jetson Nano Developer Kit (1)
* Samsung 64GB Evo Select SD card (1)
* CanaLit USB-C Power Supply (1)
* IMX219-160 Camera (1)
* JXMOX MicroUSB adapter (1)

### Additional Notes

TODO

## Software Components 

* [Jetpack for Jetson Nano](https://developer.nvidia.com/embedded/jetpack)
* TensorFlow
* DeepLabCut
* OpenCV 3.4.7

### Additional Notes

## Install Jetpack

Assuming your Jetson developer kit has been flashed with and is running L4T 32.3.1 or higher, the following commands will install all other JetPack components that correspond to your version of L4T:

`sudo apt update`

`sudo apt install nvidia-jetpack`

To view individual Debian packages which are part of nvidia-jetpack metapackage, enter the command:

`sudo apt show nvidia-jetpack`

### Install Tensorflow


TODO

## Links
TODO reference papers, extra readings, etc

## Authors
Nathan Moser, Nathan Tom, Haley Hoppe, and Kofi Adu-Gyan

### Acknowledgments
DDI Lab

[NIU School Of Kineoseology](https://www.cedu.niu.edu/KNPE/) and [Dr. Hill](https://www.cedu.niu.edu/knpe/about/faculty-and-instructors/hill-christopher.shtml)

[The DeepLabCut developers](http://www.mackenziemathislab.org/deeplabcut)

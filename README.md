# Multiple Phase Flow Identification using Computational Simulation and Convolutional Neural Network 

  This repository is a Master Project under the supervision of Prof. Mohd Fua'ad Bin Rahmat at the University Technology Malaysia.
All updates done in the Master Project 2 will be posted on the repository including codes, CAD Designs, videos, dataset, and Results.


## Abstract

  The Identification of gas-solid flow characterization in dense-phase pneumatic conveying particles is very important to a vast area of industrial fields such as chemical and pharmaceutical industries since a slight change in flow characteristics results in a completely different product. The motion of the gas-solid two phase flow in dense-phase usually has a nonlinear and unsteady nature that needs to be examined and analyzed to identify the particle flow behavior in the pneumatic conveying pipelines. In this research a method to identify this kind of flow regimes is proposed using a computational method where a gravity flow rig is modelled on Solidworks and multiple flow patterns are simulated with different particle sizes ranging between 0.5 to 3 millimeters plastic beads. For changing the flow patterns inside the pipe, an Iris Mechanism is designed according to the specifications of the flow required to achieve the flow pattern control. A sectioning method is implemented to capture tomographic sections for different flow patterns. Afterwards images is fed to a Convolutional Neural Network which is trained to identify the flow patterns according to several flow features. A GUI is designed to better visualize the whole system and vew the determined flow pattern. 
  
  
## Update 26/02/2020

This work was done in the past two weeks. The following video introduces a summary for the documentation of the new update. 

* [Click Here to Watch Video](https://www.youtube.com/watch?v=bQ2gvs1fL-4)


# Gravity Flow Rig

  It is an instrumentation that uses a gravity-feed system where a fluid is moved through the system as a result of gravity rather than a pump. An [AC motor](https://en.wikipedia.org/wiki/AC_motor) is attached to the junction box between the collector and the tomographic system. The junction box contain a screw feed drived by the motor to in the plastic beeds to the tomographic system in a periodic manner. The Gravity Rig is designed and modelled on [Solidworks](https://www.solidworks.com/) with the same dimensions as the real structure that is located in `P10` building in University Technology Malaysia ([UTM](https://www.utm.my/)). 
  
<p align="center">
  <img width="326" height="524" src="https://user-images.githubusercontent.com/59189327/75503732-c919b500-59d6-11ea-927e-ae3266198577.JPG">
</p>

The [Gravity Rig](#Gravity-Flow-Rig) consists of

* **Steel Structure**
  + It's the outer skeleton of the Gravity Rig It is made out of steel square tubes `(40 x 40 mm)` having a wall thickness of `4 mm`. The dimensions of the structure is `(3 x 1.2 m)` 
  
<p align="center">
  <img width="244" height="392" src="https://user-images.githubusercontent.com/59189327/75509560-4d286880-59e8-11ea-96d0-f19c8addd1ee.JPG">
</p>

* **Collector** 
  + It is made out of galvanized sheet metal and is used to collect the plastic beads prior to feeding to the next stage. 
  
<p align="center">
  <img width="409" height="380" src="https://user-images.githubusercontent.com/59189327/75509610-97a9e500-59e8-11ea-9259-ffb2e0aca302.JPG">
</p>

* **Screw Feeder**
  + In this stage the plastic beeds are fed from the collector to an `AC motor` that drives a screw feeder which moves the beeds to the tube in a periodic manner and it has a control unit which controls its speed.
  
<p align="center">
  <img width="532" height="305" src="https://user-images.githubusercontent.com/59189327/75509831-38000980-59e9-11ea-989e-d7e06fb36f46.JPG">
</p>

* **Tomographic System**
  + This the main stage where the project focuses where the flow pattern is controlled by the [Iris Mechanism](https://en.wikipedia.org/wiki/Diaphragm_(optics)) and detected by the [Electrostatic Sensor Array](https://jurnalteknologi.utm.my/index.php/jurnalteknologi/article/view/3453) which will be replaced in this project by a sectioning algorithm to detect the flow pattern. 
  + It is made of a dielectric PVC pipe with the 1st stage containing the `Iris Mechanism` and the 2nd stage containing the `Electrostatic Sensor Array`
  
<p align="center">
  <img width="424" height="434" src="https://user-images.githubusercontent.com/59189327/75510670-050b4500-59ec-11ea-854d-e1d1d5fd93e4.JPG">
</p>

* **Iris Mechanism**
  + It is the Mechanism that was designed to control the flow patterns. It is taken from the aperture mechanism that is used in camera shutters. 
  + Overlapping blades are used to create different diameters of flow. When the outer gear is revolved, it turns the small gear attached to the blades' ends simultaneously causing the movement of these blades all together at the same time which creates a varying circle in the middle. A demonstration of the working principle can be seen in the [Video](https://www.youtube.com/watch?v=bQ2gvs1fL-4).
  
<p align="center">
  <img width="513" height="453" src="https://user-images.githubusercontent.com/59189327/75511812-a2b44380-59ef-11ea-99bb-689e6aa9d161.JPG">
</p>

<p align="center">
  <img width="538" height="197" src="https://user-images.githubusercontent.com/59189327/75511856-d1321e80-59ef-11ea-9566-c0d64458b876.JPG">
</p>

* **Plastic Beads Box**
  + It is a box for collecting the plastic beads after being detected by the Tomographic system and it is considered the last stage of the Gravity Flow Rig operation. The beads are then taken again to the Collector using a vaccuum pump.

<p align="center">
  <img width="331" height="294" src="https://user-images.githubusercontent.com/59189327/75511331-371da680-59ee-11ea-9be1-9d79b1909703.JPG">
</p>



  
  
    

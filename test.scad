use<./uCube.scad>
use <./lib/parametric_involute_gear_v5.0.scad>

hBase = 20;
rLock = 15.5;
hLock = 2.75;
wallT = 2;

hFree = 20.5;
hHub  = 5;

rTube = 13.05;

baseGap = 1;

//translate([0, 0, hLock + hBase + hFree - hHub]) gear (circular_pitch=600,
//	gear_thickness = hHub,
//    hub_thickness = 10,
//    bore_thickness = 2,
//	rim_thickness = hFree,
//	circles=8, hub_diameter = 2*rTube + wallT, bore_diameter = 2*rTube, number_of_teeth = 20);

uObjectiveFace();
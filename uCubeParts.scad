/*
                    uCube: Modular 3D-printable optomechanical kit
                     Copyright (C) 2016 Mihails Delmans
                              m.delmans@gmail.com
                              
                                     v.1.0
    
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    
    
                                    uCubeParts.scad
                                Collection of uCube parts
                                   
*/

// use <./uCubeClasses.scad>
include <./Parts/uCubeCore.scad>
include <./Parts/uApperture.scad>
include <./Parts/uRaspberryPi.scad>
include <./Parts/uLens.scad>
include <./Parts/uLED.scad>

// module uApperture( apperture = Apperture(), h, center = true ){
//     shape = getattr(apperture, "shape");
//     size  = getattr(apperture, "size" );
//     if (shape == "circle"){
//         cylinder( h, size[0], size[1], center = center );
//     }
//     else if (shape == "square" ){
//         cube([size[0], size[1], h], center = center );
//     }
// }

// module uAppertureFaceP( cubeSize = defaultCubeSize, apperture = Apperture()){

//     d = getattr(cubeSize, "d");

//     difference(){
//         uFace( cubeSize = cubeSize );
//         uApperture( apperture, h = d );
//     }
// }

// module uDoubleSlitFace( cubeSize = defaultCubeSize, screw = defaultScrew, slitW = 0.2, slitD = 0.8, slitL = 10 ){
//     d = getattr(cubeSize, "d");

//     difference(){
//         uFace(cubeSize = cubeSize, screw = screw);
//         translate([0.5 * slitD, 0, 0]) cube( [slitW, slitL, 0.5*d], center = true);
//         translate([-0.5 * slitD, 0, 0]) cube( [slitW, slitL, 0.5*d], center = true);
//     }
// }

// module uLEDFace( cubeSize = defaultCubeSize, screw = defaultScrew, ledScrew = ledScrew, starLED = StarLED(), apperture = Apperture(), appertureHeight = 4, starGap= 1.5, wallT = 1, wireR = 1, wireGrooveL = 5 ){
//     screwPosR       = getattr(starLED, "r");
//     starW           = getattr(starLED, "w");
//     starR           = starW / sqrt(3);

//     screwR          = getattr(ledScrew, "screwR");
//     screwCapR       = getattr(ledScrew, "capR");

//     d               = getattr(cubeSize, "d");

//     ledH            = getattr(starLED, "ledH");
//     starH           = getattr(starLED, "starH");

//     module screwCorner(){
//         $fn = 6;
//         translate([-screwPosR, 0, 0]) circle( screwCapR );
//     }
    
//     module screwHole(){
//         $fn = 100;
//         translate([-screwPosR, 0, 0]) cylinder( 0.5*d - starH, screwR, screwR );
//     }

//     module base(){
//         $fn = 6;
//         difference(){
//             circle( starR + wallT + starGap );
//             screwCorner();
//             rotate([0, 0, 120]) screwCorner();
//             rotate([0, 0, -120]) screwCorner();
//         }
//     }

//     difference(){
//         union(){
//             rotate([180, 0, 0])difference(){
//                 uFace(cubeSize = cubeSize, screw = screw);
//                 translate([0, 0, -0.25*d]) cylinder(d, starR + starGap, starR + starGap, $fn = 6);
//             }
           
//             linear_extrude(height = appertureHeight + ledH + 0.5*wallT - starH)
//             difference(){
//                 base();
//                 offset(delta = -0.87*wallT) base();
//             }
//             translate([0, 0, appertureHeight + ledH - 0.5*wallT - starH]) linear_extrude(height = wallT) base();
//             linear_extrude(height = 0.5*d - starH){
//                 screwCorner();
//                 rotate([0, 0, 120]) screwCorner();
//                 rotate([0, 0, -120]) screwCorner();
//             }
            
//         }
//          screwHole();
//         rotate([0, 0, 120]) screwHole();
//         rotate([0, 0, 240]) screwHole();
//         h = wallT + appertureHeight + 0.25*d;
//         translate([0, 0, 0.5*h])uApperture( apperture = apperture, h = h, center = true, $fn = 100 );
//         rotate([0, 0, 60]) translate([0, 0.5*starW+starGap-0.5, appertureHeight + 0.5*ledH - starH - 0.5*wallT ])rotate([-90, 0, 0]) cylinder(wallT + wireGrooveL, wireR, wireR);
//         rotate([0, 0, 180]) translate([0, 0.5*starW+starGap-0.5, appertureHeight + 0.5*ledH - starH - 0.5*wallT ])rotate([-90, 0, 0]) cylinder(wallT + wireGrooveL, wireR, wireR);

//     }


// }


// module uAppertureFaceT(cubeSize = defaultCubeSize, apperture = Apperture(), w = 2){

//     d       = getattr(cubeSize, "d");
//     size    = getattr(cubeSize, "size");
//     faceGap = getattr(cubeSize, "faceGap");

//     h = 1.5*d + size;

//     union(){
//         rotate([180,0,0]) uFace(cubeSize = cubeSize);
//         translate([0, 0, 0.5*(h + 0.5*d)]) difference(){
//             cube([size - 2*faceGap, w, h], center = true);
//             translate([0, 0, 0.5*(1.5*d)]) rotate([90, 0, 0]) uApperture( apperture = apperture, h = w );
//         }
//     }
// }

// module uLensSupport(cubeSize = defaultCubeSize, lens = Lens(), supportH = 6, supportD = 6, n = 3){
    
//     lensR  = getattr(lens, "r");
//     lensH  = getattr(lens, "minH");

//     d       = getattr(cubeSize, "d");

//     supportR = 0.5*supportD;
//     R = lensR + supportR - 1;    
    
//     difference(){
//         union(){
//             for ( i=[0:n] ){
//                 translate([ R*sin( i*360/n ), R*cos( i*360/n ), d/4  ]) cylinder( supportH + 0.5*lensH + 2, supportR, supportR  );
//             }
//         }
//         translate([0, 0, d/4 + supportH]) cylinder(lensH, lensR, lensR);
//     }
// }

// module uCollimatorFace(cubeSize = defaultCubeSize, screw = ledScrew, starLED = StarLED(), lens = Lens(), apperture = Apperture(), appertureHeight = 4, starGap = 1.5, wallT = 1, wireR = 1, supportD = 6, n = 3){
    
//     focus   = getattr(lens, "f");
//     d       = getattr(cubeSize, "d");

//     starH   = getattr(starLED, "starH");

//     union(){
//         uLEDFace(cubeSize = defaultCubeSize, screw = screw, starLED = starLED, apperture = apperture, appertureHeight = appertureHeight, starGap = starGap, wallT = wallT, wireR = wireR );
//         uLensSupport(lens = lens, supportH = focus - (0.5*d - starH), supportD = supportD, n = n);
//     }
// }

// module uLensFace(cubeSize = defaultCubeSize, lens = Lens(), apperture = Apperture(), supportH = 1, supportD = 6, n = 3){
    
//     lensR  = getattr(lens, "r");

//     d       = getattr(cubeSize, "d");

//     holeR = lensR - 1;
    
//     difference(){
//         union(){
//             rotate([180,0,0]) uFace();
//             uLensSupport(cubeSize = cubeSize, lens = lens, supportH = supportH, supportD = supportD, n = n);
//         }
//         uApperture(apperture = apperture, h = 0.5*d);
//     }
// }

// module uRaspberryCam2Face(cubeSize = defaultCubeSize, screw = defaultScrew, h = 5, wallT = 1){
//     d = getattr(cubeSize, "d");
//     insertR = getattr(screw, "insertR");

//     supportR = insertR + wallT;

//     difference(){
//         union(){
//             rotate([180,0,0]) uFace(cubeSize = cubeSize, screw = screw);
//             translate( [10.5, 0, d/4] ) screwInsertSupport(h = h);
//             translate( [-10.5, 0, d/4] ) screwInsertSupport(h = h);
//             translate( [10.5, 12.5, d/4] ) screwInsertSupport(h = h);
//             translate( [-10.5, 12.5, d/4] ) screwInsertSupport(h = h);
//         }
//         translate([0, -5, 0]) cube([18, 0.6, d/2 + 0.1], center = true);
//     }
// }

// module uM12LensFace(cubeSize = defaultCubeSize, screw = defaultScrew, lens = M12Lens(), wallT = 1){
    
//     insertR = getattr(screw, "insertR");
//     threadH = getattr(lens, "threadH");
//     headR   = getattr(lens, "headR");
//     headH   = getattr(lens, "headH");
//     f       = getattr(lens, "f");
//     d       = getattr(cubeSize, "d");


//     supportR = insertR + wallT;
//     supportH = threadH - 0.5 * d + f + 1;


//     difference(){
//         union(){
//             rotate([180,0,0]) uFace(cubeSize = cubeSize, screw = screw);
//             translate( [10.5, 0, d/4] ) screwInsertSupport(screw = screw, h = supportH);
//             translate( [-10.5, 0, d/4] ) screwInsertSupport(screw = screw, h = supportH);
//             translate( [10.5, 12.5, d/4] ) screwInsertSupport(screw = screw, h = supportH);
//             translate( [-10.5, 12.5, d/4] ) screwInsertSupport(screw = screw, h = supportH);
//             translate([0, 0, -headH - 0.25*d]) cylinder(headH, headR + wallT, headR + wallT);
//         }
//         cylinder(0.5*d+$delta, 6, 6, center = true);
//         translate([0, 0, -headH - 0.25*d]) cylinder(headH, headR, headR);
//     }
// }



// module uFocusLensFace(cubeSize = defaultCubeSize, screw = defaultScrew, focusLens = FocusLens(), wallT = 1 ){
    
//     hLock = getattr(focusLens, "hLock");
//     hBase = getattr(focusLens, "hBase");
//     rLock = getattr(focusLens, "rLock");
//     rBase = getattr(focusLens, "rBase");

//     d       = getattr(cubeSize, "d");

//     difference(){
//         union(){
//             mirror([0,0,1]) uFace( cubeSize = cubeSize, screw = defaultScrew );
//             translate([0, 0, 0.25*d]) cylinder(hLock, rLock + wallT , rLock + wallT);
//         }
//        translate([0, 0, 0.25*d]) cylinder( hLock, rLock, rLock );
//        translate([0, 0, -0.25*d]) cylinder( 0.5*d + hLock, rBase + 0.4, rBase + 0.4 );
//     }
// }


// //------------------------------Formatted upto here---------------------------

// module uObjectiveFace(){
//     hBase = 13.5;
//     rLock = 15.9;
//     hLock = 2.8;
//     wallT = 1;

//     hFree = 20.5;
//     hHub  = 5;

//     rTube = 13.05;

//     baseGap = 1;

//     //translate([0, 0, hLock + hBase + hFree - hHub]) gear (circular_pitch=600,
//     //	gear_thickness = hHub,
//     //    hub_thickness = 10,
//     //    bore_thickness = 2,
//     //	rim_thickness = hFree,
//     //	circles=8, hub_diameter = 2*rTube + wallT, bore_diameter = 2*rTube, number_of_teeth = 20);


//     union(){
//         difference(){
//             rotate([180, 0, 0])uFace();
//             cylinder(d, rLock, rLock, center = true);
//         }
//         translate([0, 0, -0.25*d]) difference(){
//             cylinder(hBase + hLock, rLock + 2*wallT, rLock + 2*wallT);
//             cylinder(hLock + hBase, rLock, rLock);
//         }
//         }
// }

// module uTubeLensFace(r1 = 19.2, r2 = 18.2, h1=8){
//         union(){
//             uFace();
//             translate([0, 0, -0.5*size - d ])  difference(){
//                 cube([size - 2*faceGap, size - 2*faceGap, size + 1.5*d], center = true);
//                 translate([0, 0, -0.75*d]) rotate([90,0,0])cylinder(size, r2, r2, center = true);
//                 translate([0, 0.5*size, -0.75*d]) rotate([90,0,0])cylinder(h1*2, r1, r1, center = true);
//             }
//         }
// }



// module uCrossFrameFaceThroughHole(w = 58, l = 48, h = 3, armL = 10, wallT = 1, k=0.25, supportH = 40, theta=50){
//     module base(h=h, r = 0.5*screwD + wallT){
//         cylinder( h, r, r  );
//     }
//     module halfCross(){
//         hull(){
//             translate([0.5*w, 0.5*l, 0]) base();
//             translate([0.5*w - armL, 0.5*l, 0 ]) base();
//         }
//         hull(){
//             translate([0.5*w - armL, 0.5*l, 0 ]) base();
//             translate([-0.5*w + armL, -0.5*l, 0 ]) base();
//         }
//         hull(){
//             translate([-0.5*w + armL, -0.5*l, 0 ]) base();
//             translate([-0.5*w, -0.5*l, 0 ]) base();
//         }
//     }
    
//     supportW = k*(0.5*w - armL) / (2 * sin(theta));
//     supportL = k*(0.5*l);
    
//     module halfSupportCross(){
//         hull(){
//             translate([supportW, supportL, 0 ]) base(h=supportH, r = (0.5*screwD + wallT) / sqrt(2));
//             translate([-supportW, -supportL, 0 ]) base(h=supportH, r = (0.5*screwD + wallT) / sqrt(2));
//         }
//     }
    
//     module hole(){
//         cylinder(h, 0.5*screwD, 0.5*screwD);
//     }
    
//     union(){
//         uFace();
//         translate([0, 0, d/4]){
//             union(){
//                 difference(){
//                     union(){
//                         halfSupportCross();
//                         mirror([1,0,0]) halfSupportCross();
//                     }
//                     cubeW = sqrt(2) * (supportW * 2 + 2*wallT + screwD);
//                     cubeL = supportL * 2 + 4*wallT + screwD;
//                     translate([0.5*(supportW * 2 + 2*wallT + screwD), 0, supportH]) rotate([0,50,0]) cube([cubeW, cubeL, cubeW], center = true);
//                 }
//                 translate([0, 0, supportH - 0.5*(supportW * 2 + 2*wallT + screwD)])rotate([0,50,0])difference(){
//                     union(){
//                         halfCross();
//                         mirror([1,0,0]) halfCross();
//                     }
                    
//                     translate([0.5*w, 0.5*l, 0]) hole();
//                     translate([0.5*w, -0.5*l, 0]) hole();
//                     translate([-0.5*w, 0.5*l, 0]) hole();
//                     translate([-0.5*w, -0.5*l, 0]) hole();
                    
//                 }
//             }
//         }
//     }
// }



// module uCrossFrameFace(w = 48, l = 58, h = 2, armL = 10, wallT = 1){
//     module base(){
//         cylinder( h, 0.5*insertD + wallT, 0.5*insertD + wallT  );
//     }
//     module halfCross(){
//         hull(){
//             translate([0.5*w, 0.5*l, 0]) base();
//             translate([0.5*w - armL, 0.5*l, 0 ]) base();
//         }
//         hull(){
//             translate([0.5*w - armL, 0.5*l, 0 ]) base();
//             translate([-0.5*w + armL, -0.5*l, 0 ]) base();
//         }
//         hull(){
//             translate([-0.5*w + armL, -0.5*l, 0 ]) base();
//             translate([-0.5*w, -0.5*l, 0 ]) base();
//         }
//     }
//     union(){
//         uFace();
//         rotate([0, 0, 45])translate([0, 0, d/4]) 
//         union(){
//             halfCross();
//             mirror([1,0,0]) halfCross();
//             translate([0.5*w, 0.5*l, h]) screwInsertSupport(wallT = wallT);
//             translate([0.5*w, -0.5*l, h]) screwInsertSupport(wallT = wallT);
//             translate([-0.5*w, 0.5*l, h]) screwInsertSupport(wallT = wallT);
//             translate([-0.5*w, -0.5*l, h]) screwInsertSupport(wallT = wallT);
//         }
//     }
// }

// module uRaspberryPiFace(h = 2){
//     uCrossFrameFace(w = 49, l = 58, h = h, armL = 10, wallT = 1 );
// }   


// module uTMountFace(h=5, rBig = 26, rSmall = 26, hRing = 6.6){
//     insertD = 2.5;
//     insertL = 4;
//     union(){
//         difference(){
//             uFace();
//             translate([0, 0, -0.25*d]) cylinder(0.5*d, 0.5*size - insertL, 0.5*size - insertL);
//         }
//         translate([0, 0, 0.25*d])
//         difference(){
//             cylinder(h-1, 0.5*size, rBig + insertL);
//             cylinder(h-1, 0.5*size - insertL, rSmall);
//         }
//         translate([0, 0, 0.25*d + h-1])
//         difference(){
//             cylinder(hRing + 1, rBig + insertL, rBig + insertL);
//             translate([0, 0, 1]) cylinder(hRing, rBig, rBig);
//             cylinder(hRing + 1, rSmall, rSmall);
//             translate([0, 0, 0.5*hRing + 1]) rotate([90, 0, 0]) cylinder(rBig*2, 0.5*2.5, 0.5*insertD);
//             translate([0, 0, 0.5*hRing + 1]) rotate([90, 0, 120]) cylinder(rBig*2, 0.5*2.5, 0.5*insertD);
//             translate([0, 0, 0.5*hRing + 1]) rotate([90, 0, 240]) cylinder(rBig*2, 0.5*2.5, 0.5*insertD);
//         }
//     }
// }
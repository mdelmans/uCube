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

module uObjectiveFace(){
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


union(){
    difference(){
        rotate([180, 0, 0])uFace();
        cylinder(d, rLock, rLock, center = true);
    }
    translate([0, 0, -0.25*d]) difference(){
        cylinder(hBase + hLock, rLock + 2*wallT, rLock + 2*wallT);
        cylinder(hLock + hBase, rLock, rLock);
    }
    }
}

module uTubeLensFace(r1 = 19.2, r2 = 18.2, h1=8){
        union(){
            uFace();
            translate([0, 0, -0.5*size - d ])  difference(){
                cube([size - 2*faceGap, size - 2*faceGap, size + 1.5*d], center = true);
                translate([0, 0, -0.75*d]) rotate([90,0,0])cylinder(size, r2, r2, center = true);
                translate([0, 0.5*size, -0.75*d]) rotate([90,0,0])cylinder(h1*2, r1, r1, center = true);
            }
        }
}

module uRaspberryCam2Face(h = insertL + 1, wallT = 1){
    
    supportR = 0.5*insertD + wallT;
    difference(){
        union(){
            rotate([180,0,0]) uFace();
            translate( [10.5, 0, d/4] ) screwInsertSupport();
            translate( [-10.5, 0, d/4] ) screwInsertSupport();
            translate( [10.5, 12.5, d/4] ) screwInsertSupport();
            translate( [-10.5, 12.5, d/4] ) screwInsertSupport();
        }
        translate([0, -5, 0]) cube([18, 0.6, d/2 + 0.1], center = true);
    }
}


module uLenseSupport(supportH = 6, n = 3, lenseD = 25, lenseH = 2, supportD = 6){
    
    lenseR = 0.5*lenseD;
    supportR = 0.5*supportD;
    R = lenseR + supportR - 1;    
    
    difference(){
        union(){
            for ( i=[0:n] ){
                translate([ R*sin( i*360/n ), R*cos( i*360/n ), d/4  ]) cylinder( supportH + 0.5*lenseH + 2, supportR, supportR  );
            }
        }
        translate([0, 0, d/4 + supportH]) cylinder(lenseH, lenseR, lenseR);
    }
}

module uLenseFace(supportH = 1, n = 3, lenseD = 25, lenseH = 2, supportD = 6){
    
    holeR = 0.5*lenseD - 1;
    
    difference(){
        union(){
            rotate([180,0,0]) uFace();
            uLenseSupport(supportH, n, lenseD, lenseH, supportD);
        }
        cylinder( d/2+0.1, holeR, holeR, center = true);
    }
}

module uCrossFrameFace(w = 48, l = 58, h = 2, armL = 10, wallT = 1){
    module base(){
        cylinder( h, 0.5*insertD + wallT, 0.5*insertD + wallT  );
    }
    module halfCross(){
        hull(){
            translate([0.5*w, 0.5*l, 0]) base();
            translate([0.5*w - armL, 0.5*l, 0 ]) base();
        }
        hull(){
            translate([0.5*w - armL, 0.5*l, 0 ]) base();
            translate([-0.5*w + armL, -0.5*l, 0 ]) base();
        }
        hull(){
            translate([-0.5*w + armL, -0.5*l, 0 ]) base();
            translate([-0.5*w, -0.5*l, 0 ]) base();
        }
    }
    union(){
        uFace();
        rotate([0, 0, 45])translate([0, 0, d/4]) 
        union(){
            halfCross();
            mirror([1,0,0]) halfCross();
            translate([0.5*w, 0.5*l, h]) screwInsertSupport(wallT = wallT);
            translate([0.5*w, -0.5*l, h]) screwInsertSupport(wallT = wallT);
            translate([-0.5*w, 0.5*l, h]) screwInsertSupport(wallT = wallT);
            translate([-0.5*w, -0.5*l, h]) screwInsertSupport(wallT = wallT);
        }
    }
}

module uRaspberryPiFace(h = 2){
    uCrossFrameFace(w = 49, l = 58, h = h, armL = 10, wallT = 1 );
}   

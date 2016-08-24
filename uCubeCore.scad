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
    
    
                                    uCubeCore.scad
                                   Core uCube parts
                                   
*/


// Hole for a screw insert
module screwInsert(l=insertL, d=insertD){
    translate([0,0,-$delta]) cylinder(insertL + 2*$delta, 0.5*insertD, 0.5*insertD);
}

// Hole for a tapered screw
module screwHole(l = 0.5*d){
    translate([0,0,-$delta]){
        cylinder(l - screwCapH, 0.5*screwD, 0.5*screwD);
        translate([0,0,l - screwCapH]) cylinder(screwCapH + 2*$delta, 0.5*screwD, 0.5*screwCapD);
    }
    
}

module uCube(){
    difference(){
        union(){
            difference(){
                cube(size + 4*d,center=true);
                trippleMirror([-0.5*fullSize, -0.5*fullSize, -0.5*fullSize]){
                    corner3([d, d, 0]) cube([0.5*size + d, 0.5*size + d, 0.5*d]);
                    corner3([1.5*d, 1.5*d, 0.5*d]) screwInsert();
                }
                corner3() cube([size,size,size + 4*d],center = true);
            }
            trippleMirror([-0.5*fullSize, -0.5*fullSize, -0.5*fullSize]){
                corner3([0.5*(fullSize-0.75*d), 0.25*d, 1.25*d]) cube([0.75*d, 0.5*d, 0.5*d], center = true);
                corner3([0.25*d, 0.5*(fullSize-0.75*d), 1.25*d]) cube([0.5*d, 0.75*d, 0.5*d], center = true);
            }
        }
        
        
        rotateQuarters([0, 0.5*fullSize-d, -0.5*fullSize]) screwInsert();
        rotate([0,0,90]) rotateQuarters([0, 0.5*fullSize-d, -0.5*fullSize]) screwInsert();
        rotate([0,90,0]) rotateQuarters([0, 0.5*fullSize-d, -0.5*fullSize]) screwInsert();
        
        rotateQuarters([0, -(0.5*fullSize-d), -0.5*fullSize]) screwHole(2*d);
        rotate([0,0,90]) rotateQuarters([0, -(0.5*fullSize-d), -0.5*fullSize]) screwHole(2*d);
        rotate([0,90,0]) rotateQuarters([0, -(0.5*fullSize-d), -0.5*fullSize]) screwHole(2*d);
    }

}

module uFace(){
    difference(){
        cube([faceSize - 2*faceGap, faceSize - 2*faceGap, d/2], center = true);
        rotate([0,0,45]) doubleMirror([0.5*(faceSize - 0.5*d)*sin(45), 0.5*(faceSize - 0.5*d)*sin(45), 0]) rotate([0,0,45]) cube([0.5*d + 2*faceGap, 1.5*d + 2*faceGap, 0.5*d], center = true);
        doubleMirror([0.5*(faceSize - d), 0.5*(faceSize - d), -0.25*d]) screwHole();
    }
}

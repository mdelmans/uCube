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
                                   Core uCube Parts
                                   
*/

// Core Classes
function getattr( obj, key ) = obj[search( [key], obj, num_returns_per_match=1 )[0]][1];

function CubeSize(size = 40, d = 7, faceGap = 0.4) = [
    ["size",    size],
    ["d",       d ],
    ["faceGap", faceGap],
    ["fullSize", size + 4*d],
    ["faceSize", size + 2*d]
];

function Screw( screwR = 1.5, capR = 3, capH = 2.5, insertH = 5, insertR = 2 ) = [
    ["screwR"    , screwR],
    ["capR", capR],
    ["capH", capH],
    ["insertH"  , insertH],
    ["insertR"  , insertR] 
];

// Hole for a screw insert
module screwInsert( screw = defaultScrew ) {
    h = getattr( screw, "insertH" );
    r = getattr( screw, "insertR" );
    translate([0, 0, -$delta]) cylinder(h + 2*$delta, r, r);
}


// Support for a screw insert
module screwInsertSupport( screw = defaultScrew, h = getattr( defaultScrew, "insertH" ), wallT = 1 ) {
    r = getattr( screw, "insertR");
    insertH = getattr(screw, "insertH");

    supportR = r + wallT;
    difference() {
        cylinder(h, supportR, supportR);
        translate([0, 0, h - insertH])screwInsert( screw );
    }
}


// Hole for a tapered screw
module screwHole(screw = defaultScrew, l ){
    capH = getattr(screw, "capH");
    capR = getattr(screw, "capR");
    screwR    = getattr(screw, "screwR" );

    translate([0, 0, -$delta]){
        cylinder(l - capH, screwR, screwR);
        translate([0, 0, l - capH]) cylinder(capH + 2*$delta, screwR, capR);
    }
}

module uCube(cubeSize = defaultCubeSize, screw = defaultScrew) {
    size        = getattr(cubeSize, "size");
    d           = getattr(cubeSize, "d");
    faceGap     = getattr(cubeSize, "faceGap");
    fullSize    = getattr(cubeSize, "fullSize");

    difference(){
        union(){
            difference(){
                cube(size + 4*d,center=true);
                trippleMirror([-0.5*fullSize, -0.5*fullSize, -0.5*fullSize]){
                    corner3([d, d, 0]) cube([0.5*size + d, 0.5*size + d, 0.5*d]);
                    corner3([1.5*d, 1.5*d, 0.5*d]) screwInsert(screw = defaultScrew);
                }
                corner3() cube([size,size,size + 4*d],center = true);
            }
            trippleMirror([-0.5*fullSize, -0.5*fullSize, -0.5*fullSize]){
                corner3([0.5*(fullSize-0.75*d), 0.25*d, 1.25*d]) cube([0.75*d, 0.5*d, 0.5*d], center = true);
                corner3([0.25*d, 0.5*(fullSize-0.75*d), 1.25*d]) cube([0.5*d, 0.75*d, 0.5*d], center = true);
            }
        }


        rotateQuarters([0, 0.5*fullSize-d, -0.5*fullSize]) screwInsert(screw = defaultScrew);
        rotate([0,0,90]) rotateQuarters([0, 0.5*fullSize-d, -0.5*fullSize]) screwInsert(screw = defaultScrew);
        rotate([0,90,0]) rotateQuarters([0, 0.5*fullSize-d, -0.5*fullSize]) screwInsert(screw = defaultScrew);

        rotateQuarters([0, -(0.5*fullSize-d), -0.5*fullSize]) screwHole(screw = defaultScrew, l = 2*d);
        rotate([0,0,90]) rotateQuarters([0, -(0.5*fullSize-d), -0.5*fullSize]) screwHole(screw = defaultScrew, l = 2*d);
        rotate([0,90,0]) rotateQuarters([0, -(0.5*fullSize-d), -0.5*fullSize]) screwHole(screw = defaultScrew, l = 2*d);
    }
}

module uFace(cubeSize = defaultCubeSize, screw = defaultScrew){
    d           = getattr(cubeSize, "d");
    faceGap     = getattr(cubeSize, "faceGap");
    faceSize    = getattr(cubeSize, "faceSize");

     difference(){
        cube([faceSize - 2*faceGap, faceSize - 2*faceGap, d/2], center = true);
        rotate([0,0,45]) doubleMirror([0.5*(faceSize - 0.5*d)*sin(45), 0.5*(faceSize - 0.5*d)*sin(45), 0]) rotate([0,0,45]) cube([0.5*d + 2*faceGap, 1.5*d + 2*faceGap, 0.5*d], center = true);
        doubleMirror([0.5*(faceSize - d), 0.5*(faceSize - d), -0.25*d]) screwHole(screw = screw, l = 0.5*d);
    }
}
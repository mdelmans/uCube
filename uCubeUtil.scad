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

// Translates an object and makes reflections in axial mirrors
module trippleMirror(d){
    mirror([0,0,0]) translate(d) children();
    mirror([0,0,1]) translate(d) children();
    mirror([0,1,0]) translate(d) children();
    mirror([0,1,0]) mirror([0,0,1]) translate(d) children();
    mirror([1,0,0]) translate(d) children();
    mirror([1,0,0]) mirror([0,0,1]) translate(d) children();
    mirror([1,0,0]) mirror([0,1,0]) translate(d) children();
    mirror([[1,0,0]]) mirror([0,1,0]) mirror([0,0,1]) translate(d) children();
}

// Makes a 3D corner with a displacement d
module corner3(d){
    translate(d) children();
    rotate([-90,0,0]) mirror([0,1,0]) translate(d) children();
    rotate([0,90,0]) mirror([1,0,0]) translate(d) children();
}
// Rotate every 90 degrees
module rotateQuarters(d){
    translate(d) children();
    rotate([90,0,0]) translate(d) children();
    rotate([180,0,0]) translate(d) children();
    rotate([270,0,0]) translate(d) children();
}
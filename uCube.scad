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
    
    
                                    uCube.scad
                                   	   Main 


        
                                uCube profile diagram

                 d     d            size 
               <---> <---> <------------------->
                ____                                  ____
               |    |____                        ____|    |
               |__       |                      |       __|
                  |      |                      |      |
                  |______|                      |______|
               <->
              1/2 d

*/

include <./uCubeUtil.scad>
include <./uCubeCore.scad>
include <./uCubeParts.scad>

$fn = 100;
$delta = 0.01;

// Default values for the cube parameters

size        =   40;    // Size of the internal space of a cube
d           =   7;     // Size of a cube margin   
faceGap     = 	0.4;     // Size of a gap between a face and a cube border

insertL     =   5;      // Length of a screw insert
insertD     =   4;      // Diameter of a screw insert
screwD      =   3.5;    // Diameter of a scew hole
screwCapH   =   2.5;    // Height of a screw cap
screwCapD   =   6;      // Diameter of a screw cap


// Helper variables
fullSize = size + 4*d;
faceSize = size + 2*d;
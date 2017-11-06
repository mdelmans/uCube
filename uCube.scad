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

// Pats
include <./Parts/uCubeCore.scad>
include <./Parts/uAperture.scad>
include <./Parts/uRaspberryPi.scad>
include <./Parts/uLens.scad>
include <./Parts/uLED.scad>

// Modules
include <./Modules/uCubeModules.scad>
include <./Modules/uCameraModule.scad>
include <./Modules/uLightModule.scad>

$fn = 100;
$delta = 0.01;


// Default values for the cube parameter
defaultCubeSize	= CubeSize( size = 40, d = 7, faceGap = 0.4 );
defaultScrew	= Screw( screwR = 1.75, capR = 3, capH = 2.5, insertH = 5, insertR = 2 );

ledScrew		= Screw( screwR = 1, capR = 2, capH = 1, insertH = 2, insertR = 1);


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
	
	
								uCubeModules.scad
						 	Core Module Functionality
									   
*/

module uFlatModule(cubeSize = defaultCubeSize, screw = defaultScrew){

	faceSize = getattr(cubeSize, "faceSize");

//    Top
	translate([0, 2*faceSize, 0]) children(0);
//    Bottom
	translate([0, 0, 0]) children(1);
//    Right
	translate([faceSize, 0, 0]) children(2);
//    Left
	translate([-faceSize, 0, 0]) children(3);
//    Front
	translate([0, faceSize, 0]) children(4);
//    Back
	translate([0, -faceSize, 0]) children(5);
}

module uExplodeModule(cubeSize = defaultCubeSize, screw = defaultScrew){

	faceSize        = getattr(cubeSize, "faceSize");
	size            = getattr(cubeSize, "size");
	explodeDistance = 2 * size;

	uCube( cubeSize = defaultCubeSize, screw = defaultScrew );
//    Top
	translate([0, 0, explodeDistance]) children(0);
//    Bottom
	translate([0, 0, -explodeDistance]) mirror([0, 0, 1]) children(1);
//    Right
	translate([explodeDistance, 0, 0]) rotate([0, 90, 0])  children(2);
//    Left
	translate([-explodeDistance, 0, 0]) rotate([0, -90, 0])  children(3);
//    Front
	translate([0, explodeDistance, 0]) rotate([-90, 0, 0])  children(4);
//    Back
	translate([0, -explodeDistance, 0]) rotate([90, -0, 0])  children(5);
}

module uCubeModule(cubeSize = defaultCubeSize, screw = defaultScrew, moduleType = "explode"){
	if (moduleType == "explode") uExplodeModule(cubeSize = cubeSize, screw = screw){
		children(0);
		children(1);
		children(2);
		children(3);
		children(4);
		children(5);
	}

	else if (moduleType == "flat") uFlatModule(cubeSize = cubeSize, screw = screw){
		children(0);
		children(1);
		children(2);
		children(3);
		children(4);
		children(5);
	}
}

module uEmptyCube(moduleType = "explode"){
	uCubeModule(moduleType = moduleType){
		uFace();
		uFace();
		uFace();
		uFace();
		uFace();
		uFace();
	}
}
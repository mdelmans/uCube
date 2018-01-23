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
	
	
									uRails.scad
							   Parts rail cage system
								   
*/

railScrew = Screw(screwR = 1, capR = 2, capH = 2, insertH = 5, insertR = 2);

function Rail(size = 30, d = 6, screw = railScrew) = [
	["d", d],
	["screw", screw],
	["size", size]
];

thorlabsRail = Rail();

module uRailFaceA(cubeSize = defaultCubeSize, rail = thorlabsRail){
	
	screw		= getattr(rail, "screw");
	cubeD		= getattr(cubeSize, "d");
	
	railSize	= getattr(rail, "size");

	difference(){
		uFace(cubeSize = cubeSize);
		translate([0.5*railSize, 0.5*railSize, 0.25*cubeD]) rotate([180, 0, 0]) screwHole(screw = screw, l = 0.5*cubeD);
		translate([0.5*railSize, -0.5*railSize, 0.25*cubeD]) rotate([180, 0, 0]) screwHole(screw = screw, l = 0.5*cubeD);
		translate([-0.5*railSize, 0.5*railSize, 0.25*cubeD]) rotate([180, 0, 0]) screwHole(screw = screw, l = 0.5*cubeD);
		translate([-0.5*railSize, -0.5*railSize, 0.25*cubeD]) rotate([180, 0, 0]) screwHole(screw = screw, l = 0.5*cubeD);
	}
}

module uRailFaceT(cubeSize = defaultCubeSize, rail = thorlabsRail){
	
	screw		= getattr(rail, "screw");
	cubeD		= getattr(cubeSize, "d");
	
	railSize	= getattr(rail, "size");
	railR		= getattr(rail, "d") * 0.5;

	faceGap		= getattr(cubeSize, "faceGap");

	difference(){
		uFace(cubeSize = cubeSize);
		translate([0.5*railSize, 0.5*railSize, 0]) cylinder(0.5*cubeD, railR + faceGap, railR + faceGap, center = true);
		translate([0.5*railSize, -0.5*railSize, 0]) cylinder(0.5*cubeD, railR + faceGap, railR + faceGap, center = true);
		translate([-0.5*railSize, 0.5*railSize, 0]) cylinder(0.5*cubeD, railR + faceGap, railR + faceGap, center = true);
		translate([-0.5*railSize, -0.5*railSize, 0]) cylinder(0.5*cubeD, railR + faceGap, railR + faceGap, center = true);
	}
}

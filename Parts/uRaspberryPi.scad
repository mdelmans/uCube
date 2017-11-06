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
	
	
									uRaspberryPi.scad
								RaspberryPi Related Parts
								   
*/

module uCrossFrameFace(cubeSize = defaultCubeSize, screw = defaultScrew, size = [49, 58], h = 2, armL = 10, wallT = 0.6){
	$fn = 100;

	d			= getattr(cubeSize, "d");
	insertR		= getattr(screw, "insertR");
	
	w			= size[0];
	l			= size[1];
	
	module base(){
		 cylinder( h, insertR + wallT, insertR + wallT  );
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
		uFace(cubeSize = cubeSize, screw = screw);
		translate([0, 0, d/4]) 
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

module uRaspberryPiFace(cubeSize = defaultCubeSize, screw = defaultScrew, h = 2){
	uCrossFrameFace(cubeSize = cubeSize, screw = screw, size = [49, 58], armL = 10, wallT = 0.6, h = h);
}

module uRaspberryCam2Face(cubeSize = defaultCubeSize, screw = defaultScrew, h = 5, wallT = 1){
	d = getattr(cubeSize, "d");
	insertR = getattr(screw, "insertR");

	supportR = insertR + wallT;

	difference(){
		union(){
			rotate([180,0,0]) uFace(cubeSize = cubeSize, screw = screw);
			translate( [10.5, 0, d/4] ) screwInsertSupport(h = h);
			translate( [-10.5, 0, d/4] ) screwInsertSupport(h = h);
			translate( [10.5, 12.5, d/4] ) screwInsertSupport(h = h);
			translate( [-10.5, 12.5, d/4] ) screwInsertSupport(h = h);
		}
		translate([0, -5, 0]) cube([18, 0.6, d/2 + 0.1], center = true);
	}
}
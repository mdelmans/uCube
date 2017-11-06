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
	
	
									uAperture.scad
									Aperture Parts
								   
*/

function Aperture( shape="circle", size = [10, 10] ) = [
	["shape", shape],
	["size" , size]
];

module uAperture( aperture = Aperture(), h, center = true ){
	
	shape = getattr(aperture, "shape");
	size  = getattr(aperture, "size" );
	if (shape == "circle"){
		cylinder( h, size[0], size[1], center = center );
	}
	else if (shape == "square" ){
		cube([size[0], size[1], h], center = center );
	}
}

module uApertureFaceP( cubeSize = defaultCubeSize, aperture = Aperture()){

	d = getattr(cubeSize, "d");

	difference(){
		uFace( cubeSize = cubeSize );
		uAperture( aperture, h = d );
	}
}

module uApertureFaceT(cubeSize = defaultCubeSize, aperture = Aperture(), w = 2){

	d       = getattr(cubeSize, "d");
	size    = getattr(cubeSize, "size");
	faceGap = getattr(cubeSize, "faceGap");

	h = 1.5*d + size;

	union(){
		rotate([180,0,0]) uFace(cubeSize = cubeSize);
		translate([0, 0, 0.5*(h + 0.5*d)]) difference(){
			cube([size - 2*faceGap, w, h], center = true);
			translate([0, 0, 0.5*(1.5*d)]) rotate([90, 0, 0]) uAperture( aperture = aperture, h = w );
		}
	}
}
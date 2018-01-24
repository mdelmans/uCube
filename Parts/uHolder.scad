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
	
	
									uHolder.scad
									Holder Parts
								   
*/

function GenericComponent(shape="circle", size = [10, 10], h = 4) = [
	["shape", shape],
	["size" , size],
	["h"	, h]
];

defaultGenericComponent = GenericComponent(shape="circle", size = [10, 10], h = 4);

module uHolderFaceP( cubeSize = defaultCubeSize, component = defaultGenericComponent, offset = 0, wallT = 1 ){
	d		= getattr(cubeSize, "d");

	shape	= getattr(component, "shape");
	size	= getattr(component, "size" );
	h		= getattr(component, "h");

	m = (offset >=0 ? 1 : -1);
	cOffset = offset>=0 ? offset : -offset;

	difference(){
		union(){
			uFace(cubeSize = cubeSize);
			translate([0, 0,  m*0.5*(0.5*h + cOffset)]) uAperture( Aperture(shape = shape, size = [size[0] + 2*wallT, size[1] + 2*wallT]), h = 0.5*h + cOffset );
			
		}
		translate( [0, 0, m*0.5*(cOffset - 0.5*h)] ) uAperture( Aperture(shape = shape, size = [ size[0] - 2*wallT, size[1] - 2*wallT ]), h = 0.5*d + cOffset - 0.5*h );
	
		translate( [0, 0, m*(cOffset + 0.25*d)] ) uAperture( Aperture(shape = shape, size = size), h = h+0.5*d );
	}
}

module uHolderFaceT( cubeSize = defaultCubeSize, component = defaultGenericComponent, offset = 0, wallT = 1, w = 2 ){
	d		= getattr(cubeSize, "d");
	size	= getattr(cubeSize, "size");
	faceGap	= getattr(cubeSize, "faceGap");

	shape	= getattr(component, "shape");
	cSize	= getattr(component, "size" );
	h		= getattr(component, "h");

	hHolder = 1.5*d + size;

	m = (offset >=0 ? 1 : -1);
	cOffset = offset>=0 ? offset : -offset;

	union(){
		rotate([180,0,0]) uFace(cubeSize = cubeSize);
		translate([0, 0, 0.5*(hHolder + 0.5*d)]){
			difference(){
				union(){
					cube([size - 2*faceGap, w, hHolder], center = true);
					translate([0, m*0.5*(0.5*h + cOffset), 0.5*(1.5*d)]) rotate([90, 0, 0]) uAperture( Aperture(shape = shape, size = [cSize[0] + 2*wallT, cSize[1] + 2*wallT]), h = 0.5*h + cOffset );
				}
				translate([0, m*0.5*(cOffset - 0.5*h - 0.5*w ) + $delta, 0.5*(1.5*d) ]) rotate([90,0,0]) uAperture( Aperture(shape = shape, size = [ cSize[0] - 2*wallT, cSize[1] - 2*wallT ]), h = w + cOffset - 0.5*h );
				translate([0, m*(cOffset + 0.5*w) - $delta,0.5*(1.5*d)]) rotate([90, 0, 0]) uAperture( Aperture(shape = shape, size = cSize), h = h+w );
				dh = (0.5*cSize[1] + 2 * wallT) - (0.5 * hHolder - 0.5 * (1.5*d) );
				if (dh > 0){
					translate([0,0,0.5*(hHolder + dh)]) cube([ size - 2*faceGap, w, dh ], center = true);
				}
			}
		}
	}
}

module uHolderFace45 (cubeSize = defaultCubeSize, component = defaultGenericComponent, wallT = 1, w = 2){
	d		= getattr(cubeSize, "d");
	size	= getattr(cubeSize, "size");
	faceGap	= getattr(cubeSize, "faceGap");

	shape	= getattr(component, "shape");
	cSize	= getattr(component, "size" );
	h		= getattr(component, "h");

	hHolder = 1.5*d + size;

	union(){
		rotate([180,0,0]) uFace(cubeSize = cubeSize);
		translate([0, 0, 0.5*(hHolder + 0.5*d)]) rotate([0, 0, 135]){
			difference(){
				union(){
					cube([size - 2*faceGap, w, hHolder], center = true);
					translate([0, 0.25*h, 0.5*(1.5*d)]) rotate([90, 0, 0]) uAperture( Aperture(shape = shape, size = [cSize[0] + 2*wallT, cSize[1] + 2*wallT]), h = 0.5*h );
				}
				translate([0, -0.5*(0.5*h + 0.5*w) + $delta, 0.5*(1.5*d) ]) rotate([90,0,0]) uAperture( Aperture(shape = shape, size = [ cSize[0] - 2*wallT, cSize[1] - 2*wallT ]), h = w - 0.5*h );
				
				translate([0, 0.5*w - $delta,0.5*(1.5*d)]) rotate([90, 0, 0]) uAperture( Aperture(shape = shape, size = cSize), h = h+w );
			}
		}
	}

}
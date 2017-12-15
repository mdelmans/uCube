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
	
	
									uLED.scad
							   Parts for holding LEDs
								   
*/

defaultLEDAperture = Aperture( shape = "circle", size = [1,1] );

ledScrew		= Screw( screwR = 1, capR = 2, capH = 1, insertH = 2, insertR = 1);

function StarLED( screwPosR = 9.5, w = 20, ledH = 2.5, starH = 1.5 ) = [
	["screwPosR"  , screwPosR],
	["w"          , w],
	["ledH"       , ledH],
	["starH"      , starH]
];

module uLEDFace( cubeSize = defaultCubeSize, screw = ledScrew, starLED = StarLED(), aperture = defaultLEDAperture, apertureHeight = 4, starGap= 1.5, wallT = 1, wireR = 1, wireGrooveL = 5 ){
	screwPosR		= getattr(starLED, "screwPosR");
	starW			= getattr(starLED, "w");
	starR			= starW / sqrt(3);

	screwR			= getattr(screw, "screwR");
	screwCapR		= getattr(screw, "capR");

	d				= getattr(cubeSize, "d");

	ledH			= getattr(starLED, "ledH");
	starH			= getattr(starLED, "starH");

	module screwCorner(){
		$fn = 6;
		translate([-screwPosR, 0, 0]) circle( screwCapR );
	}
	
	module screwHole(){
		$fn = 100;
		translate([-screwPosR, 0, 0]) cylinder( 0.5*d - starH, screwR, screwR );
	}

	module base(){
		$fn = 6;
		difference(){
			circle( starR + wallT + starGap );
			screwCorner();
			rotate([0, 0, 120]) screwCorner();
			rotate([0, 0, -120]) screwCorner();
		}
	}

	difference(){
		union(){
			rotate([180, 0, 0])difference(){
				uFace(cubeSize = cubeSize);
				translate([0, 0, -0.25*d]) cylinder(d, starR + starGap, starR + starGap, $fn = 6);
			}

			linear_extrude(height = apertureHeight + ledH + 0.5*wallT - starH)
			difference(){
				base();
				offset(delta = -0.87*wallT) base();
			}
			translate([0, 0, apertureHeight + ledH - 0.5*wallT - starH]) linear_extrude(height = wallT) base();
			linear_extrude(height = 0.5*d - starH){
				screwCorner();
				rotate([0, 0, 120]) screwCorner();
				rotate([0, 0, -120]) screwCorner();
			}
			
		}
		 screwHole();
		rotate([0, 0, 120]) screwHole();
		rotate([0, 0, 240]) screwHole();
		h = wallT + apertureHeight + 0.25*d;
		translate([0, 0, 0.5*h])uAperture( aperture = aperture, h = h, center = true, $fn = 100 );
		rotate([0, 0, 60]) translate([0, 0.5*starW+starGap-0.5, apertureHeight + 0.5*ledH - starH - 0.5*wallT ])rotate([-90, 0, 0]) cylinder(wallT + wireGrooveL, wireR, wireR);
		rotate([0, 0, 180]) translate([0, 0.5*starW+starGap-0.5, apertureHeight + 0.5*ledH - starH - 0.5*wallT ])rotate([-90, 0, 0]) cylinder(wallT + wireGrooveL, wireR, wireR);

	}


}

module uCollimatorFace(cubeSize = defaultCubeSize, screw = ledScrew, starLED = StarLED(), lens = Lens(), apperture = defaultLEDAperture, appertureHeight = 4, starGap = 1.5, wallT = 1, wireR = 1, wireGrooveL = 5, supportD = 6, n = 3){

	focus   = getattr(lens, "f");
	d       = getattr(cubeSize, "d");

	starH   = getattr(starLED, "starH");

	union(){
		uLEDFace(cubeSize = defaultCubeSize, screw = screw, starLED = starLED, apperture = apperture, appertureHeight = appertureHeight, starGap = starGap, wallT = wallT, wireR = wireR, wireGrooveL = 5 );
		uLensSupport(lens = lens, supportH = focus - (0.5*d - starH), supportD = supportD, n = n);
	}
}
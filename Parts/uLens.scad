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
		
	
									uLens.scad
									Lens Parts
								   
*/

function Lens(f = 25, r = 12.5, minH = 2, maxH = 5) = [
	["f"        , f],
	["r"        , r],
	["minH"     , minH],
	["maxH"     , maxH]
];

function M12Lens( f = 5.4, threadH = 11, headH = 4, headR = 7.2 ) =[
	["f", f],
	["threadH", threadH],
	["headH", headH],
	["headR", headR]

];

function PhotoLens( ffd = 30) = [
	["ffd", ffd]
];

function TMountAdapter( r = 26, h = 6.6 ) = [
	["r", r],
	["h", h]
];

function LightGuide( smallR = 2.6, bigR = 4.8, l = 20 ) = [
	["smallR",	smallR],
	["bigR",	bigR],
	["l",		l]
];

defaultLens = Lens(f = 25, r = 12.5, minH = 2, maxH = 5);
defaultM12Lens = M12Lens(f = 5.4, threadH = 11, headH = 4, headR = 7.2);
defaultPhotoLens = PhotoLens(ffd = 30);
defaultTMountAdapter = TMountAdapter(r = 26, h = 6.6);
defaultLightGuide = LightGuide(smallR = 2.6, bigR = 4.8, l = 20);

module uLensSupport(cubeSize = defaultCubeSize, lens = defaultLens, supportH = 6, supportD = 6, n = 3){
	
	offset = 1;

	lensR	= getattr(lens, "r");
	lensH	= getattr(lens, "minH");

	d		= getattr(cubeSize, "d");

	supportR = 0.5*supportD;
	R = lensR + supportR - offset;

	
	
	difference(){
		union(){
			for ( i=[0:n] ){
				translate([ R*sin( i*360/n ), R*cos( i*360/n ), d/4  ]) cylinder( supportH + lensH + offset, supportR, supportR  );
			}
		}
		translate([0, 0, d/4 + supportH]) cylinder(lensH, lensR, lensR);
		translate([0, R - supportR, supportH + lensH + d/4 +  offset])rotate([0, -90, 0]) linear_extrude(height = supportD, center = true){
			polygon([ [0,0], [-0.8*offset,0], [0,2*offset] ]);
		}
	}
}

module uLensFaceI(cubeSize = defaultCubeSize, lens = defaultLens, aperture = defaultAperture, supportH = 1, supportD = 6, n = 3){
	
	lensR	= getattr(lens, "r");
	d		= getattr(cubeSize, "d");

	holeR = lensR - 1;
	
	difference(){
		union(){
			rotate([180,0,0]) uFace( cubeSize = cubeSize);
			uLensSupport(cubeSize = cubeSize, lens = lens, supportH = supportH, supportD = supportD, n = n);
		}
		uAperture(aperture = aperture, h = 0.5001*d);
	}
}

module uLensFaceC(cubeSize = defaultCubeSize, lens = defaultLens, aperture = defaultAperture, supportH = 5, wallT = 1){
	lensR	= getattr(lens, "r");
	d		= getattr(cubeSize, "d");
	hMin	= getattr(lens, "minH");

	union(){
		uApertureFaceP(cubeSize = cubeSize, aperture = aperture);
		translate([0, 0, 0.25*d])difference(){
			cylinder(supportH + hMin, lensR + wallT, lensR + wallT);
			cylinder(supportH + hMin, lensR - wallT, lensR - wallT);
			translate([0, 0, supportH]) cylinder(hMin, lensR, lensR);
		}
	}
}

module uM12LensFace(cubeSize = defaultCubeSize, screw = piCamScrew, lens = defaultM12Lens, wallT = 1){
	
	insertR = getattr(screw, "insertR");
	threadH = getattr(lens, "threadH");
	headR   = getattr(lens, "headR");
	headH   = getattr(lens, "headH");
	f       = getattr(lens, "f");
	d       = getattr(cubeSize, "d");


	supportR = insertR + wallT;
	supportH = threadH - 0.5 * d + f + 1;


	difference(){
		union(){
			rotate([180,0,0]) uFace(cubeSize = cubeSize);
			translate( [10.5, 0, d/4] ) screwInsertSupport(screw = screw, h = supportH);
			translate( [-10.5, 0, d/4] ) screwInsertSupport(screw = screw, h = supportH);
			translate( [10.5, 12.5, d/4] ) screwInsertSupport(screw = screw, h = supportH);
			translate( [-10.5, 12.5, d/4] ) screwInsertSupport(screw = screw, h = supportH);
			translate([0, 0, -headH - 0.25*d]) cylinder(headH, headR + wallT, headR + wallT);
		}
		cylinder(0.5*d+$delta, 5.8, 5.8, center = true);
		translate([0, 0, -headH - 0.25*d]) cylinder(headH, headR, headR);
	}
}

module uTMountFace( cubeSize = defaultCubeSize, adapter = defaultTMountAdapter, h = 4, wallT = 1){

	size		= getattr(cubeSize, "size");
	d			= getattr(cubeSize, "d");
	adapterH	= getattr(adapter, "h");
	adapterR	= getattr(adapter, "r");

	union(){
		difference(){
			uFace( cubeSize = cubeSize);
			translate([0, 0, -0.25*d]) cylinder(0.5*d, 0.5*size, 0.5*size);
		}
		translate([0, 0, 0.25*d])
		difference(){
			cylinder(h, 0.5*size + wallT, adapterR + wallT);
			cylinder(h, 0.5*size, adapterR - 1);
		}
		translate([0, 0, 0.25*d + h])
		difference(){
			cylinder(adapterH, adapterR + wallT, adapterR + wallT);
			cylinder(adapterH, adapterR, adapterR);
		}
	}
}

module uLightGuideFace( cubeSize = defaultCubeSize, lens = defaultLens, lightGuide = defaultLightGuide, wallT = 1 ){
	
	d			= getattr(cubeSize, "d");
	f			= getattr(lens, "f");
	maxH		= getattr(lens, "maxH");

	guideH		= getattr(lightGuide, "l");
	guideSmallR = getattr(lightGuide, "smallR");
	guideBigR	= getattr(lightGuide, "bigR");
	dH			= 5;

	union(){
		uLensFaceI(cubeSize = cubeSize, lens = lens, supportH = f - 0.5*maxH, supportD = 6, n = 3, aperture = Aperture(shape = "circle", size = [ guideSmallR, guideSmallR ]));
		mirror([0, 0, 1]) translate([0, 0, 0.25*d]) difference(){
			cylinder( guideH + dH - 0.5*d, guideBigR + wallT, guideBigR + wallT );
			cylinder( guideH + dH - 0.5*d, guideSmallR, guideSmallR);
			translate([0, 0, guideH - 0.5 * d]) cylinder( dH, guideBigR, guideBigR );
		}
	}
}
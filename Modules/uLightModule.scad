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
	
	
								uLightModules.scad
						 		  Light Modules
									   
*/

module uLightCube(cubeSize = defaultCubeSize, screw = defaultScrew, moduleType = "explode", type = "collimator", collimatingLens = Lens(), focusLens = Lens(), LEDAperture = defaultLEDAperture, faceAperture = Aperture(), starLED = StarLED(), lightGuide = LightGuide(),  apertureH = 4 ){
	
	if (type == "collimator"){

		f = getattr(lens, "f");

		uCubeModule(moduleType = moduleType){
			// Top
			uFace();

			// Bottom
			uFace();

			// Right
			uApertureFaceP( cubeSize = cubeSize, screw = screw, aperture = faceAperture );

			// Left
			rotate([0, 0, 90]) mirror([0, 0, 1]) uCollimatorFace( cubeSize = cubeSize, screw = screw, starLED = starLED, lens = lens, aperture = LEDAperture, apertureH = apertureH );

			// Front
			uFace();

			// Back
			uFace();
		}

	}
	else if (type == "point"){
		uCubeModule(moduleType = moduleType){
			// Top
			uFace();

			// Bottom
			uFace();

			// Right
			uApertureFaceP( cubeSize = cubeSize, screw = screw, aperture = faceAperture );

			// Left
			rotate([0, 0, 90]) mirror([0, 0, 1]) uLEDFace( cubeSize = cubeSize, screw = screw, starLED = starLED, aperture = LEDAperture, apertureH = apertureH );

			// Front
			uFace();

			// Back
			uFace();
		}
	}
	else if (type == "light-guide"){
		uCubeModule(moduleType = moduleType){
			// Top
			uFace();

			// Bottom
			uFace();

			// Right
			rotate([0, 0, 90]) mirror([0, 0, 1]) uLightGuideFace( cubeSize = cubeSize, screw = screw, lens = focusLens, lightGuide = lightGuide, wallT = 1 );

			// Left
			rotate([0, 0, 90]) mirror([0, 0, 1]) uCollimatorFace( cubeSize = cubeSize, screw = screw, starLED = starLED, lens = collimatingLens, aperture = LEDAperture, apertureH = apertureH );

			// Front
			uFace();

			// Back
			uFace();
		}
	}
}
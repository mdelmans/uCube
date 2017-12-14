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
	
	
								uCameraModules.scad
						 		  Camera Modules
									   
*/

module uCameraCube(cubeSize = defaultCubeSize, screw = defaultScrew, moduleType = "explode", type = "photo", lens, adapter = TMountAdapter(), cameraOffset = 5){
	innerSpace	= getattr(cubeSize, "fullSize") - getattr(cubeSize, "d");
	defaultH	= 5;

	if (type == "photo"){
		adapterH	= getattr(adapter, "h");
		ffd			= getattr(lens, "ffd");

		defaultFocus = innerSpace + defaultH - cameraOffset - ffd;
		tDifference = ffd - defaultFocus;

		uCubeModule(cubeSize = cubeSize, screw = screw, moduleType = moduleType){
			//	Top
			uRaspberryPiFace(cubeSize = cubeSize, screw = screw);

			//	Bottom
			uFace(cubeSize = cubeSize, screw = screw);
			
			//	Right	
			if (tDifference > 0){
				uTMountFace(cubeSize = cubeSize, screw = screw, adapter = adapter, h = ffd - defaultFocus);
			}
			else{
				uTMountFace(cubeSize = cubeSize, screw = screw, adapter = adapter, h = defaultH);
			}  	

			   
			//	Left
			if (tDifference > 0){
				rotate([0, 0, 90]) mirror([0, 0, 1]) uRaspberryCam2Face(cubeSize = cubeSize, screw = screw, h = cameraOffset);
			}
			else{
				rotate([0, 0, 90]) mirror([0, 0, 1]) uRaspberryCam2Face(cubeSize = cubeSize, screw = screw, h = cameraOffset - tDifference);
			}
		

			//	Front
			uFace(cubeSize = cubeSize, screw = screw);
			
			//	Back
			uFace(cubeSize = cubeSize, screw = screw);
		}
	}
	else if (type == "thin-lens"){
		lensF		= getattr(lens, "f");

		defaultFocus = innerSpace - defaultH - cameraOffset;
		tDifference = lensF - defaultFocus;

		uCubeModule(cubeSize = cubeSize, screw = screw, moduleType = moduleType){
			//	Top
			uRaspberryPiFace(cubeSize = cubeSize, screw = screw);

			// Bottom
			uFace(cubeSize = cubeSize, screw = screw);

			// Rigth
			if(tDifference > 0){
				uFace(cubeSize = cubeSize, screw = screw);
				echo("Warning: lens focus is out of range. Try smaller cameraOffset");
			}
			else{
				mirror([0, 0, 1]) uLensFace(cubeSize = cubeSize, screw = screw, lens = lens, supportH = -tDifference);
			}

			// Left
			rotate([0, 0, 90]) mirror([0, 0, 1]) uRaspberryCam2Face(cubeSize = cubeSize, screw = screw, h = cameraOffset);

			//	Front
			uFace(cubeSize = cubeSize, screw = screw);
			
			//	Back
			uFace(cubeSize = cubeSize, screw = screw);
		}
	}

	else if (type == "M12"){

		uCubeModule(cubeSize = cubeSize, screw = screw, moduleType = moduleType){
			// Top
			uRaspberryPiFace(cubeSize = cubeSize, screw = screw);

			// Bottom
			uFace();

			// Right
			rotate([0, 0, 90]) mirror([0, 0, 1]) uM12LensFace(cubeSize = cubeSize, screw = screw, lens = lens);

			// Left
			uFace();

			// Front
			uFace();

			// Back
			uApertureFaceP(cubeSize = cubeSize, screw = screw, aperture = Aperture(shape = "square", size = [18, 0.6]));
		}
	}
}
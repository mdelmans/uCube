# µCube: A framework for 3D printable optomechanics

[uCube](https://mdelmans.github.io/uCube) is open modular optomechanics kit, which is compatible with 3D printing. The idea behind the project is to create a framework for designing, building and sharing optical modules.

uCube is implemented using OpenSCAD, a programming language for CAD modelling. This allows every component to be described as a parametric model, which can be easily shared in a form of a code.

## Design

The design consist of two core parts: uCube, a structural unit; and uFace, which is used to hold optical components in place. Each uCube accepts six uFaces, one for each side. Each assembled uCube can be thought of as a autonomous optical module, e.g. camera, objective, filter cube, etc. Several uCubes can be assembled together into an optical device, e.g. microscope, telescope, spectrometer, etc.

## Parts

All the parts are stored in the `Parts` folder and groped into files by their function. In addition tge group files store definition of corresponding classes. Currently there are six groups defined in the following files:

* `uCubeCore.scad` : Contains definitions of µCube and µFace.
* `uAperture.scad` : Apertures.
* `uHolder.scad` : Holders for generic components.
* `uLED.scad` : LED-related parts
* `uLens.scad` : A collection of lens holders
* `uRaspberryPi.scad` : Raspberry Pi - related parts, includind a Raspberry Pi Camera face.

See [Wiki](https://github.com/mdelmans/uCube/wiki) pages for detailed description of parts.

## Modules

Modules are assemblies of several parts into one µCube. The modules are stored in `Modules` folder.

* `uCubeModules.scad` : Contains a generic definition of a module, which allows to create explode views, or flat arrangment of parts for 3D printing.

* `uCameraModule.scad` : Raspberry Pi - based camera module. Comes in three types( "photo", "M12", "thin-lens" ).

* `uLightModule.scad` : A light source module. Comes in thee types ("point", "collimator", "light-guide")

# µCube: A framework for 3D printable optomechanics

uCube is open modular optomechanics kit, which is compatible with 3D printing. The idea behind the project is to create a framework for designing, building and sharing optical modules.

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

## Getting started

1. Download and install OpenSCAD. You can get the latest version from the official [website](http://www.openscad.org).

2. Download the uCube library.

3. Open OpenSCAD, create a new file and include the uCube library by typing

```javascript
include <uCube.scad>
```

4. You can create a uCube model by typing

```javascript
uCube();
```
5. Hit Render(F6) button. After the rendering is finished, you should see a uCube model ready for export.

6. Press Export as STL button, and send the file for 3D printing.

7. Erase the `uCube();` command and type the following instead:

```javascript
myLens = Lens(f = 25, r = 12.5, minH = 2, maxH = 5);
myAperture = Aperture( shape="circle", size = [10, 10] );
uLensFaceI( lens = myLens, aperture = myAperture, supportH = 5 );
```

The first line creates a new instance of a `Lens` class with a given parameters. The second line creates an instance of a circular `Aperture` with a 10 mm radius. The third line creates a uFace, with the given aperture, and support for the myLense, positioned 5 mm above the uFace.

### Assembly

Please check out the [DocuBricks](http://www.docubricks.com/projects/ucube) portal for the assembly instructions.

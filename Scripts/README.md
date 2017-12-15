# Scripts

The scripts should be executed from the main directory.

## Compilation

Scans trough files in Part folder and extracts all parts definition using `module.*Face.*\(.*\)`. For every part compiles an STL file using OpenSCAD. Also outputs markdown for arguments and default values.

```bash
python scripts/compile.py /Path/to/OpenSCAD
```

## Rendering

Uses material and scene defined in render.blend file to render every STL model.

```bash
blender scripts/render.blend -b -P scripts/render.py
```
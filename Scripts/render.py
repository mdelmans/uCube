import os
import shutil
import bpy
import bpy.ops

def loadModel(path):
    # fullPath = os.path.join(bpy.path.abspath("//"), path)
    bpy.ops.import_mesh.stl(filepath=path)
    
    name = (os.path.basename(path).split('.stl'))[0]
    return bpy.data.objects[name]

def lookAtMe(object, target):
    transform = object.constraints.new(type='TRACK_TO')
    transform.target = target
    transform.track_axis = 'TRACK_NEGATIVE_Z'
    transform.up_axis = 'UP_Y'

def renderTo(path):
    # fullPath = os.path.join(bpy.path.abspath("//"), path)
    bpy.data.scenes['Scene'].render.filepath = path
    bpy.ops.render.render( write_still=True )

stlDir = 'STL'
pngDir = 'PNG'

print (os.getcwd())

if os.path.exists(pngDir):
    shutil.rmtree(pngDir)

os.mkdir(pngDir)

material = bpy.data.materials['Plastic']

for fileName in os.listdir(stlDir):
    if fileName.endswith('.stl'):
        model = loadModel( os.path.join(stlDir, fileName) )
        model.data.materials.append(material)
        renderTo( os.path.join(pngDir, "{0}.png".format(model.name)) )
        bpy.ops.object.select_all(action='DESELECT')
        model.select = True
        bpy.ops.object.delete()
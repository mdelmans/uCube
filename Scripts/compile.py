import os
import sys
import re
import shutil
import subprocess as sp


def getArgDef(module):
	bracket = module.split('(')[1].split(')')[0]
	pairs = bracket.split(',')
	cleanPairs = [ pair.replace(' ', '') for pair in pairs ]
	argDef = { pair.split('=')[0] : pair.split('=')[1] for pair in pairs }
	return argDef

def compileDefinition(module):
	moduleName = module.split('(')[0].split()[1]
	argDef = getArgDef(module)

	print "##{0}".format(moduleName)
	print '![{0}](PNG/{1} "{2}")'.format(moduleName, moduleName, moduleName)
	print '|Argument|Default Value|'
	for arg, default in argDef.iteritems():
		print "|{0}|{1}|".format(arg, default)

# Path to OpenSCAD executable
openSCAD = sys.argv[1]

partsDir = 'Parts'
stlDir = 'STL'
moduleReg = re.compile('module.*Face.*\(.*\)')

tempScadName = 'temp.scad'

if os.path.exists(stlDir):
	shutil.rmtree(stlDir)

os.mkdir(stlDir)

for fileName in os.listdir(partsDir):
	if fileName.endswith(".scad"):
		scadFile = open( os.path.join(partsDir, fileName) )
		for line in scadFile:
			
			try:
				module = re.findall(moduleReg, line)[0]
			except:
				continue

			moduleName = module.split('(')[0].split()[1]

			tempScad = open(tempScadName, "w")
			tempScad.write("include<uCube.scad>\n")
			tempScad.write("{0}();".format(moduleName))
			tempScad.close()

			stlPath = os.path.join(stlDir, "{0}.stl".format(moduleName) )

			compileDefinition(module)

			sp.call("{0} -m make -o {1} temp.scad".format(openSCAD, stlPath), shell = True)
			os.remove("temp.scad")

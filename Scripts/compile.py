import os
import sys
import re
import shutil
import subprocess as sp
import argparse

def getArgDef(module):
	bracket = module.split('(')[1].split(')')[0]
	pairs = bracket.split(',')
	cleanPairs = [ pair.replace(' ', '') for pair in pairs ]
	argDef = { pair.split('=')[0] : pair.split('=')[1] for pair in pairs }
	return argDef

def compileDefinition(module):
	moduleName = module.split('(')[0].split()[1]
	argDef = getArgDef(module)

	print "### {0}".format(moduleName)
	print "<table>\n<tr>"
	print "\t<td> [[/images/parts/{0}.png|{1}|width=300px]] </td>".format(moduleName, moduleName)
	
	print "\t<td><ul>"
	argString = "".join( "\t\t<li> <b>type</b> {0} <i>[{1} ]</i> </li>\n".format( arg, default ) for arg, default in argDef.iteritems() )

	print "{0}\t</ul></td>".format(argString)
	print "</tr>\n</table>\n"

parser = argparse.ArgumentParser(description='Compile STL files from all modules in Parts folder.')
parser.add_argument('path', metavar='Path', type=str, help = "Path to OpenSCAD executable.")
parser.add_argument('--defonly', dest='defonly', action='store_true')

args =  parser.parse_args()

# Path to OpenSCAD executable
openSCAD = args.path

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

			compileDefinition(module)

			if not args.defonly:

				moduleName = module.split('(')[0].split()[1]

				tempScad = open(tempScadName, "w")
				tempScad.write("include<uCube.scad>\n")
				tempScad.write("{0}();".format(moduleName))
				tempScad.close()

				stlPath = os.path.join(stlDir, "{0}.stl".format(moduleName) )

				

				sp.call("{0} -m make -o {1} temp.scad".format(openSCAD, stlPath), shell = True)
				os.remove("temp.scad")

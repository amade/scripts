#!/usr/bin/python2
#Original author: John Klehm 
#Changelog:  
# 20090409 - Check fonts.dir for 0 value and exclude it 
#            Be verbose when running mkfontdir so people can check if its right 
#            General code cleanup 
# 20090408 - Initial Version 

import os 

fontDir = '/usr/share/fonts' 
mkfontdirCmd = 'mkfontdir' 
#use this file to check if mkfontdir succeeded 
mkfontdirFile = 'fonts.dir' 
#contents of the fonts.dir file when no fonts are registered for this dir 
noFonts = '0\n' 
#start and end of fontpath lines 
sfp = '\tFontPath "' 
efp = '"\n' 
#start and end of files section 
sfs = 'Section "Files"\n' 
efs = 'EndSection\n' 
 
 
#find mkfontdirFile and make sure it doesnt have noFonts content 
def hasFonts(root, files): 
    found = False 
 
    for fileName in files: 
        if fileName == mkfontdirFile: 
            fh = open(root + '/' + mkfontdirFile, 'r') 
            fileContent = fh.read() 
            fh.close() 
             
            if (fileContent != '') and (fileContent != noFonts): 
                found = True 
     
    return found 


output = sfs 

#go through fontDir and all subdirs 
for root, dirs, files in os.walk(fontDir): 
    #if this is a font dir then add it 
    if hasFonts(root, files): 
        output += sfp + root + efp 
    #otherwise try running mkfontdir and if it works add it 
    elif root != fontDir: 
        print(mkfontdirCmd + ' ' + root)
        os.system(mkfontdirCmd + ' ' + root) 

        if hasFonts(root, os.listdir(root)): 
            output += sfp + root + efp 

output += efs 

print(output)

#!/usr/bin/python

"""
Pdb read and write implementation for B factor color coding.
"""

import numpy as np
import fortranformat as ff
from sys import argv 
script, filename, outfile = argv
print "arg1:", script 
print "arg2:", filename
print "arg3:", outfile

import xlrd

def splitter(alist):
  vec=[]
  for row in alist:
    vec.append(row.split())
  return vec

def filterdata(alist):
    vec = []
    nonwords = set(["REMARK","END","CONECT","TER"]) 
    for item in alist:
        if not bool(set(item.split()) & nonwords):
           vec.append(header_line_read.read(item))
    return vec 

def getpdb(alist):
    prefix=[]
    atomnumber=[]
    atomname=[]
    alt_indicator=[] 
    residuename=[]
    chainname=[]
    residuenumber=[]
    insert_code=[]
    xcoord=[]
    ycoord=[] 
    zcoord=[]
    occupancy=[]
    bfactor=[]
    elementsymbol=[]
    atomcharge=[]
    newdata=filterdata(alist)
    length = len(newdata)
    for row in range(0,length-1):
        prefix.append(str(newdata[row][0]))
        atomnumber.append(int(newdata[row][1]))
        atomname.append(str(newdata[row][2]))
        alt_indicator.append(str(newdata[row][3]))
        residuename.append(str(newdata[row][4]))
        chainname.append(str(newdata[row][5]))
        residuenumber.append(int(newdata[row][6]))
        insert_code.append(str(newdata[row][7]))
        xcoord.append(float(newdata[row][8]))
        ycoord.append(float(newdata[row][9]))
        zcoord.append(float(newdata[row][10]))
        occupancy.append(float(newdata[row][11]))
        bfactor.append(float(newdata[row][12]))
        elementsymbol.append(str(newdata[row][13]))
        atomcharge.append(str(newdata[row][14]))
    pdb=[prefix,atomnumber,atomname,alt_indicator,residuename,chainname,residuenumber,insert_code,xcoord,ycoord,zcoord,occupancy,bfactor,elementsymbol,atomcharge]
    return pdb

def modpdb(alist,entropy_dictionary):
    prefix=[]
    atomnumber=[]
    atomname=[]
    alt_indicator=[] 
    residuename=[]
    chainname=[]
    residuenumber=[]
    insert_code=[]
    xcoord=[]
    ycoord=[] 
    zcoord=[]
    occupancy=[]
    bfactor=[]
    elementsymbol=[]
    atomcharge=[]
    newdata=filterdata(alist)
    length = len(newdata)
    for row in range(0,length-1):
        prefix.append(str(newdata[row][0]))
        atomnumber.append(int(newdata[row][1]))
        atomname.append(str(newdata[row][2]))
        alt_indicator.append(str(newdata[row][3]))
        residuename.append(str(newdata[row][4]))
        chainname.append(str(newdata[row][5]))
        residuenumber.append(int(newdata[row][6]))
        insert_code.append(str(newdata[row][7]))
        xcoord.append(float(newdata[row][8]))
        ycoord.append(float(newdata[row][9]))
        zcoord.append(float(newdata[row][10]))
        occupancy.append(float(newdata[row][11]))
        currresnbr=newdata[row][6]
        bfactor.append(float(entropy_dictionary[currresnbr]))
        elementsymbol.append(str(newdata[row][13]))
        atomcharge.append(str(newdata[row][14]))
    pdb=[prefix,atomnumber,atomname,alt_indicator,residuename,chainname,residuenumber,insert_code,xcoord,ycoord,zcoord,occupancy,bfactor,elementsymbol,atomcharge]
    return pdb

def getresnbrpdb(alist):
    prefix=[]
    atomnumber=[]
    atomname=[]
    alt_indicator=[]
    residuename=[]
    chainname=[]
    residuenumber=[]
    insert_code=[]
    xcoord=[]
    ycoord=[]
    zcoord=[]
    occupancy=[]
    bfactor=[]
    elementsymbol=[]
    atomcharge=[]
    newdata=filterdata(alist)
    length = len(newdata)
    for row in range(0,length-1):
        prefix.append(str(newdata[row][0]))
        atomnumber.append(int(newdata[row][1]))
        atomname.append(str(newdata[row][2]))
        alt_indicator.append(str(newdata[row][3]))
        residuename.append(str(newdata[row][4]))
        chainname.append(str(newdata[row][5]))
        residuenumber.append(int(newdata[row][6]))
        insert_code.append(str(newdata[row][7]))
        xcoord.append(float(newdata[row][8]))
        ycoord.append(float(newdata[row][9]))
        zcoord.append(float(newdata[row][10]))
        occupancy.append(float(newdata[row][11]))
        bfactor.append(float(newdata[row][12]))
        elementsymbol.append(str(newdata[row][13]))
        atomcharge.append(str(newdata[row][14]))
    return residuenumber

########### GET ENTROPY DATA ####################

xlsfile = 'HYP_entropy_final_160815_martin.xls'
sheetname = 'Net_S'
workbook = xlrd.open_workbook(xlsfile)
worksheet = workbook.sheet_by_name(sheetname)
header_line_read = ff.FortranRecordReader('(A6,I5,1X,A4,A1,A3,1X,A1,I4,A1,3X,3F8.3,2F6.2,10X,2A2)')
header_line_write = ff.FortranRecordWriter('(A6,I5,1X,A4,A1,A3,1X,A1,I4,A1,3X,3F8.3,2F6.2,10X,2A2)')

def getdatafromxls(worksheet,startrow,endrow,column):
        vec=[]
        for index in range(startrow+1,endrow+1):
               vec.append(worksheet.cell(index,column).value)
        return vec

entropy_sk15=getdatafromxls(worksheet,0,139,16)
entropy_sk19=getdatafromxls(worksheet,0,139,18)
entropy_dds=getdatafromxls(worksheet,0,139,20)
residuenumber=getdatafromxls(worksheet,0,139,1)
residuenumber = [ int(x) for x in residuenumber ]
residuename=getdatafromxls(worksheet,0,139,2)

########### BUILD CORR-list ######################

sequence=range(1,140)
resnbrcorr = dict(zip(residuenumber,sequence))

dic_sk15 = dict(zip(residuenumber,entropy_sk15))
dic_sk19 = dict(zip(residuenumber,entropy_sk19))
dic_dds = dict(zip(residuenumber,entropy_dds))

def setcorrresnbr(alist,corrlist):
    vec=[]
    residuenumberpdb=getresnbrpdb(alist)
    length=len(residuenumberpdb)
    for index in range(0,length-1): 
        vec.append(corrlist[int(residuenumber[index])]) 
    return vec

#ligand has residuenumber 1!
#check residuenumbers!

#### READ PDB #################################
def openpdb(filename):
    raw=open(filename,'r')
    data = raw.read().split("\n")
    return data
############ WRITE PDB #######################

def writepdb(outfile,data,dictionary):
    f = open(outfile,'w')
    pdb = modpdb(data,dictionary) 
    length=len(pdb[0])
    for i in range(0,length):
          f.write("%s\n" % header_line_write.write([pdb[0][i],pdb[1][i],pdb[2][i],pdb[3][i],pdb[4][i],pdb[5][i],pdb[6][i],pdb[7][i],pdb[8][i],pdb[9][i],pdb[10][i],pdb[11][i],pdb[12][i],pdb[13][i],pdb[14][i]]))

#todo: fix so that the dictionary is selected 


## OBS!

writepdb(outfile,openpdb(filename),dic_dds)

print "Wrote pdb file with entropy as b-factors to file: ", outfile

#writepdb('sk19_bfactor.pdb',data,dic_sk19)
#writepdb('dds_bfactor.pdb',data,dic_dds)



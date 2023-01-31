#!/usr/bin/env python
"""
#              PERTURB field(s) in one grib file
# -----------------------------------------------------------------
# Script to perturb one or all fields in a GRIB file while mainting the
# headers unchanged. This is required for initial conditions of IFS
#
# Author: Omar Bellprat (omar.bellprat@bsc.es)
#
# PLS: eccodes version
#
#      ./perturb_var.py -h
#
# Call as follow to perturb 3D temperature in IFS ICMSH files:
#
#      ./perturb_var.py -s 't' -d 1 INFILE OUTFILE
#
"""

from __future__ import print_function
import sys
import argparse
from eccodes import *
import numpy as np

def main():
    parser = argparse.ArgumentParser(description='Replace field in IFS initial conditions.')
    parser.add_argument('-s', '--shortname', help='Parameter to replace. Default: all.')
    parser.add_argument('-d', '--seed', help='Optional random generator seed.')
    parser.add_argument('input', help='Input file IFS')
    parser.add_argument('output', help='New IFS output file')
    args = parser.parse_args()

    fin = open(args.input, 'rb')
    fout = open(args.output, 'wb')

    if args.seed != None:
        print("Initializing random number generator with seed "+str(args.seed)+" ...")
        np.random.seed(int(args.seed))

    print("Perturbing fields...")

    while 1:
        gid = codes_grib_new_from_file(fin)
        if gid is None:
            break
        if args.shortname and args.shortname == codes_get(gid, 'shortName') or not args.shortname:
            dt = np.array(codes_get_values(gid))
            d1 = dt.size
            pt = np.random.rand(d1)*0.00001-0.000005
            pdt = dt + pt
            codes_set_values(gid, pdt)
        codes_write(gid, fout)
        codes_release(gid)
    fin.close()
    fout.close()

if __name__ == '__main__':
    sys.exit(main())


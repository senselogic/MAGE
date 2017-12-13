#!/bin/sh
set -x
dmd -m64 mage.d
rm *.o

#!/bin/sh
#####################################
# make OpenWRT SDK                  # 
# for dump1090                      #
# Original scripts edited by Rainer #
#####################################
#
# This script is originaly done by calv. Edited on 2013-10-19 by DE8MSH for latest verions of dump1090
sudo apt-get install subversion gcc g++ libncurses5-dev zlib1g-dev gawk flex patch git-core -y
#svn co svn://svn.openwrt.org/openwrt/branches/backfire
svn co svn://svn.openwrt.org/openwrt/branches/attitude_adjustment
cd attitude_adjustment
scripts/feeds update
scripts/feeds install uclibcxx
# here, you can also install other packages that are in the repository, using scripts/feeds install xyz. You can find packages with scripts/feed list | grep xyz
scripts/feeds install libusb-1.0
scripts/feeds install libpthread
scripts/feeds install librt
scripts/feeds install socat
mkdir ./package/dump1090
cd package/dump1090
rm Makefile
wget https://raw.githubusercontent.com/rainerilgen/OpenWRT-Scripts/master/dump1090/Makefile
cd ..
cd ..
mkdir ./package/rtl-sdr
cd package/rtl-sdr
rm Makefile
wget http://steve-m.de/projects/rtl-sdr/openwrt/package/rtl-sdr/Makefile
cd ..
cd ..
make menuconfig
# select "target system" (in my case: atheros ar71xx)
# select "target profile" (in my case: tp-link wr703n)
# enable "build the openwrt sdk"
# under "libraries" select uclibcxx
# under "libraries" select libusb
# under "utilities" select dump1090
# under "utilities" select rtl-sdr
# also select other packages you might have installed before. They can be in any section or subsection, so you might have to search.
# exit
#cd attitude_adjustment
make -j 3 V=s > debug.txt

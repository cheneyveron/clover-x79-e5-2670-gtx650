#!/bin/sh
# Credits:
# 1. "omni" For having made the patch.
# 2. "stinga11" For this script.
#
# Note: This script wont work if you not use the StepContextDict from macmini6,2.
#
# For more information about the speedstep for Intel Sandy Bridge-E visit the following site.
# http://www.insanelymac.com/forum/topic/295200-testers-needed-cpu-power-management-for-sb-and-ib-xeons-or-i7-39xx-on-x79-or-c60x-chipset/
# http://www.tonymacx86.com/general-help/127574-guide-asus-x79-os-x-controlled-speedstep.html
#
sudo perl -pi -e 's|\xFF\x0F\x84\x2D|\xFF\x0F\x85\x2D|g' /System/Library/Extensions/AppleIntelCPUPowerManagement.kext/Contents/MacOS/AppleIntelCPUPowerManagement;
sudo perl -pi -e 's|\x01\x00\x01\x0F\x84|\x01\x00\x01\x0F\x85|g' /System/Library/Extensions/AppleIntelCPUPowerManagement.kext/Contents/MacOS/AppleIntelCPUPowerManagement;
sudo perl -pi -e 's|\xC9\x74\x15\x0F\x32\x25\xFF\x0F\x00\x00\x48|\xC9\xEB\x15\x0F\x32\x25\xFF\x0F\x00\x00\x48|g' /System/Library/Extensions/AppleIntelCPUPowerManagement.kext/Contents/MacOS/AppleIntelCPUPowerManagement;
sudo perl -pi -e 's|\xC9\x74\x0C\x0F\x32\x83\xE0\x1F\x42\x89\x44\x3B|\xC9\xEB\x0C\x0F\x32\x83\xE0\x1F\x42\x89\x44\x3B|g' /System/Library/Extensions/AppleIntelCPUPowerManagement.kext/Contents/MacOS/AppleIntelCPUPowerManagement;
sudo perl -pi -e 's|\x01\x74\x61|\x01\xEB\x61|g' /System/Library/Extensions/AppleIntelCPUPowerManagement.kext/Contents/MacOS/AppleIntelCPUPowerManagement;
sudo perl -pi -e 's|\x3E\x75\x38|\x3E\x90\x90|g' /System/Library/Extensions/AppleIntelCPUPowerManagement.kext/Contents/MacOS/AppleIntelCPUPowerManagement;
sudo perl -pi -e 's|\x75\x11\xB9|\xEB\x11\xB9|g' /System/Library/Extensions/AppleIntelCPUPowerManagement.kext/Contents/MacOS/AppleIntelCPUPowerManagement
echo "Patching AppleIntelCPUPowerManagement.kext"

echo "Fix permissions ..."
sudo chown -R root:wheel /System/Library/Extensions/AppleIntelCPUPowerManagement.kext
sudo chmod -R 755 /System/Library/Extensions/AppleIntelCPUPowerManagement.kext

echo "Kernel cache..."
sudo touch /System/Library/Extensions

echo "Remember that you need to use StepContextDict from macmini6,2."
echo "Finished, reboot now please."
#!/bin/bash
#
sudo touch /System/Library/Extensions/
sudo chown -R root:wheel /System/Library/Extensions/
sudo chmod -R 755 /System/Library/Extensions/
sudo kextcache -system-prelinked-kernel
sudo kextcache -system-caches
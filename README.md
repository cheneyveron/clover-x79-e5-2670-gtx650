# Hackintosh Clover for 华南(HUANAN) X79

## Matherboard: HUANAN X79

Bios Verion 2.46

Make sure to:

- Disable Serial Port
- Disable VT-d
- Disable USB ECHI
- Enable USB XHCI

This DSDT is valuable.

## CPU: E5-2670 v2 C2

Single CPU

It's better to buy E5-2670 v2 C1 rather than C2 cuz VT-d is useless

Frequency change from 1.2 to 3.3, levels not counted.

run 10.12 aicpm patch.command -> AICPMPatch -> caches_rebuild.command

before that the frequency will be locked to 2.6 GHz or 1.2 GHz.

## Graphic: GTX 650

Driver free

Note: EI Capitan and Sierra requires DVI or HDMI port. VGA is not supported.

And, you must install with nv_disable=1 or impossible to go into system.

After installation, run AGDPfix.app. After Fixing, go to /System/Library/Extensions/AppleGraphicsControl.kext/Contents/PlugIns/AppleGraphicsDevicePolicy.kext/Contents/Info.plist

change ConfigMap one of the Models to your SMIBIOS, in my config that is Mac-F65AE981FFA204ED

then reboot and remove nv_disable=1

## Netcard: Rtl8100/8600

Works fine using kext.

## Sound card: Reltek ALC662

Not sure what has been done but now it works fine.

I bought a USB sound card offline and it just worked.

# Supported Systems:

- 10.10 Yosemite: Not tested.

- 10.11 El Capitan: Perfect.

- 10.12 macOS Sierra: Perfect.

# Clover Tips:

## BOOTX64.efi and boot matters

## Necessary kexts:

- FakeSMC.kext
- RealtekRTL8111.kext
- USBInjectAll.kext
- VoodooTSCSync.kext

# Refs:

I stealed from:

PCBeta: http://bbs.pcbeta.com/viewthread-1720390-1-1.html

PCBeta: http://bbs.pcbeta.com/viewthread-1724967-1-1.html

And the whole bbs.pcbeta.com

Thank you all for the efforts.

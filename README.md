# Hackintosh Clover for 华南(HUANAN) X79

你们期待的中文版在[这里](https://github.com/cheneyveron/clover-x79-e5-2670-gtx650/blob/master/docs/读我.md).

## Change log:

2017/09/30: https://github.com/cheneyveron/clover-x79-e5-2670-gtx650/blob/master/docs/chage-log-2017-09-30.md

I'd recommend you read the change logs before updating.

# Hardware Specifications:

## Matherboard: HUANAN X79

Bios Verion 2.46

Clover Version 4220

Make sure to:

- Disable Serial Port
- Disable VT-d
- Disable USB ECHI
- Enable USB XHCI

This DSDT and SSDT is valuable. CPU frequency change and USB relies on them.

## CPU: E5-2670 v1 C2

Single CPU

It's better to buy E5-2670 v1 C1 rather than C2 cuz VT-d is useless

With the updated rom, Frequency change between (1.2 / 1.9 / 2.3 / 2.6 / 3.0 / 3.1 / 3.2 / 3.3), 8-levels.

~~**I'm currently working on it to get more levels.**~~ I have achieved that within a day, cheers!

Without flushing the rom, After Installation, run

`10.12 aicpm patch.command` -> `caches_rebuild.command`

before that the frequency will be locked to 2.6 GHz or 1.2 GHz.

Note that for `El Capitan`, you need to run

`10.12 aicpm patch.command` -> `AICPMPatch` -> `caches_rebuild.command`

## Graphic: GTX 650

Driver free

Now I use `Lilu.kext` and `NvidiaGraphicsFixup.kext` to void black screen.

Set SMIBIOS Model to MacPro6,1 now Graphic card can change frequency between 1 and 5 GHz.

Dota2 is very fluent, that's enough for me :)

## Graphic 2: GTX 1050TI

**DO NOT INSTALL ANY SYSTEM UPDATE AFTER INSTALLING WEB DRIVER!!!**

Install the latest Web Driver.

In order to install the latest driver for High Sierra, Make sure you have SIP turned on. Otherwise you can install but cannot get graphics acceleration.

Add `CsmVideoDxe-64.efi` so that Clover can display 1080P at boot screen.

But this will slow boot time up to 4 sec.

If you do not care about boot resolution but care about speed, just delete `CsmVideoDxe-64.efi`

## Netcard: Rtl8100/8600

Works fine using kext.

## Sound card: Reltek ALC662

Works fine using VoodooHDA.

# Supported Systems:

- 10.10 Yosemite: Not tested.

- 10.11 El Capitan: Not tested.

- 10.12.6 macOS Sierra: Perfect.

- 10.13 macOS High Sierra: Perfect.

# Clover Tips:

## BOOTX64.efi and boot matters

## Kexts:

Recommended kexts are in `kexts/other`, while other optional kexts are in `kexts/Other_Optional`.

## driver64UEFI:

Recommended UEFI drivers are in `drivers64UEFI`, optional drivers in case you need are in `driver64UEFI_Optional`.

## Fusion Drive:

Follow this [guide](https://github.com/cheneyveron/clover-x79-e5-2670-gtx650/blob/master/docs/fusion-drive-set-up.md).

## About Solving 10.13 AppleACPIPlatform(MACH Reboot):

Just use this updated dsdt.

Wanna see my solving process?

My [blog](https://www.itmanbu.com/appleacpiplatform.html)(Chinese).

[PCbeta](http://bbs.pcbeta.com/viewthread-1753833-1-1.html)(aka 远景论坛)(Chinese).

[Insanelymac](http://www.insanelymac.com/forum/topic/326200-new-possibilities-for-x79-appleacpiplatform-panic)(English).

# Refs:

I stealed from:

PCBeta: http://bbs.pcbeta.com/viewthread-1720390-1-1.html

PCBeta: http://bbs.pcbeta.com/viewthread-1724967-1-1.html

Tonymacx86.com: https://www.tonymacx86.com/threads/black-screen-with-macpro-6-1-or-imac-15-or-imac-17-system-definition.183113/

And the whole bbs.pcbeta.com insanelymac.com

Thank you all for the efforts.

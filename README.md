# Hackintosh Clover for 华南(HUANAN) X79

# Update Note(2017/09/26):

## 1. Change log of HNX7946.rom

- Replaced DSDT table to fix `AppleACPIPlatform _isspace panic` and `USB`.

With this Rom, there's no need to patch any ACPI tables.

- Unlocked `msr` register for frequency change.

Now you can enjoy native CPU Power Management including frequency change and aleep with macOS Sierra and High Sierra without *ANY* patches.

- Rewrote `DMI` information.

So that AIDA64 / Ludashi recognized this PC as a Mac Pro.

But donot worry, this has *NOTHING* to do with macOS!

macOS only read SMBIOS information from Clover, only Windows and Linux read it from BIOS.

- Replaced `FileSystem` with `HFSPlus` and `EnhancedFat`

For better performance.

### How to flush the bios?

1. Make a bootable DOS U disk, with `MaxDos9.0.iso` using `USBWriter` or `UltraISO`.
2. Download `fpt` flush tool and copy it into U disk together with `HNX7946.rom`.
3. Boot into that U disk, and run `fpt -f HNX7946.rom`.

## 2. Change log of Clover

- *Version*: 4220
- *ACPI*: Removed all ACPI patches.
- *KextToPatch*: Only kept Trim and Icon.
- *Gui*: Added `Install High Sierra!!!!`, Removed all hide volumes, so that you can install macOS on a Fusion Drive now.
- *Rt Variables*: `CsrActiveConfig` changed to `0x00`, that is to turn on full SIP(System Integration Protect).
- `drivers64UEFI`: Added `OsxAptioFix2Drv-free2000.efi` to boot when SIP is on.
- `ACPI/Patched`: Removed DSDT, because the DSDT is inside the new BIOS rom now.

### A few comments:

1. If you decide not to flush your BIOS, you may need to put `for-old-rom/dsdt/dsdt.aml` and `ssdt.sml` inside `/EFI/Clover/ACPI/patches`.
2. Inside `drivers64UEFI`, I updated all old efi drivers and added `apfs.efi`. But `apfs.efi` will show several lines before Clover show up. If you do not use `APFS Filesystem`, just delete it.
3. Updated `VoodooHDA.kext` to `2.9.0` which supports 5.1 sound.
4. If you do not flush your BIOS, CPU requency will not change when SIP is turned on, in order to install `NVIDIA Web Driver`(version 378.10.10.10.15.114).

### About SIP:

1. The `CsrActiveConfig` inside `Rt Variables` controls the status of SIP.
2. Set to `0x00` means all SIP options are enabled.
3. And `0x67` means all disabled.
4. With a fully enabled SIP, you cannot MODIFY(aka Patch) any kexts or INSTALL untrusted kexts into `/System/Library/Extensions` or system will fail to boot!

### About `config-no-web-drive.plist` and `config-web-drive.plist`:

1. The only difference is that `config-web-drive.plist` enables full SIP.
`config-no-web-drive.plist` disables full SIP.
2. `NVIDIA Web Driver`(version 378.10.10.10.15.114) requires full SIP in order to perform correctly.
3. I would suggest that you have a fresh install of macOS High Sierra because in order to change CPU frequency, multiple kexts inside `S/L/E` are modified so system will fail to boot after SIP is turned on.

### About Fusion Drive:

In order to enjoy speed while having super fast speed, Apple create Fusion Drive. This is the most intelligent `Disk Cache` technology in this world, so why not use it :)

*How to create:*

1. List all drives:

````diskutil list````

2. Create a fusion drive:

````diskutil cs create "Cheney Fusion Drive" disk0 disk1````

Copy that uuid it genetates.

3. Partition a fusion drive:

````diskutil cs createVolume BDF819F4-06C0-4D49-943A-1A23E8B20928 jhfs+ "Macintosh FD" 100%````

You are done on a mac. But on a Hackintosh, you will find that Clover fails to recognize your Fusion Drive after first stage.

If you use my config, then there is a `Install High Sierra!!!!` in `Gui`. But you need a little modification.

4. List all drives:

````diskutil list````

Find the SSD inside you Fusion Drive. There will be 3 partitions , names `EFI`, `Apple...`, `Boot OS X`.
You need the `IDENTIFIER` of `Boot OS X`, which looks like `disk0s3`.

5. Mount `Boot OS X` of your SSD inside your Fusion Drive:

````diskutil mount /dev/disk0s3````

6. Change Volume:

Use `Clover Configurator` open this `config.plist`, select `gui`.

Inside `Custom Entries`, change `Volume` to `Boot OS X` you mounted just now.

And you're all done with Fusion Drive, suprise!

# About Solving 10.13 AppleACPIPlatform:

Just use this updated dsdt.

Wanna see my solving process?

Here in my blog(Chinese): https://www.itmanbu.com/appleacpiplatform.html

PCbeta(Chinese): http://bbs.pcbeta.com/viewthread-1753833-1-1.html

Insanelymac(English): http://www.insanelymac.com/forum/topic/326200-new-possibilities-for-x79-appleacpiplatform-panic

# Hardware Specifications:

## Matherboard: HUANAN X79

Bios Verion 2.46

Clover Version 4114

Make sure to:

- Disable Serial Port
- Disable VT-d
- Disable USB ECHI
- Enable USB XHCI

This DSDT and SSDT is valuable. CPU frequency change and USB relies on them.

## CPU: E5-2670 v1 C2

Single CPU

It's better to buy E5-2670 v1 C1 rather than C2 cuz VT-d is useless

With the updated rom, Frequency change from 1.2 to 3.3, levels not counted.

Without flushing the rom, After Installation, run

`10.12 aicpm patch.command` -> `AICPMPatch` -> `caches_rebuild.command`

before that the frequency will be locked to 2.6 GHz or 1.2 GHz.

## Graphic: GTX 650

Driver free

Now I use `Lilu.kext` and `NvidiaGraphicsFixup.kext` to void black screen.

Set SMIBIOS Model to MacPro6,1 now Graphic card can change frequency between 1 and 5 GHz.

Dota2 is very fluent, that's enough for me :)

## Graphic 2: GTX 1050TI

Driver free:

Just install the latest Web Driver.

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

## Necessary kexts:

- FakeSMC.kext
- RealtekRTL8111.kext
- USBInjectAll.kext
- VoodooTSCSync.kext
- Lilu.kext
- NvidiaGraphicsFixup.kext


# Refs:

I stealed from:

PCBeta: http://bbs.pcbeta.com/viewthread-1720390-1-1.html

PCBeta: http://bbs.pcbeta.com/viewthread-1724967-1-1.html

Tonymacx86.com: https://www.tonymacx86.com/threads/black-screen-with-macpro-6-1-or-imac-15-or-imac-17-system-definition.183113/

And the whole bbs.pcbeta.com insanelymac.com

Thank you all for the efforts.

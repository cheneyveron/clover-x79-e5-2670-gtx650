# Hackintosh Clover for 华南(HUANAN) X79

## Matherboard: HUANAN X79

Bios Verion 2.46

Make sure to:

- Disable Serial Port
- Disable VT-d
- Disable USB ECHI
- Enable USB XHCI

This DSDT and SSDT is valuable. CPU frequency change relies on them.

## CPU: E5-2670 v1 C2

Single CPU

It's better to buy E5-2670 v1 C1 rather than C2 cuz VT-d is useless

Frequency change from 1.2 to 3.3, levels not counted.

After Installation,run

```10.12 aicpm patch.command``` -> ```AICPMPatch``` -> ```caches_rebuild.command```

before that the frequency will be locked to 2.6 GHz or 1.2 GHz.

## Graphic: GTX 650

Driver free

Now I use ```Lilu.kext``` and ```NvidiaGraphicsFixup.kext``` to void black screen.

Set SMIBIOS Model to MacPro6,1 now Graphic card can change frequency between 1 and 5 GHz.

Dota2 is very fluent, that's enough for me :)

## Netcard: Rtl8100/8600

Works fine using kext.

## Sound card: Reltek ALC662

Works fine.

# Supported Systems:

- 10.10 Yosemite: Not tested.

- 10.11 El Capitan: Perfect.

- 10.12 macOS Sierra: Perfect.

- 10.13 macOS High Sierra: Waiting for clover update.

# Clover Tips:

Do not change config.plist SMIBIOS ACPI and RT Variables.

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

And the whole bbs.pcbeta.com

Thank you all for the efforts.

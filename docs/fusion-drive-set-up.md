In order to enjoy big volume while having super fast speed, Apple created Fusion Drive. After comparing to those hyper-disks, I believe this is the most intelligent `Disk Cache` technology in this world, so why not use it :)

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

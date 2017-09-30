为了既能获得大容量，又能获得高速度，苹果公司创建了 Fusion Drive。与其他的混合硬盘技术对比以后，俺确信它是世界上最先进的 `磁盘缓存` 技术，所以何不用起来 :)

# 创建方法：

1. 列出所有磁盘:

````diskutil list````

2. 建立一块 fusion drive:

````diskutil cs create "Cheney Fusion Drive" disk0 disk1````

建立完成后，它会告诉你一个uuid，复制下来。

3. 给这个 fusion drive 分区:

````diskutil cs createVolume BDF819F4-06C0-4D49-943A-1A23E8B20928 jhfs+ "Macintosh FD" 100%````

如果你是一台Mac，那到这里已经完事儿了。但是在黑苹果上,你会发现Clover无法识别出你的Fusion Drive，所以安装完第一阶段后你就进不了第二阶段了。

# 对于黑苹果：

你可以参考一下俺的`config.plist`文件，在 `Gui`里边有一个叫做 `Install High Sierra!!!!` 的启动项，你只需要稍作修改就行：

4. 列出所有的分区和硬盘:

````diskutil list````

找到你创建的 Fusion Drive 中的那块SSD，SSD中会有 3 个分区，名字分别是 `EFI`, `Apple...`, `Boot OS X`。
你需要记住  `Boot OS X` 的 `IDENTIFIER` ，它长这个样子 `disk0s3`。

5. 挂载Fusion Drive中的SSD中的 `Boot OS X` 分区：

````diskutil mount /dev/disk0s3````

6. 修改 `Install High Sierra!!!!` 启动项:

使用 `Clover Configurator` 打开这个 `config.plist`，进入 `gui`。

在 `Custom Entries` 中，把 `Volume ` 修改成你刚才挂载的 `Boot OS X` 分区。

这样就大功告成啦！

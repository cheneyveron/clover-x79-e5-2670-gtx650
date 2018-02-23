# 黑苹果 四叶草 for 华南 X79 V2

English Version is [HERE](https://github.com/cheneyveron/clover-x79-e5-2670-gtx650/blob/master/docs/README.md).

国内同步镜像：https://gitee.com/cheneyveron/clover-x79-e5-2670-gtx650

如果有兴趣探索更快更暴♂力的Ozmosis启动方式，欢迎关注我的新Repo： [黑苹果 Ozmosis for 华南 X79 V2.4X](https://github.com/cheneyveron/ozmosis-huanan-x79-e5-2670)

## 资助

俺花费了一些时间和精力在上面，如果此项目帮助到了您，欢迎来资助我继续完善它。资助名单在最下方。

注意：这不是有偿协助，俺的时间非常有限，遇到问题请尽量提交issues，自己摸索。

Paypal : [paypal.me/cheneyveron](https://paypal.me/cheneyveron)

![支付宝与微信支付](https://github.com/cheneyveron/clover-x79-e5-2670-gtx650/blob/master/docs/IMG_0112.jpg)

## 变更记录:

2018/2/7: 更新Realtek 8111驱动; 更新Clover;

2018/1/17: 更新AppleALC，修复macOS High Sierra更新17C205后不出声音。

2018/1/15:

1. 添加DSDT补丁支持12核心处理器；
2. 添加原版BIOS，处理器与内存未超频、未修改DSDT；
3. 更新Clover到4369；

2017/12/18: VoodooHDA换成了AppleALC；更新lilu、CPUFriend；

2017/11/24: 更新了BIOS工具。

2017/11/22: 修复10.13.1下安装时的`OsxAptioFixDrv`错误。

2017/10/28: 添加多种CPU的变频SSDT，添加BIOS刷新工具。

2017/10/10: 更新apfs.efi避免了开机界面打印Log。

# 1 小白食用说明:

[进阶说明](https://github.com/cheneyveron/clover-x79-e5-2670-gtx650/blob/master/docs/变更说明.md)

## 1.1 主板: 华南 X79 V2

主板版本 2.46

**BIOS版本 2.47**

四叶草 版本 4369

所有操作前，务必在BIOS中:

- 关闭串口 (Serial Port)
- 禁用 VT-d
- 禁用 USB ECHI
- 开启 USB XHCI

### 1.1.1 我能不能刷BIOS？

如果你满足下面的条件：

- 华南金牌主板（418块钱左右的）
- ATX版型（大版型）
- 蓝色内存插槽

那么你可以刷新BIOS。更详细的说明，和刷新方法不属于小白范畴，请阅读上面的“进阶说明”。

#### 1.1.1.1 我的CPU是xxx，显卡是xxx，可以刷吗?

可以。BIOS只与主板有关，与CPU、显卡、键鼠无关。

#### 1.1.1.2 刷了之后还能装Windows/Linux吗?

可以。俺把DSDT中的USB命名/CPU部分规范了一下而已。

### 1.1.2 我需不需要刷新BIOS？

如果你同时满足下面两个条件：

1. 使用NVIDIA的显卡，并且需要安装NVIDIA Web Driver。
2. 打算安装macOS High Sierra

那么推荐你刷新BIOS，否则CPU将无法变频。

其中一项不满足，则**不需要**刷新BIOS。

因为在High Sierra中，为了安装Web Driver你必须开启SIP。一旦开启SIP，你就不能给系统文件打补丁来解锁msr寄存器了。此寄存器不解锁，则CPU不能变频。

好好理解一下上面这句话。至于SIP是什么，请阅读上面的“进阶说明”。

### 1.1.3 我和你的主板不完全一样怎么办？

如果同是X79主板，用我的EFI问题都不大。

### 1.1.4 我应该放某个DSDT.aml吗？

如果你不清楚该不该放，那就不要放。

在ACPI Patches中我已经添加了足够多的补丁，通常不需要额外再修改DSDT就可以正常安装启动了。

而且，放了与你硬件不兼容的DSDT会导致一些难以预料的问题。

不过，SSDT还是要可以放的。

## 1.2 CPU变频: E5-2670 v1

E5-2670 C2 与 C1的唯一区别，就是C2支持VT-d技术（硬件虚拟化，不是咱们说的VMware使用到的虚拟化技术），而C1不支持。咱们并不能用得到VT-d技术，所以就是白白多花钱了。而对于服务器来说，不支持VT-d的CPU就是有致命缺陷的，基本上白菜价就卖。

### 1.2.1 如果你刷新了BIOS：

直接安装系统处理器频率就有八档（1.2 / 1.9 / 2.3 / 2.6 / 3.0 / 3.1 / 3.2 / 3.3）。

### 1.2.2 如果你没有刷新BIOS：

安装完系统后，按照系统版本去attachments文件夹中寻找相应的解锁MSR的补丁，然后运行：

`AICPM` -> `caches_rebuild.command`

对于`El Capitan`系统，你需要运行：

`AICPM`->`10.11 aicpm patch.command`->`caches_rebuild.command`

否则的话，处理器频率将会锁定在 2.6 GHz 或者 1.2 GHz。

### 1.2.2 如果你的CPU不是E5-2670 V1：

上面这些步骤还是要做的，除此之外，你还需要将`EFI/Clover/ACPI/SSDT.aml`文件换成对应处理器的SSDT。

在`attachments/SSDT-1`中我搜集了一些SSDT，它们未必能用，如果运气不好的话你就需要自己用`ssdtGen.sh`来生成了。

在这里感谢 rampagedev.com 提供的SSDT。

更多关于变频的消息，也请阅读上面的“详细修改说明”。

## 1.3 对于NVIDIA显卡

请将`config-nvidia-card.plist`改名为`config.plist`。

### 1.3.1 显示器无输出

我在`EFI/Clover/kexts/Other`中使用了 `Lilu.kext` 与 `NvidiaGraphicsFixup.kext` 这俩驱动配合解决“显示器无输出”的问题。你不用任何操作。

### 1.3.2 图形加速

如果装好了系统却没有图形加速效果，安装Web Driver即可。

**装好WEB DRIVER以后切记不要安装系统更新！！！**

在 High Sierra 中，你得开启 SIP 以后才能安装上 Web Driver。如果你不开启 SIP ，也可以强行继续安装，但是装好以后没有图形加速效果。

### 1.3.3 高清启动界面

我在ROM中添加了CsmVideoDxe模块，如果你刷新了BIOS，那么什么都不用做，享受即可。

如果不刷新BIOS，那么手动将`EFI/Clover/driver64UEFI_Optional`下的`CsmVideoDxe.efi`添加到`EFI/Clover/drivers64UEFI`文件夹中即可。

## 1.4 对于AMD显卡

请将`config-amd-card.plist`改名为`config.plist`，然后删除`NvidiaGraphicsFixup.kext`。

俺没有AMD显卡，所以你只能靠你自己了。所幸，AMD的显卡大都很好配置，至少不会因为安装了不当的驱动导致系统崩溃。

## 1.5 网卡: Rtl8100/8600

就是它驱动起来的网卡：`kexts/other/RealtekRTL8111.kext`。

## 1.6 声卡: Reltek ALC662 V3

为了更好的音质，使用了AppleALC驱动。关键Kext为：

`Lilu.kext`、`AppleALC.kext`、`HDAEnabler.kext`。

如果有爆音，尝试在 Clover Configurator -> Boot 中设置为`darkwake=no`。

如果不是ALC662 V3的声卡，可以使用`EFI/Clover/kexts/Optional`中的`VoodooHDA`万能声卡驱动。其中：

VoodooHDA 2.8.9：只支持双声道。

VoodooHDA 2.9.0：支持5.1声道。

# 2 macOS兼容性:

- 10.10 Yosemite: 未测试.

- 10.11 El Capitan: 良好.

- 10.12 macOS Sierra: 良好.

- 10.13.1 macOS High Sierra: 良好.

# 3 其他常见问题

## 3.1 Fusion Drive/Raid如何配置:

见 [这个指南](https://github.com/cheneyveron/clover-x79-e5-2670-gtx650/blob/master/docs/fusion-drive-设置.md).

## 3.2 10.13 AppleACPIPlatform(MACH Reboot)

在本EFI中附带的两个plist中，`ACPI -> Patch`部分有四个补丁名字为`CUU0`到`CUU3`，将他们添加到自己的配置文件中即可。

想看看解决过程？

[俺的博客](https://www.itmanbu.com/appleacpiplatform.html)(中文).

[远景论坛](http://bbs.pcbeta.com/viewthread-1753833-1-1.html)(中文).

[Insanelymac](http://www.insanelymac.com/forum/topic/326200-new-possibilities-for-x79-appleacpiplatform-panic)(英文).

## 3.3 我能更新kexts吗？

其他kexts随便更新，但是`lilu.kext`更新后需要更新CPUFriend.kext、重新生成对应的CPUFriendProvider.kext、更新AppleALC才行。

### 3.3.1 如何更新 AppleALC:

下载新版的`lilu.kext`、`AppleALC.kext`替换`EFI/Clover/kexts`中的即可。

### 3.3.2 如何更新 CPUFriend:

1. 下载新版的`CPUFriend.kext`和CPUFriend的Git仓库
2. 运行`ResourceConverter.sh`，指定`X79PlatformPlugin.kext`中的`Mac-F60DEB81FF30ACF6.plist`来生成`CPUFriendProvider.kext`
3. 替换上去即可

## 3.4 Failed getting nvram

原因：你用了不适合的DSDT。

解决方法：删掉`EFI/Clover/ACPI/patched/DSDT.aml`。

## 3.5 Freeing low memory (up tp 0x20000000)...

原因：CPU在释放2MB内存时卡死。

解决方法：先重启试试。如果不行，就尝试将`drivers64UEFI/OsxAptioFix2Drv-free2000.efi`与`driver64UEFI_Optional/OsxAptioFix2Drv-64.efi`互换。

## 3.6 OsxAptioFixDrv...

兄dei，你该更新俺的新版EFI了。

# 4 致谢:

- [Apple](https://www.apple.com)：研发的 macOS 系统
- [Clover EFI bootloader](https://sourceforge.net/projects/cloverefiboot/)：强大的通用操作系统引导器
- @[**vit9696**](https://github.com/vit9696)：制作 Lilu & AppleALC
- [Piker.R.Alpha](https://pikeralpha.wordpress.com/)：对AICPM做出的研究、制作 ssdtPRGen.sh
- [Alext James](https://alextjam.es/)(@**TheRaceMaster**)：对ACPI表的解析问题的分析
- @[**PMHeart**](https://github.com/PMheart)：制作 CPUFriend，并热心的帮助了我
- @[**stinga11**](http://www.insanelymac.com/forum/user/408886-stinga11/)：X79系列CPU变频的研究
- [Rampage Dev](http://rampagedev.com)：提供的 SSDT
- @[**shilohh**](https://www.tonymacx86.com/members/shilohh.312762)：解决NVIDIA显卡无输出问题
- @**flipphos** & @**zouyanggary** & @**jameszhang18910780315**：BIOS方面的资讯
- @**zouyanggary** & **kaeserlin**：提供的AppleALC方面的资讯
- [远景论坛](http://bbs.pcbeta.com) & [Tonymacx86](https://www.tonymacx86.com) & [InsanelyMac](http://www.insanelymac.com)：提供交流的场所

## 资助列表：

| 昵称              | 金额   | 备注   | 时间         |
| --------------- | ---- | ---- | ---------- |
| [ 未知]              | ￥10   | 微信   | 2018.2.23  |
| [ 未知]              | ￥10   | 微信   | 2018.2.20  |
| 旭顺              | ￥8.88   | 支付宝   | 2018.2.17  |
| 哈尼              | ￥10   | 微信   | 2018.2.9  |
| [未知]              | ￥15   | 微信   | 2018.1.25  |
| JYS              | ￥10   | 微信   | 2018.1.24  |
| OldMonster | ￥1   | 微信   | 2018.1.17  |
| cheng           | ￥1   | 支付宝  | 2017.12.29 |
| [未知]            | ￥5   | 微信   | 2017.12.25 |

# 黑苹果 四叶草 for 华南 X79 V2

English Version is [HERE](https://github.com/cheneyveron/clover-x79-e5-2670-gtx650/blob/master/docs/README.md).

国内同步镜像：https://gitee.com/cheneyveron/clover-x79-e5-2670-gtx650

感谢热心网友**Will.i.am**资助了我一块华南烈焰x79的主板。

## 一、macOS 11 Big Sur特别说明:

**注意：Big Sur的支持并不完善，建议先另分一个区安装测试，没问题后再升级。有修正想法的朋友们，欢迎PR。** 

如果不需要升级Big Sur，请直接到[Release](https://github.com/cheneyveron/clover-x79-e5-2670-gtx650/releases)下载旧版本EFI即可。

### 1. DSDT改动

由于寨板版型众多，此处列举的未必全面。请根据`EFI/OC/ACPI/DSDT-SAMPLE.aml`或者`DSDT-SAMPLE2.aml`对照修改自身DSDT。

感谢 @szcxs 提供了示例DSDT。

#### 1) 三个变量的默认值修改：
- Name (BRL, 0xFF)
- Name (MBB, 0xCC000000)
- Name (MBL, 0x34000000)

由于这三个变量初始值未必一致，所以请自行搜索BRL，MBB，MBL修改。

#### 2) Processor方法

有些主板的第二个参数原本是统一的0x00，需要改成下面的：
- C000-C00F 映射 0x00-0x0F
- C010-C01F 映射 0x10-0x1F
- C100-C10F 映射 0x20-0x2F
- C110-C11F 映射 0x30-0x3F
- C200-C20F 映射 0x40-0x4F
- C210-C21F 映射 0x50-0x5F
- C300-C30F 映射 0x60-0x6F
- C310-C31F 映射 0x70-0x7F

举例：

映射前：`Processor (C005, 0x00, 0x00000410, 0x06)`

映射后：`Processor (C005, 0x05, 0x00000410, 0x06)`

1. 注1：2.49版本的BIOS中已经修复了此问题。
2. 注2：DSDT Patch因主板而异。

#### 3) 屏蔽设备^UNC0

直接删除，或者在它的_STA方法里返回(Zero)

我未能用SSDT屏蔽该设备，请求对ACPI规范熟悉的朋友们的帮助。

由于不推荐使用别人的dsdt，在此建议各位自行提取并修改DSDT。

## 二、OpenCore 说明

遵循OC的哲学，我会试图最小化改动来适应macOS。但是未必适合各位的主板。

最小化的改动包含如下内容：

### 1. ACPI部分
1. 加载按照上面说明修改过的DSDT.
2. 如果需要变频，则加载自己处理器的`SSDT-1.aml`. 如果不是2630L V2，请到`attachments/SSDT-1`中自行查找。

### 2. Kernel部分

1. Lilu.kext :用于注入其他驱动
2. VirtualSMC.kext :模拟SMC。不使用它也可以将`AppleSmcIo`置为`true`
3. VoodooTSCSync.kext :必须，否则卡第二阶段。修复CPU线程同步问题。
4. WhateverGreen.kext :用于修复可能存在的显示问题
5. AppleALC.kext :用于声音输出。也可以使用VoodooHDA代替。
6. RealtekRTL8111.kext :有线网卡驱动
7. USBMap.kext :USB端口映射文件。Big Sur下, USBInjectAll.kext未必能用，请使用[这里的工具](https://github.com/corpnewt/USBMap)生成。
8. CPUFriend.kext & CPUFriendDataProvider.kext :注入频率信息。

### 3. UEFI/Drivers

1. HfsPlus.efi :用于识别HFS+格式分区
2. OpenRuntime.efi :OpenCore核心环境

### 4. 其他Quirk

1. AllowNvramReset: true。否则无法重置nvram。
2. AllowSetDefault: true。否则无法使用Ctrl + 数字键设置默认系统。
3. BootProtect: None。
4. SecureBootModel: Disabled。
5. Vault：Optional。以上三个关闭OC安全启动功能。
6. boot-args：`-v keepsyms=1 debug=0x100 npci=0x3000`，必须添加`npci=0x3000`

## 三、Ryzen黑苹果方案

因x370硬件直通bug较多，工作繁忙无暇折腾，故换了z390。折腾的历史如下：

[我的博客](https://www.itmanbu.com/ryzen-hackintosh-using-kvm-proxmox.html)、[远景论坛](http://bbs.pcbeta.com/viewthread-1813655-1-1.html)、[hackintosh-clover-tachi-x370-1700x-rx570](https://github.com/cheneyveron/hackintosh-clover-tachi-x370-1700x-rx570)

## 四、Z390黑苹果方案

是目前最接近白果的体验，整好以后就不用折腾了，与我的MBP比起来几乎没有区别：

[hackintosh-clover-z390-aorus-pro-wifi-9700k-rx580](https://github.com/cheneyveron/hackintosh-clover-z390-aorus-pro-wifi-9700k-rx580)

## 五、资助

俺花费了一些时间和精力在上面，如果此项目帮助到了您，欢迎来资助我继续完善它。资助名单在最下方。

微信支付后还有个 **留言** 功能。如果只是在付款时填写“求助”而没有再留言，我是联系不上你的喔，下面单独填写的“手机号”我并不能看得见。我的icloud与邮箱是 `我的github用户名@live.cn`。 

注意：这不是有偿协助，俺的时间非常有限，遇到问题请尽量提交issues，自己摸索。

Paypal : [paypal.me/cheneyveron](https://paypal.me/cheneyveron)

![支付宝与微信支付](https://img.itmanbu.com//wp-content/uploads/2019/12/IMG_0112.jpg)

## 六、硬件详情

- 主板: 华南金牌 X79 V2.46 ATX
- CPU：E5-2630L V2
- 显卡：~~蓝宝石RX560（已点不亮）~~ 松景RX570 4G
- 内存：64GB 2RX4 DDR3 1333
- 声卡：ALC662 V3
- 网卡：Rtl8100/8600

## 七、变更记录:

2020/12/17: 支持11.0 Big Sur; 更新至OpenCore 0.6.4(2020-12-7);

2019/12/8:支持10.15.1 Catalina; 更新Clover至5099; 替换lilu等驱动为最新版;

## 八、小白食用说明:

目前的OpenCore + Big Sur还不适合小白食用。

## 九、致谢:

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
- @**szcxs**：提供参考用的DSDT。
- [远景论坛](http://bbs.pcbeta.com) & [Tonymacx86](https://www.tonymacx86.com) & [InsanelyMac](http://www.insanelymac.com)：提供交流的场所

## 资助列表：

| 昵称            | 金额     | 备注   | 时间         |
| ------------- | ------ | ---- | ---------- |
| @samalwaysloveher | ￥99 | 微信 | 2020.12.7 |
| F\*n | ￥10 | 微信 | 2020.3.10 |
| L\*g      | ￥30 | 微信 | 2019.12.3 |
| \*苏      | ￥10 | 微信 | 2019.11.2 |
| \*花      | ￥1 | 微信 | 2019.10.27 |
| l\*F      | ￥6.66 | 微信 | 2019.8.24 |
| \*.      | ￥10 | 微信 | 2019.8.24 |
| h\*1      | ￥9.96 | 微信 | 2019.6.27 |
| \*絮      | ￥1 | 微信 | 2019.6.13 |
| A\*.      | ￥3.5 | 微信 | 2019.6.8 |
| lucasam      | ￥88 | 微信 | 2019.5.21 |
| \*牛      | ￥9.9 | 微信 | 2019.5.7 |
| Will.i.am      | ￥500+ | 烈焰战神X79 | 2019.5.1 |
| 大仁            | ￥33.33 | 微信   | 2018.12.7  |
| \*仁           | ￥14.76 | 微信   | 2018.11.27 |
| \*年           | ￥50    | 微信   | 2018.11.20 |
| 麦\*n          | ￥3     | 微信   | 2018.11.17 |
| \*杰           | ￥1     | 微信   | 2018.11.5  |
| C\*r          | ￥9.66  | 微信   | 2018.11.1  |
| 黄海            | ￥6.66  | 微信   | 2018.10.25 |
| L             | ￥6.66  | 微信   | 2018.9.27  |
| L             | ￥0.66  | 微信   | 2018.9.26  |
| Joooohnnnn    | ￥5     | 微信   | 2018.9.21  |
| C\*e          | ￥10    | 微信   | 2018.6.15  |
| \*!           | ￥2     | 微信   | 2018.5.16  |
| \*宾           | ￥10    | 微信   | 2018.5.15  |
| \*ᝰ           | ￥1     | 微信   | 2018.4.21  |
| \*空           | ￥50    | 微信   | 2018.4.21  |
| \*峰           | ￥8.8   | 微信   | 2018.4.20  |
| [未知]          | ￥10    | 微信   | 2018.4.18  |
| [未知]          | ￥10    | 微信   | 2018.4.17  |
| [未知]          | ￥10    | 微信   | 2018.4.10  |
| AURORA极光映像-冠子 | ￥40    | 微信   | 2018.4.5   |
| [未知]          | ￥3     | 微信   | 2018.3.9   |
| [未知]          | ￥10    | 微信   | 2018.2.26  |
| [未知]          | ￥10    | 微信   | 2018.2.23  |
| [未知]          | ￥10    | 微信   | 2018.2.20  |
| 旭顺            | ￥8.88  | 支付宝  | 2018.2.17  |
| 哈尼            | ￥10    | 微信   | 2018.2.9   |
| [未知]          | ￥15    | 微信   | 2018.1.25  |
| JYS           | ￥10    | 微信   | 2018.1.24  |
| OldMonster    | ￥1     | 微信   | 2018.1.17  |
| cheng         | ￥1     | 支付宝  | 2017.12.29 |
| [未知]          | ￥5     | 微信   | 2017.12.25 |


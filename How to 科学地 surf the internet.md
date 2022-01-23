这篇文章引自[Tecrobe's Blog](https://tecrobe.github.io/blog)



# 如何翻墙[1]: 什么是墙？简述 GFW 的发展历史和主要技术

# 什么是墙？

> **防火长城**（英语：**Great Firewall**，常用简称：**GFW**，中文也称**中国国家防火墙**，中国大陆民众俗称**墙**、防火墙、功夫网等等），是对中华人民共和国政府在其互联网边界审查系统（包括相关行政审查系统）的统称。

> 此系统起步于1998年，其英文名称得自于2002年5月17日Charles R. Smith所写的一篇关于中国网络审查的文章《The Great Firewall of China》，取与Great Wall（长城）相谐的效果，简写为Great Firewall，缩写GFW。随着使用的拓广，中文“墙”和英文“GFW”有时也被用作动词，网友所说的**“被墙”**即指网站内容被防火长城所屏蔽或者指服务器的通讯被封阻，**“翻墙”**也被引申为突破网络审查浏览境内外被屏蔽的网站或使用服务的行为。

—— 引自维基百科

![GFW](https://tecrobe.github.io/blog/image/gfw.png)

# 背景知识

## IP 地址

在互联网中，IP 地址相当于一台主机的门牌号，你需要知道对方的 IP 地址，才能与其通信。

根据互联网协议规定，互联网中的数据包必须包括目标主机的 IP 地址，这样，网络中的路由设备才能将数据包发送到对应的主机。

而在互联网中发送一个数据包，可以用寄信来类比。

首先，你得注明寄信人（你的 IP 地址），和收信人（对方主机 IP 地址），然后得把信件交给快递员（路由设备），由快递员交给收信人。

爱思考的同学可能会发现，上述过程中并不包括**验证**机制。信件能否寄出去，以及回信是否靠谱，都要看快递员（网络中的路由设备）。假如快递员伪造/丢弃信件，你也没办法。

## DNS

在互联网的实际应用中，人们发现，IP 地址太难记了（形如: 172.16.254.1 或 2001:db8:0:1234:0:567:8:1 ），而且实际使用起来也不方便。于是人们便发明了 DNS 这种东西。

在有了 DNS 以后，人们寄信（上网）就不需要记住门牌号（IP 地址）了，只需要知道收信人（目标主机）的别名（域名）即可。

比如你要寄信给 Google，只需要知道他的别名叫 www.google.com 就可以了。

此时，你在寄信给 Google 之前，还需要先寄信给 DNS（你是事先知道 DNS 的门牌号的，因为他们的门牌号比较好记，都是 8.8.8.8 或 1.1.1.1 这种特殊地址） ，问问 www.google.com 的门牌号是多少，然后按照 DNS 的回信内容填写信件收信地址，有了收信地址之后，才能把信件交给快递员。

值得注意的是，在 DNS 查询过程中，同样**没有验证机制**，也就是说在如果 DNS 给你的回信是伪造的，你也无法得知，只能按照回信内容填写地址。

## SNI

从上面的例子大家可以看到，如果不增加任何验证机制，互联网是十分不靠谱的！而那些设计互联网的工程师们当然没闲着，为了让互联网传输有保障，他们设计了 TLS(传输层安全协定） 这个东东。

这个东东在当今互联网上十分重要，因为它不仅为“信件”提供了**验证机制**，而且还会将传输的数据加密，以避免中间人偷窥/篡改。

那么怎么知道有没有用上 TLS 呢？你只需要向上看看浏览器的地址栏，如果是 https:// 开头，证明对方主机（网站）启用了 TLS，你和他的通信内容安全有保障啦！如果是 http:// 开头，那么要么是这个网站提供者认为传输的内容不重要，要么就是这个网站太旧，或管理员不作为。这里再批评一下科大讯飞，他旗下的网站全部是 http:// 明文传输内容，甚至连密码也不例外。也就是说你其网站登录时，密码会明文传输给科大讯飞的主机，中间经过的所有路由设备都可以看见你的密码。因此对隐私在意的同学，不妨给这些网站单独设置一个密码。

说了这么多 TLS，差点就扯远了。上面说道 TLS 能保证通信安全靠谱，那它难道就没有缺陷了吗？当然不是。

继续按照上面快递员的举例，由于房价日益上涨（误），许多人选择合租在一间房子里（共用一个 IP 地址），在不使用 TLS 时，只需要在信中交代对方的别名（Host 头）即可，快递员会把信送到正确的人手中。而使用 TLS 之后，快递员不能看到信中的内容，也就只能将信送到这间屋子，具体给谁他就不知道了。而且，由于合租的大多是陌生人，如果给错了不太合适，那么快递员只好将信丢弃了。

为了解决这个问题，人们便把收信人别名写在信封上，这样快递员就能把信送到正确的人手上，这信封上写的别名，就是 SNI (Server Name Indication)。这个简单方便的解决措施，虽然解决了问题，可是也就方便了快递公司对于某个举报其作恶行为的人的报复 —— 要求快递员看到 xxx 的别名就把信丢弃。

# GFW 发展历史

对于互联网的跨国流量，都要经过几个特定的国际网络出口。GFW 的存在，就好像是一位老大哥，站在几个国际出口处，把每个快递员的信抢来，确定内容得到党和国家的认可后才放行。

不过，老大哥在 24 小时的不间断审查中，变得愈加老奸巨猾，紧紧跟着互联网升级的脚步，及时升级，来确保审查的有效。这就是 GFW 的发展历史。

## 远古时期

最初的老大哥非常简单粗暴，他只会看信件的内容，只在看到不被党所认可的词汇才会把信件丢弃。

这也就是所谓针对 http 协议的**关键词阻断**。

## 近代

后来有一天，老大哥具备了识别 DNS 信件的能力，如果看到请求的别名是不被党所认可的网站，狡猾的老大哥就会伪造一篇回信寄回去，于是众多大陆网民就无法访问这些网站了。这就是大名鼎鼎的 **DNS 污染**。

而那些位于大陆的 DNS，虽然向他们发去信件不会收到老大哥的审查，但是由于身在大陆，不得不屈服于老大哥，他们只好在回信中针对部分网站回复假的地址。

不过有些心细的网民整理了各个别名所对应的真实地址，这就是 **Hosts 文件**。你只需要把这个文件交给操作系统，如果 Hosts 文件包含要查询的别名，就可以直接获取地址，不必再去问 DNS 了。

然而这种方法也有局限性。之后，老大哥也记住了部分别名所对应的地址，只要看到收信地址在黑名单里，就会丢弃信件。这就是 **IP 地址黑名单**。

## 现代

在出现了 TLS 后，老大哥便不再具备审查信件内容的能力，关键词阻断基本无效。而有了 DNSSec, DNSCrypt, DNS over TLS 等具备验证能力甚至加密的 DNS 查询方式后，DNS 污染也可以避免，翻墙形势喜人，只需要 Hosts 文件或者带验证机制的 DNS 查询就可以穿过防火长城。然而好景不长，老大哥发现 TLS 也有弱点，便是 SNI。在全国第十九届翻墙大赛（十九大）之后，各个国际出口的老大哥陆陆续续学会了 SNI 探测的能力，如果 SNI 上的别名不被党所认可，就将信件丢弃。

至此，由于还未普及加密传输 SNI 的技术（ESNI），翻墙也就只能通过代理了。

# 番外篇

其实老大哥的审查不只是针对被封锁的网站，还针对那些提供翻墙代理服务的服务器主机。

例如之前 Shadowsocks 就曝光过可以被主动检测的漏洞（现已修复），GFW 就可以通过类似的方法，来判断与墙外服务器的通信是否为翻墙用途，如果是，就把对应 IP 地址加入黑名单。

而现在的代理软件的主要研究方向之一就是避免暴露过多的流量特征，以避免被 GFW 识别出是翻墙代理服务器，，从而保证翻墙服务的有效性。

# References

1. 端传媒. [道高一尺，牆高一丈：互聯網封鎖是如何升級的](https://theinitium.com/article/20150904-mainland-greatfirewall/) [2015-09-04]
2. Wikipedia. [防火长城 - 维基百科](https://zh.wikipedia.org/wiki/防火长城) [2019-03-07]
3. 编程随想. [扫盲 DNS 原理，兼谈“域名劫持”和“域名欺骗/域名污染”](https://program-think.blogspot.com/2014/01/dns.html) [2014-01-23]



# 如何翻墙[2]: 兼谈各种翻墙技术原理

主要介绍了 GFW 的原理，本篇文章则从 GFW 原理的角度，阐释当下各种翻墙技术的原理。

如果看不懂本文的部分专业术语，还请先浏览本系列的第一篇文章。

# DNS over TLS/HTTPS

本质上是为 DNS 查询套了层壳，从而让通信安全可靠，也就避免了 **DNS 污染**。目前主流浏览器中，Firefox 支持此项技术。

通过 DoT/DoH 类技术，可以避免 DNS 污染型的封锁。不过鉴于当前封锁方式多元化（对一个网站 DNS 污染的同时还会配合 SNI 探测），仅仅通过此项技术，已经无法达到翻墙的效果。

# ESNI/Domain Fronting

这类技术用来避免 **SNI 探测**，配合上面的 DoT/DoH 技术，可以访问部分封锁不是很严重的网站，如 Medium 。不过由于 ESNI 技术还没有推广，大多数网站还未支持，目前的翻墙效果十分有限。

# 代理向

当下，代理翻墙已经成为主流。如 各种 VPN 软件 、 Lantern（蓝灯）、Psiphon（赛风）、Shadowsocks/ShadowsocksR(SS/SSR) 以及 V2ray 等都是以代理为原理，不过实现细节有所不同。

![Proxy](https://tecrobe.github.io/blog/image/proxy.png)

继续拿上一篇文章的快递员来举例。

```
既然老大哥的审查日益严苛，那么我们只好找墙外的朋友帮忙了。

首先，在寄信之前，会先和墙外的朋友协商好用来加密的密钥。
然后将本来打算寄出的信，连信封塞入寄给朋友（代理）的大信封中，
大信封中的内容会被协商好的密钥加密。

接着，信件的收信地址填写朋友（代理）所在的地址，
而你的朋友（代理服务器）的地址通常没有被老大哥列入黑名单，
而由于大信封中内容已经用实现协商好的密钥加密，老大哥也无法审查其中的内容。

待到你的朋友（代理）收到信后，会用密钥将之前塞入大信封的内容取出来。
于是，你的朋友会在墙外（无污染无审查）的网络中，
帮助你查找别名所在地址（DNS 查询），然后按照地址，帮你把信件寄出去。

等到你的朋友收到回信后，还会将回信加密，再寄到你那里去，
同理，由于内容被加密，仍然可以通过老大哥的审查。

最终，一次正常的网络连接就成功完成了！
```

以上便是代理软件们的通用原理。

不过老大哥当然也不是傻子，类似的情景不断增多，便引起了审查者的警觉。

于是老大哥结合 AI 深度学习的技术，开始识别各种翻墙代理的流量特征。这便是**深度包检测**。

最先出局的是 VPN，由于其本来的用途只是方便员工访问公司内网，翻墙用途的流量特征便很明显。

后来，Shadowsocks 又被曝出主动检测的 BUG（现已修复），又有 GFW 工作人员发了一篇 [通过机器学习识别 Shadowsocks 流量](https://www.solidot.org/story?sid=54086) 的[错误百出](https://www.zhihu.com/question/66531978)的“论文”，旧版 Shadowsocks 可能不够靠谱，根据部分网友的反馈是，用的时间长可能会被限速，导致翻墙体验变差。

不过，Shadowsocks 至今仍在维护，因此如果服务端及时更新，还是没有问题的。至于仍在活跃开发中的 V2ray ，则更是堪称突破网络审查的瑞士军刀。



[Tecrobe's Blog](https://tecrobe.github.io/blog)



## March 10, 2019

# 如何翻墙[3]: 科学上网实际操作指南

前两篇文章分别介绍了 GFW 的发展历史和翻墙技术的原理，如果你还没看的话，强烈推荐先去[浏览一遍](https://tecrobe.github.io/blog/post/break-wall)，看完后你将会对翻墙有更深的理解，也有助于你对翻墙软件配置的理解。

本文主要介绍 ShadowsocksR 的使用方法。

# SSR 客户端下载

Tips: 由于 Github Releases 连接受到 GFW 的严重劣化，可能无法打开下载链接，可以尝试多刷新几次。

如果下载速度太慢，可以试试备用链接。

### Android

[SSRR for Android](https://github.com/shadowsocksrr/shadowsocksr-android/releases/download/3.5.4/shadowsocksr-android-3.5.4.apk)

[SSRR for Android 备用](https://github.com/tecrobe/tecrobe-download/raw/master/shadowsocksr-android-3.5.4.apk)

### Windows

[SSRR for Windows](https://github.com/shadowsocksrr/shadowsocksr-csharp/releases/download/4.9.0/ShadowsocksR-win-4.9.0.zip)

[SSRR for Windows 备用](https://github.com/tecrobe/tecrobe-download/raw/master/ShadowsocksR-win-4.9.0.zip)

# 如何找到可用的 SSR 代理

当今，翻墙产业链已经基本成熟，有众多机场（SSR 代理服务器提供商）可供选择，部分机场还提供免费 SSR 节点。只需前往相应官网，用邮箱注册帐号即可获取节点信息。

通常免费节点会限速/限流量，有的机场会允许签(xu)到(ming)获取流量。若需求不大，通常机场自带的流量已经够用（1G 以上）。即使用完，还可以再注册一个帐号继续使用。（只需要再注册一个邮箱，就可以重新注册新的机场帐号。[Protonmail](https://protonmail.com/) 邮箱的注册无需手机号）或者不同机场换着用也可以。

有一个提供免费服务的机场，[NovaLive](https://xn--gfw-l68djrna64ei8mgrx0peuw7arpqnu1bi48d.xn--mmp-p18dn3y51wo4hc35ejee.com/auth/register)。

直接用 Google 搜索 “SSR 机场”，应该也能找到不少可用节点。

另外，有人做了个[付费机场评测](https://github.com/387099/SSR/issues/1)，相当于一个机场列表，里面有的机场也提供免费服务，可以注册个号试试。

# SSR Android 使用

### SSR 链接

先从机场复制 SSR 链接。

打开 SSRR ，点击左上角的 ShadowsocksR 。

点击右下角 + 号，选择从剪贴板导入。

返回主界面，点击右上角小飞机，系统会询问是否连接 VPN ，选择是，即可科学上网。

再次点击右上角小飞机即可关闭 SSR 。

![ssr1](https://tecrobe.github.io/blog/image/ssr1.png) ![ssr2](https://tecrobe.github.io/blog/image/ssr2.png) ![ssr3](https://tecrobe.github.io/blog/image/ssr3.png)

### SSR 订阅链接

仍然先从机场中找到订阅链接（通常以 https:// 开头），然后复制。

打开 SSRR ，点击左上角的 ShadowsockR 。

点击右下角 + 号，选择添加/升级 SSR 订阅。

点击添加/升级 SSR 订阅，然后长按输入框，点击粘贴。

然后确定，打开自动更新，最后点击确定并升级即可。

返回主界面，点击右上角小飞机，系统会询问是否连接 VPN ，选择是，即可科学上网。

再次点击右上角小飞机即可关闭 SSR 。

![ssr1](https://tecrobe.github.io/blog/image/ssr1.png) ![ssr2](https://tecrobe.github.io/blog/image/ssr2.png) ![ssr3](https://tecrobe.github.io/blog/image/ssr3.png) ![ssr4](https://tecrobe.github.io/blog/image/ssr4.png)

### 优化使用体验

Tips: 需要先关闭 SSR 才能更改功能设置

主界面往下拖即可看见功能设置，点击路由，选择 `绕过局域网及中国大陆地址` 。这样访问国内网站时就不会走代理，从而加快访问国内网站访问速度。

建议打开 `IPv6 路由`。

继续往下拖，可以打开 `自动连接`。这样 SSR 就会开机自启，就是那种没有墙的感觉！

![ssr5](https://tecrobe.github.io/blog/image/ssr5.png) ![ssr6](https://tecrobe.github.io/blog/image/ssr6.png)

# SSR Windows 使用

下载下来后先解压所有文件，解压后会看到 `ShadowsocksR-dotnet2.0.exe` 和 `ShadowsocksR-dotnet4.0.exe` 两个可执行文件，Win8 及以上请使用 dotnet4.0 版本，Win7 及以下请使用 dotnet 2.0 版本。

双击运行后，右下角可以看到小飞机的图标。右键点击小飞机。

```
服务器订阅` - `SSR 服务器订阅设置` - `Add` - 清空网址输入框中的内容 - 粘贴订阅链接 - `确定` - `更新 SSR 服务器订阅（不通过代理）
```

最后鼠标中键点击小飞机图标，选择代理服务器节点，然后即可科学上网。

### 优化使用

右键小飞机后，点击选项设置，可以设置开机启动。

系统代理模式建议选 `全局`。

代理规则选择 `绕过局域网和大陆`。

至于 `服务器负载均衡` 通常不建议开。

# 小结

科学上网的方法当然很多，本文提供了比较简单方便（新手向）的通用型方法，以供同学们参考。将来还会介绍其他翻墙方法（如 Shadowsocks 的使用，V2Ray 等等）。

另，在最后附上一些傻瓜式翻墙软件的下载链接。（效果不敢保证）

[Psiphon For Android](https://github.com/tecrobe/tecrobe-download/raw/master/PsiphonAndroid.apk)

[Psiphon For Windows](https://github.com/tecrobe/tecrobe-download/raw/master/psiphon3.exe)

[Lantern](https://github.com/getlantern/download/wiki)

PS: Psiphon 还可以通过向 get@psiphon3.com 发送邮件（任意文字）来获得最新版本的免翻墙下载链接。如果不行，可以试试用国外的邮箱服务（如 Outlook，Protonmail）。





[Tecrobe's Blog](https://tecrobe.github.io/blog)



## April 1, 2019

# 如何翻墙[4]: Fqrouter 的后继者 —— VPNHotSpot

之前已经向大家介绍了一些科学上网的基本操作，今天来介绍下大名鼎鼎的`翻墙路由器 (Fqrouter)`的后继者 —— VPNHotSpot。

事先声明：

1. VPNHotSpot 是 Android 软件。
2. VPNHotSpot 需要 Root 权限，如果你不知道什么是 Root ，请关闭这篇文章。另，将设备 Root 可能对于非技术专业用户有一定风险，还需谨慎。
3. VPNHotSpot 是用来将自由的网络（已经翻墙/无污染）以`热点`或`无线中继`的形式分享出去的，而非用来翻墙本身。因此，如果你还不会翻墙，请先阅读[前一篇文章](https://tecrobe.github.io/blog/post/how-to-break-wall)。

# 介绍

VPNHotSpot ，顾名思义，当你打开 VPN 时，VPNHotSpot 能将你的 VPN 以无线热点分享出去。

也就是说，如果你在一部手机上打开了 Shadowsocks 类科学上网工具，而且代理形式是 VPN（看通知栏上的小钥匙图标或者 VPN 标识），然后再打开 VPNHotSpot ，分享热点。那么其他设备连上这个热点，就直接连上了自由的网络（无墙状态）。

也就是所谓`没有墙的感觉`！

# 使用方法

## 无线中继模式

当手机连接的是 Wi-Fi 网络时，请使用`无线中继`模式。

配置方法很简单，进入应用 ，打开 `无线中继` 即可。

此时会看到一个叫做 `DIRECT-Wb-Android_xxxx` 的无线热点。

点击网络名称，再点击密码框右侧的眼睛图标即可查看热点密码。

如图：

![VPNHotSpot](https://tecrobe.github.io/blog/image/vpnhotspot.png)

## WLAN 热点模式

当手机连接的是移动数据网络时，请使用`WLAN 热点`模式。

此时，你需要先在系统设置中打开热点。

再进入 VPNHotSpot ，你会看到 wlan0 一栏，打开即可。

## USB 网络共享模式

此模式主要适用于刚装完系统，没有网卡驱动时使用。

先找到 USB 数据线，连接电脑。

在系统设置中打开 `USB 网络共享`，

然后同理，进入 VPNHotSpot ，打开 wlan0 即可。

此时，你的电脑会显示有线连接，打开浏览器，输入 [https://www.google.com](https://www.google.com/) 。

Enjoy!

# 疑难解答

如果其他设备连上 VPNHotSpot 开的热点无法上网，可以尝试进入 `设置选项`，开关 `禁用 IPv6 共享` 或 `尝试修复 DHCP` 来解决。

# 下载

[Download from FDroid](https://f-droid.org/repo/be.mygod.vpnhotspot_119.apk)

[Download from Github](https://github.com/Mygod/VPNHotspot/releases/download/v2.3.4/vpnhotspot-v2.3.4.apk)

[FDroid 上的页面](https://f-droid.org/en/packages/be.mygod.vpnhotspot/) （进入可下载最新版本）





[Tecrobe's Blog](https://tecrobe.github.io/blog)



## April 5, 2019

# 如何翻墙[5]: 兼谈 DoH + ESNI 突破审查

仔细看了 GFW 封锁原理那篇文章的同学应该还记得，`DNS 污染` 和 `SNI 检测` 是 GFW 的主要策略。

而 DoH (DNS over HTTPS) 和 ESNI (Encrypted SNI) 则是为了对付 GFW 这两招而发明的。

DoH 现已较完善，可是 ESNI 限于应用规模，效果还不理想（仅有部分网站支持 ESNI ，主要是 CloudFlare 以及 CDN）

因此综合起来应用仍然十分受限。不过一旦 ESNI 的应用有了一定规模，一定是对付 GFW 的一大利器。

目前通过 DoH + ESNI 组合突破封锁，已知有效的有:

- [https://medium.com](https://medium.com/)
- [https://program-think-mirror.github.io](https://program-think-mirror.github.io/)

本文来介绍下，如何启用 DoH + ESNI 。

注：当前只有 Firefox 支持 DoH 和 ESNI，故用 Firefox 进行演示。

# 启用 DNS over HTTPS

进入 首选项 - 常规 - 网络设置，如图：

![DoH](https://tecrobe.github.io/blog/image/doh.png)

勾选 `启用基于 HTTPS 的 DNS` ，然后 使用默认值 即可。

# 启用 ESNI

在 Firefox 地址栏输入 `about:config`。

在搜索栏中输入 `esni` ，双击 `network.security.esni.enabled` ，确认 `值` 为 `true`。

![ESNI](https://tecrobe.github.io/blog/image/esni.png)

# 番外

完成上面两步后，你就成功启用 DoH + ESNI 了！

启用之后，你就可以【免翻墙】使用 Google 了！

好吧，准确来说，是可以【免翻墙】使用 StartPage 了，StartPage 相当于一个 Google 搜索代理，搜索内容和 Google 一样，因此相当于可以使用 Google 了。

不过你直接打开 [https://startpage.com](https://startpage.com/) 还是没辙，打不开。你需要做一些小小的处理。

- 进入 首选项 - 搜索，点击 `寻找更多搜索引擎`

![StartPage](https://tecrobe.github.io/blog/image/startpage1.png)

- 在弹出来的页面中，点击右上角搜索栏，输入 StartPage

![StartPage](https://tecrobe.github.io/blog/image/startpage2.png)

- 点击 `Startpage (SSL)`

![StartPage](https://tecrobe.github.io/blog/image/startpage3.png)

- 点击 `+ 添加到 Firefox`

添加完毕后，在 Firefox 地址栏输入任意内容，使用 StartPage 搜索即可。

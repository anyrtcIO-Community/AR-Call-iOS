# anyRTC-Call-iOS

## 简介
anyRTC-Call-iOS呼叫，支持视频、语音、优先视频等多种呼叫模式，基于RTCallEngine SDK，适用于网络电话、活动、教育等多种呼叫场景。</br>

## 安装
### 1、编译环境
Xcode 8以上</br>

### 2、运行环境
真机运行、iOS 8.0以上（建议最新）

## 导入SDK

### Cocoapods导入
```
pod 'RTCallEngine', '3.0.2'
```
### 手动导入

1. 下载Demo，或者前往[anyRTC官网](https://www.anyrtc.io)下载SDK</br>
![list_directory](/image/list_directory.png)

2. 在Xcode中选择“Add files to 'Your project name'...”，将RTCallEngine.framework添加到你的工程目录中</br>

3.  打开General->Embedded Binaries中添加RTCallEngine.framework</br>


## 如何使用？

### 注册账号
登陆[AnyRTC官网](https://www.anyrtc.io/)

### 填写信息
创建应用，在管理中心获取开发者ID，AppID，AppKey，AppToken，替换AppDelegate.h中的相关信息

### 操作步骤：
1、两台iphone手机分别登录两个不同的账号；</br>

2、一台iphone手机点击发起通话进入呼叫页面，输入对方手机号；</br>

3、选择呼叫模式开始呼叫，呼叫接通开始会话。</br>

### 资源中心
[更多详细方法使用，请查看API文档](https://docs.anyrtc.io/v1/CALL/)

## 扫描二维码下载demo
![P2P_scan@3x](/image/P2P_scan@3x.png)


## 支持的系统平台
**iOS** 8.0及以上

## 支持的CPU架构
**iOS** armv7 、arm64。  支持bitcode

## ipv6
苹果2016年6月新政策规定新上架app必须支持ipv6-only。该库已经适配

## Android版P2P点对点Demo
[anyRTC-P2P-Android](https://github.com/anyRTC/AR-Call-Android)

## 更新日志

* 2019年05月15日：</br>

SDK更新3.0.0版本</br>

* 2018年10月31日：</br>
修复美颜相机情况下，本地视频添加子视图镜像的问题。</br>

## 技术支持
* anyRTC官方网址：https://www.anyrtc.io </br>
* QQ技术交流群：554714720 </br>
* 联系电话:021-65650071-816 </br>
* Email:hi@dync.cc </br>

## 关于直播
本公司有一整套直播解决方案，特别针对移动端。本公司开发者平台[www.anyrtc.io](http://www.anyrtc.io)。除了基于RTMP协议的直播系统外，我公司还有基于WebRTC的时时交互直播系统、P2P呼叫系统、会议系统等。快捷集成SDK，便可让你的应用拥有时时通话功能。欢迎您的来电~

## License

RTCallEngine is available under the MIT license. See the LICENSE file for more info.


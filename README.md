BM4Group
==============

[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/ibireme/YYKit/master/LICENSE)&nbsp;
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)&nbsp;
[![Support](https://img.shields.io/badge/support-iOS%206%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;


BM4Group is a collection of iOS components.

It's so huge that I split it into several independent components:

* [常用功能](https://github.com/chrain/BM4Group) — 一些常用的功能集合。
* [依赖常用第三方库](https://github.com/chrain/BM4Group) — 开发中常用的第三方框架集合。


Installation
==============

### CocoaPods

1. Add `pod 'BM4Group', :git => 'https://github.com/chrain/BM4Group.git'` to Podfile
2. Run `pod install`.
3. Add `#import <BM4Group/BM4Group.h>` when use.


Tips
==============
* 项目中Log采用`BRCocoaLumberjack`,为了使`BRCocoaLumberjack`输出的Log带颜色,请安装Xcode插件[XcodeColors](https://github.com/robbiehanson/XcodeColors.git),然后在项目最开始使用[BMUtils setupLog]初始化Log。
* 由于没有打TAG，所以CocoaPods是以git的commit的唯一id来确认是哪一个版本的，所以`慎`使用`pod update`。



项目常用第三方
==============
* `CTAssetsPickerController` 系统图片多选
* `Masonry` 链式Coding写AutoLayout


Xcode插件整理
==============
* [ATProperty](https://github.com/Draveness/ATProperty.git)
* [FuzzyAutocomplete](https://github.com/FuzzyAutocomplete/FuzzyAutocompletePlugin.git)
* [Peckham](https://github.com/markohlebar/Peckham.git)
* [BackLight](https://github.com/limejelly/Backlight-for-XCode.git)
* [DXXcodeConsoleUnicodePlugin](https://github.com/dhcdht/DXXcodeConsoleUnicodePlugin.git)
* [XcodeColors](https://github.com/robbiehanson/XcodeColors.git)
* [HOStringSense](https://github.com/holtwick/HOStringSense-for-Xcode.git)
* [KZLinkedConsole](https://github.com/krzysztofzablocki/KZLinkedConsole.git)
* [ColorSense-for-Xcode](https://github.com/omz/ColorSense-for-Xcode.git) 
* [DerivedData Extemmintor](https://github.com/kattrali/deriveddata-exterminator.git)
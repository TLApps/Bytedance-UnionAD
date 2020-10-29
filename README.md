# Bytedance-UnionAD

Pod for Bytedance-UnionAD only support **x86_64, armv7, arm64, i386**.

## How To Get Started

+ [Download Bytedance-UnionAD](https://github.com/bytedance/Bytedance-UnionAD/tree/master) and try out the included [example app](https://github.com/bytedance/Bytedance-UnionAD/tree/master/Example)

+ Check out the [documentation](https://github.com/bytedance/Bytedance-UnionAD/blob/master/Bytedance-UnionAd/Document/UnioniOSSDK.md) for a comprehensive look at all of the APIs available in Bytedance-UnionAD

+ If you have other questions, please read [FAQ](https://github.com/bytedance/Bytedance-UnionAD/blob/master/Bytedance-UnionAd/Document/UnioniOSSDK.md#faq) first

## Installation with CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like Bytedance-UnionAD in your projects. You can install it with the following command:
```ruby
$ gem install cocoapods
```

### Podfile

To integrate Bytedance-UnionAD into your Xcode project using CocoaPods, **you must install Git LFS first**,then specify it in your **Podfile**:
```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'

target 'TargetName' do
pod 'Bytedance-UnionAD'
end
```
Then, run the following command:
```ruby
$ pod install
```

Pod access is only supported after **version 1982**

## Author

Siwant

## License

Bytedance-UnionAD is available under the MIT license. See the LICENSE file for more info.

## FAQ & feedback channel
Chinese developers could refer to the documentation on the Pangle whenever encountered any problems during the integration process:
- FAQ document:  https://www.pangle.cn/help/doc/5dd0fe618507820012088272
- Error code reference document:https://www.pangle.cn/help/doc/5de4cc6d78c8690012a90aa5


Global developers can refer to the help center: https://www.pangleglobal.com/help

If the content of the document cannot solve your problem, you can try to give feedback through the official channel. Feedback channel: "Pangle Platform-Help-Feedback"

## Reward test
- Pangle will invite some developers to grayscale the new version of the SDK, please pay attention to the notice in the station. You can send an email to union_tech_support@bytedance.com to apply for the new version of the Pangle SDK. Your participation is highly appreciated!

- SDK information
  - Version Number: 3.3.0.4
  - Updated: 2020-10-29
  - Change Log:
  
    1.电商广告模板专项优化，适配双十一预算，提升电商预算转化能力; </br>
    2.模板渲染插屏、Banner支持视频预算;</br>
    3.模板Banner展示优化;</br>
    4.SDWebImage缓存路径问题修复;</br>
    5.开屏广告DidCloseOtherController回调异常修复;</br>
    6.模板渲染激励视频isadValid回调方法废弃;</br>

    1.Addition of in-banner video function;</br>
    2.Improved performance and stability;</br>
    3.Template Banner display optimization;</br>
    4.Splash ads advertisement DidCloseOtherController callback exception fix;</br>
    5.Template rendering  rewarded video isadValid callback method is abandoned;

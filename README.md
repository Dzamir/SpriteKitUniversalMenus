# SpriteKitUniversalMenus
SpriteKit menus that works on iOS (tap and gamecontrollers), tvOS (focus engine and gamecontrollers) and MacOS (click, keyboard and gamecontrollers)

[![CI Status](http://img.shields.io/travis/Davide Di Stefano/SpriteKitUniversalMenus.svg?style=flat)](https://travis-ci.org/Davide Di Stefano/SpriteKitUniversalMenus)
[![Version](https://img.shields.io/cocoapods/v/SpriteKitUniversalMenus.svg?style=flat)](http://cocoapods.org/pods/SpriteKitUniversalMenus)
[![License](https://img.shields.io/cocoapods/l/SpriteKitUniversalMenus.svg?style=flat)](http://cocoapods.org/pods/SpriteKitUniversalMenus)
[![Platform](https://img.shields.io/cocoapods/p/SpriteKitUniversalMenus.svg?style=flat)](http://cocoapods.org/pods/SpriteKitUniversalMenus)

## Description

This project aims to help game developers that want to build a cross platform iOS/OS X game by using SpriteKit. Instead of creating a different menu logic for each platform (mouse and keyboard for OS X, touch for iOS and remot for tvOS), you can just create a menu structure with this library and it will automatically handle focus, taps, clicks or selection. 

## Usage

First, create a DZAMenuNode and add it to your SpriteKit scene:

```objc
_menuNode = [[DZAMenuNode alloc] init];
_menuNode.allowedAxis = DZAMenuAxisVertical;
_menuNode.selectSoundName = @"select.wav";
_menuNode.openSoundName = @"open.wav";
_menuNode.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
[self addChild:_menuNode];
```

Then, add as many DZAMenuVoiceNode for each menu voice you need:

```objc
DZAMenuVoiceNode * menuVoice = [[DZAMenuVoiceNode alloc] initWithImageNamed:@"button"];
[menuVoice setLabelWithText:text andFont:[DZAFont boldSystemFontOfSize:15] withColor:[DZAColor whiteColor]];
menuVoice.position = CGPointMake(0, 0);
[_menuNode addChild:menuVoice];
[menuVoice performBlock:^
{
    // insert here the code that needs to be executed when the button is pressed
} onEvent:AGButtonControlEventTouchUpInside];
```

Finally, call the method 'reloadMenu' on your DZAMenuNode:

```objc
[_menuNode reloadMenu];
```
## Bridges

Included are some bridges to help working easily between iOS and OS X platforms. The bridged classes/enums are:

DZAFont -> UIFont / NSFont

DZATouch -> UITouch / NSTouch

DZAColor -> UIColor / NSColor

DZATapGestureRecognizer -> UITapGestureRecognizer / NSClickGestureRecognizer

DZAPanGestureRecognizer -> UIPanGestureRecognizer / NSPanGestureRecognizer

DZAGestureRecognizerStateBegan -> UIGestureRecognizerStateBegan / NSGestureRecognizerStateBegan

DZAGestureRecognizerStateChanged -> UIGestureRecognizerStateChanged / NSGestureRecognizerStateChanged

## Installation

To run the example project, clone the repo, and run `pod install` from the Example directory first.

SpriteKitUniversalMenus is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SpriteKitUniversalMenus"
```

## Author

Davide Di Stefano, dzamirro@gmail.com

## License

SpriteKitUniversalMenus is available under the MIT license. See the LICENSE file for more info.

DZAMenuVoiceNode class is based on AGSpriteButton, created by Akash Gupta
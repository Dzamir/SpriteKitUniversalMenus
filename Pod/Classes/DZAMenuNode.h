//
//  DZAMenuNode.h
//  Pods
//
//  Created by Davide Di Stefano on 06/01/16.
//
//

@import SpriteKit;
@import GameController;
#import "DZAMenuVoiceNode.h"

#define THREESHOLD 10.0f

@class DZAMenuNode;

@protocol DZAMenuNodeDelegate <NSObject>

// for tvOS: menu button pressed
// for macOS: esc button pressed
// for iOS you will need to add a button into your scene to map the back action
-(void) menuNodeDidPressBack:(DZAMenuNode *) menuNode;

@end

@interface DZAMenuNode : SKNode

@property (readwrite, nonatomic) DZAMenuAxis allowedAxis;
@property (weak, nonatomic) id<DZAMenuNodeDelegate> delegate;

//@property (strong, nonatomic) NSMutableArray * menuVoices;
@property (strong, nonatomic) DZAMenuVoiceNode * currentMenuVoice;
// sound to use when a menu is selected on tvOS
@property (strong, nonatomic) NSString * selectSoundName;
// sound to use when a menu is opened on tvOS
@property (strong, nonatomic) NSString * openSoundName;

// call this method after adding all the DZAMenuVoiceNode objects as child nodes
-(void) reloadMenu;

-(DZAMenuVoiceNode *) moveSelection:(DZAMenuDirection) direction;

-(void) pressSelection;

-(void) setupGameController:(GCController *) controller;

@end

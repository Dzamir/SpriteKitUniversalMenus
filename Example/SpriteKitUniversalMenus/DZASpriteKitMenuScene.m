//
//  DZASpriteKitMenuView.m
//  SpriteKitUniversalVerticalMenus
//
//  Created by Davide Di Stefano on 05/01/16.
//  Copyright © 2016 Davide Di Stefano. All rights reserved.
//

#import "DZASpriteKitMenuScene.h"
@import SpriteKitUniversalVerticalMenus;

@interface DZASpriteKitMenuScene()

@property (strong, nonatomic) DZAMenuNode * menuNode;

@end

@implementation DZASpriteKitMenuScene

-(void) addMenuVoiceWithText:(NSString *) text y:(CGFloat) y
{
    DZAMenuVoiceNode * menuVoice = [[DZAMenuVoiceNode alloc] initWithColor:[UIColor redColor] size:CGSizeMake(200, 44)];
    menuVoice.position = CGPointMake(0, y);
    [menuVoice setLabelWithText:text andFont:[UIFont systemFontOfSize:15] withColor:[UIColor whiteColor]];
    [_menuNode addChild:menuVoice];
}

-(void)didMoveToView:(SKView *)view
{
    _menuNode = [[DZAMenuNode alloc] init];
    _menuNode.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    [self addChild:_menuNode];
    
    [self addMenuVoiceWithText:@"Play" y:55];
    [self addMenuVoiceWithText:@"Options" y:0];
    [self addMenuVoiceWithText:@"Exit" y:-55];
}

@end

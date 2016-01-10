//
//  DZASpriteKitMenuView.m
//  SpriteKitUniversalVerticalMenus
//
//  Created by Davide Di Stefano on 05/01/16.
//  Copyright © 2016 Davide Di Stefano. All rights reserved.
//

#import "DZASpriteKitMenuScene.h"
@import SpriteKitUniversalMenus;

@interface DZASpriteKitMenuScene()

@property (strong, nonatomic) DZAMenuNode * menuNode;

@end

#if TARGET_OS_IPHONE
#define DZAFont UIFont
#define DZATouch UITouch
#define DZAColor UIColor
#else
#define DZAFont NSFont
#define DZATouch NSTouch
#define DZAColor NSColor
#endif


@implementation DZASpriteKitMenuScene

-(DZAMenuVoiceNode *) addMenuVoiceWithText:(NSString *) text y:(CGFloat) y
{
#if TARGET_OS_TV
    DZAMenuVoiceNode * menuVoice = [[DZAMenuVoiceNode alloc] initWithImageNamed:@"button.png"];
    [menuVoice setLabelWithText:text andFont:[DZAFont boldSystemFontOfSize:25] withColor:[DZAColor blackColor]];
#else
    DZAMenuVoiceNode * menuVoice = [[DZAMenuVoiceNode alloc] initWithColor:[DZAColor redColor] size:CGSizeMake(200
    [menuVoice setLabelWithText:text andFont:[DZAFont boldSystemFontOfSize:15] withColor:[DZAColor whiteColor]];
#endif
    menuVoice.position = CGPointMake(0, y);
    [_menuNode addChild:menuVoice];
    return menuVoice;
}

-(void)didMoveToView:(SKView *)view
{
    _menuNode = [[DZAMenuNode alloc] init];
    _menuNode.allowedAxis = DZAMenuAxisVertical;
    _menuNode.selectSoundName = @"select.wav";
    _menuNode.openSoundName = @"open.wav";
    _menuNode.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    [self addChild:_menuNode];
    
    [self addMenuVoiceWithText:@"Play" y:240];
    [self addMenuVoiceWithText:@"Options" y:120];
    [self addMenuVoiceWithText:@"Exit" y:-120];
    
    [_menuNode reloadMenu];
}

/*
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
    [_menuNode touchesBegan:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesMoved");
    [_menuNode touchesMoved:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_menuNode touchesEnded:touches withEvent:event];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_menuNode touchesCancelled:touches withEvent:event];
}

- (void)pressesBegan:(NSSet<UIPress *> *)presses withEvent:(nullable UIPressesEvent *)event;
{
    //    [self.view pressesBegan:presses withEvent:event];
    NSLog(@"SKView intercepted Remote Click");
}

- (void)pressesChanged:(NSSet<UIPress *> *)presses withEvent:(nullable UIPressesEvent *)event;
{
    
}

- (void)pressesEnded:(NSSet<UIPress *> *)presses withEvent:(nullable UIPressesEvent *)event;
{
    
}

- (void)pressesCancelled:(NSSet<UIPress *> *)presses withEvent:(nullable UIPressesEvent *)event;
{
    
}*/

@end

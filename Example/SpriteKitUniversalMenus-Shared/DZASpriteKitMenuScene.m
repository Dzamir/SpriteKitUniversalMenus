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
    DZAMenuVoiceNode * menuVoice = [[DZAMenuVoiceNode alloc] initWithImageNamed:@"button"];
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
    
    [[self addMenuVoiceWithText:@"Play" y:120] performBlock:^
    {
        int c = 0;
        c++;
    } onEvent:AGButtonControlEventTouchUpInside];
    [[self addMenuVoiceWithText:@"Options" y:0] performBlock:^{
        
    } onEvent:AGButtonControlEventTouchUpInside];
    [[self addMenuVoiceWithText:@"Exit" y:-120] performBlock:^{
        
    } onEvent:AGButtonControlEventTouchUpInside];;
    
    [_menuNode reloadMenu];
    
    for (GCController * pairedController in GCController.controllers)
    {
        [_menuNode setupGameController:pairedController];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleControllerDidConnectNotification:) name:GCControllerDidConnectNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleControllerDidDisconnectNotification:) name:GCControllerDidDisconnectNotification object:nil];
}

#if !TARGET_OS_IPHONE

- (void)scrollWheel:(NSEvent *)theEvent
{
    [_menuNode scrollWheel:theEvent];
}

- (void)keyDown:(NSEvent *)theEvent;
{
    [_menuNode keyDown:theEvent];
}

- (void)keyUp:(NSEvent *)theEvent;
{
    [_menuNode keyUp:theEvent];
}

#endif

-(void) handleControllerDidConnectNotification:(NSNotification *) notification
{
    GCController * connectedGameController = (GCController *) notification.object;
    [_menuNode setupGameController:connectedGameController];
}

-(void) handleControllerDidDisconnectNotification:(NSNotification *) notification
{
    GCController * disconnectedGameController = (GCController *) notification.object;
}

@end

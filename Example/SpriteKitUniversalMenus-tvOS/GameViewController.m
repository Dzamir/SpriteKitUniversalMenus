//
//  GameViewController.m
//  SpriteKitUniversalMenus-tvOS
//
//  Created by Davide Di Stefano on 09/01/16.
//  Copyright (c) 2016 Davide Di Stefano. All rights reserved.
//

#import "GameViewController.h"
#import "DZASpriteKitMenuScene.h"

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.controllerUserInteractionEnabled = NO;
    
    // Configure the view.
    SKView * spriteKitView = (SKView *) self.view;
    DZASpriteKitMenuScene * menuScene = [[DZASpriteKitMenuScene alloc] initWithSize:self.view.bounds.size];
    menuScene.userInteractionEnabled = YES; //do this somewhere in initialization
    [spriteKitView presentScene:menuScene];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


//- (void)pressesBegan:(NSSet<UIPress *> *)presses withEvent:(nullable UIPressesEvent *)event;
//{
////    [self.view pressesBegan:presses withEvent:event];
//    NSLog(@"ViewController intercepted Remote Click");
//}
//
//- (void)pressesChanged:(NSSet<UIPress *> *)presses withEvent:(nullable UIPressesEvent *)event;
//{
//    
//}
//
//- (void)pressesEnded:(NSSet<UIPress *> *)presses withEvent:(nullable UIPressesEvent *)event;
//{
//
//}
//
//- (void)pressesCancelled:(NSSet<UIPress *> *)presses withEvent:(nullable UIPressesEvent *)event;
//{
//
//}

@end

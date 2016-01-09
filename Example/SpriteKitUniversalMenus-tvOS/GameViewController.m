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

    // Configure the view.
    SKView * spriteKitView = (SKView *) self.view;
    
    DZASpriteKitMenuScene * menuScene = [[DZASpriteKitMenuScene alloc] initWithSize:self.view.bounds.size];
    [spriteKitView presentScene:menuScene];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end

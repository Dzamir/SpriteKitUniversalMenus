//
//  DZAViewController.m
//  SpriteKitUniversalVerticalMenus
//
//  Created by Davide Di Stefano on 01/04/2016.
//  Copyright (c) 2016 Davide Di Stefano. All rights reserved.
//

#import "DZAViewController.h"
@import SpriteKit;
#import "DZASpriteKitMenuScene.h"

@interface DZAViewController ()

@end

@implementation DZAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    SKView * spriteKitView = (SKView *) self.view;
    
    DZASpriteKitMenuScene * menuScene = [[DZASpriteKitMenuScene alloc] initWithSize:self.view.bounds.size];
    [spriteKitView presentScene:menuScene];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

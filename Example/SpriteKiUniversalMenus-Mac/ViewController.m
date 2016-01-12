//
//  ViewController.m
//  SpriteKiUniversalMenus-Mac
//
//  Created by Davide Di Stefano on 08/01/16.
//  Copyright © 2016 Davide Di Stefano. All rights reserved.
//

#import "ViewController.h"
#import "DZASpriteKitMenuScene.h"

@interface ViewController()
{
    DZASpriteKitMenuScene * menuScene;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    SKView * spriteKitView = (SKView *) self.view;
    
    menuScene = [[DZASpriteKitMenuScene alloc] initWithSize:CGSizeMake(960, 540)];
    [spriteKitView presentScene:menuScene];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void)scrollWheel:(NSEvent *)theEvent
{
    [menuScene scrollWheel:theEvent];
}


@end

//
//  ViewController.m
//  SpriteKiUniversalMenus-Mac
//
//  Created by Davide Di Stefano on 08/01/16.
//  Copyright © 2016 Davide Di Stefano. All rights reserved.
//

#import "ViewController.h"
#import "DZASpriteKitMenuScene.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    SKView * spriteKitView = (SKView *) self.view;
    
    DZASpriteKitMenuScene * menuScene = [[DZASpriteKitMenuScene alloc] initWithSize:self.view.bounds.size];
    [spriteKitView presentScene:menuScene];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end

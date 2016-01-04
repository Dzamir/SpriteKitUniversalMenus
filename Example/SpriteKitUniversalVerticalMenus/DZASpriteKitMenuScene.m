//
//  DZASpriteKitMenuView.m
//  SpriteKitUniversalVerticalMenus
//
//  Created by Davide Di Stefano on 05/01/16.
//  Copyright © 2016 Davide Di Stefano. All rights reserved.
//

#import "DZASpriteKitMenuScene.h"
@import SpriteKitUniversalVerticalMenus;

@implementation DZASpriteKitMenuScene

-(void)didMoveToView:(SKView *)view
{
    AGSpriteButton * spriteButton = [AGSpriteButton buttonWithColor:[UIColor redColor] andSize:CGSizeMake(200, 44)];
    spriteButton.position = CGPointMake(self.size.width / 2, self.size.height / 2);
    [spriteButton setLabelWithText:@"test" andFont:[UIFont systemFontOfSize:15] withColor:[UIColor whiteColor]];
    [self addChild:spriteButton];
}

@end

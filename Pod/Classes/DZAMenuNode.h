//
//  DZAMenuNode.h
//  Pods
//
//  Created by Davide Di Stefano on 06/01/16.
//
//

#import <SpriteKit/SpriteKit.h>
#import "DZAMenuVoiceNode.h"

typedef enum : NSUInteger {
    DZAMenuDirectionUp,
    DZAMenuDirectionRight,
    DZAMenuDirectionDown,
    DZAMenuDirectionLeft
} DZAMenuDirection;

@interface DZAMenuNode : SKNode

@property (readwrite, nonatomic, getter=isHorizontalMenu) BOOL horizontalMenu;

//@property (strong, nonatomic) NSMutableArray * menuVoices;
@property (strong, nonatomic) DZAMenuVoiceNode * currentMenuVoice;

// call this method after adding all the DZAMenuVoiceNode objects as child nodes
-(void) reloadMenu;

-(DZAMenuVoiceNode *) moveSelection:(DZAMenuDirection) direction;

@end

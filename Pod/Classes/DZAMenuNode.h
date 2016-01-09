//
//  DZAMenuNode.h
//  Pods
//
//  Created by Davide Di Stefano on 06/01/16.
//
//

#import <SpriteKit/SpriteKit.h>
#import "DZAMenuVoiceNode.h"

@interface DZAMenuNode : SKNode <AGSpriteButtonDelegate>

@property (readwrite, nonatomic) DZAMenuAxis allowedAxis;

//@property (strong, nonatomic) NSMutableArray * menuVoices;
@property (strong, nonatomic) DZAMenuVoiceNode * currentMenuVoice;

// call this method after adding all the DZAMenuVoiceNode objects as child nodes
-(void) reloadMenu;

-(DZAMenuVoiceNode *) moveSelection:(DZAMenuDirection) direction;

@end

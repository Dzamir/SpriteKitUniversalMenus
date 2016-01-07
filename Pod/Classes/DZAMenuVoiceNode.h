//
//  DZAMenuVoiceNode.h
//  Pods
//
//  Created by Davide Di Stefano on 06/01/16.
//
//

#import "AGSpriteButton.h"

@interface DZAMenuVoiceNode : AGSpriteButton

@property (readwrite, nonatomic) int tag;

-(instancetype)initWithColor:(SKColor *)color size:(CGSize)size;

@end

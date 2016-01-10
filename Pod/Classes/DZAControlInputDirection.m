//
//  ControlInputDirection.m
//  Sbindulin
//
//  Created by Davide Di Stefano on 18/10/15.
//  Copyright © 2015 Dzamir. All rights reserved.
//

#import "DZAControlInputDirection.h"

@implementation DZAControlInputDirection

-(id) initWithVector:(vector_float2) vector;
{
    if (self = [super init])
    {
        _vector = vector;
    }
    return self;
}

-(DZAControlInputDirectionEnum) controlInputDirectionEnum
{
    DZAControlInputDirectionEnum controlInputDirection = DZAControlInputDirectionNone;
    // Require sufficient displacement to specify direction.
    if (vector_length(_vector) > 0.5)
    {
        // Take the max displacement as the specified axis.
        if (fabs(_vector.x) > fabs(_vector.y))
        {
            if (_vector.x > 0)
            {
                controlInputDirection = DZAControlInputDirectionRight;
            } else
            {
                controlInputDirection = DZAControlInputDirectionLeft;
            }
                
        } else
        {
            if (_vector.y > 0)
            {
                controlInputDirection = DZAControlInputDirectionUp;
            } else
            {
                controlInputDirection = DZAControlInputDirectionDown;
            }
        }
    }
    return controlInputDirection;
}

@end

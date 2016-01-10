//
//  ControlInputDirection.h
//  Sbindulin
//
//  Created by Davide Di Stefano on 18/10/15.
//  Copyright © 2015 Dzamir. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <simd/simd.h>

typedef enum : NSUInteger {
    DZAControlInputDirectionUp,
    DZAControlInputDirectionDown,
    DZAControlInputDirectionLeft,
    DZAControlInputDirectionRight,
    DZAControlInputDirectionNone
} DZAControlInputDirectionEnum;


@interface DZAControlInputDirection : NSObject

-(id) initWithVector:(vector_float2) vector;

@property (readwrite, nonatomic) DZAControlInputDirectionEnum controlInputDirectionEnum;
@property (readwrite, nonatomic) vector_float2 vector;

@end

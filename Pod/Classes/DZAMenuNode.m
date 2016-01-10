//
//  DZAMenuNode.m
//  Pods
//
//  Created by Davide Di Stefano on 06/01/16.
//
//

#import "DZAMenuNode.h"

@interface DZAMenuNode()
{
#if TARGET_OS_TV
    CGPoint initialTranslation;
#endif
    UITapGestureRecognizer * tapGestureRecognizer;
    UIPanGestureRecognizer * panGestureRecognizer;
}
@end

@implementation DZAMenuNode

-(instancetype) init
{
    if (self = [super init])
    {

    }
    return self;
}

-(void) tapGestureRecognized:(UITapGestureRecognizer *) tapGestureRecognizer
{
    [self pressSelection];
}

-(void) reloadMenu;
{
    if (!tapGestureRecognizer)
    {
        tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognized:)];
        [self.scene.view addGestureRecognizer:tapGestureRecognizer];
    }
    if (!panGestureRecognizer)
    {
        panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)];
        [self.scene.view addGestureRecognizer:panGestureRecognizer];
    }
    _currentMenuVoice = nil;
    DZAMenuVoiceNode * firstMenuVoice = nil;
    for (SKNode * node in self.children)
    {
        if ([node isKindOfClass:[DZAMenuVoiceNode class]])
        {
            DZAMenuVoiceNode * menuVoiceNode = (DZAMenuVoiceNode *) node;
            menuVoiceNode.allowedAxis = _allowedAxis;
            menuVoiceNode.delegate = self;
            if (_allowedAxis == DZAMenuAxisHorizontal)
            {
                menuVoiceNode.tag = menuVoiceNode.position.x;
            } else
    	        {
                // spriteKit scene's y starts from the bottom, we need to invert
                menuVoiceNode.tag = -menuVoiceNode.position.y;
            }
            menuVoiceNode.zPosition = menuVoiceNode.tag;
            // search the menu voice with the lowest tag
            if (firstMenuVoice == nil)
            {
                firstMenuVoice = menuVoiceNode;
            } else if (menuVoiceNode.tag < firstMenuVoice.tag)
            {
                firstMenuVoice = menuVoiceNode;
            }
        }
    }
    // take the first node as current
    self.currentMenuVoice = firstMenuVoice;
}

-(void) setCurrentMenuVoice:(DZAMenuVoiceNode *)currentMenuVoice
{
    if (currentMenuVoice != _currentMenuVoice)
    {
#if TARGET_OS_TV
        [self defocusMenuVoice:_currentMenuVoice];
#endif
        _currentMenuVoice = currentMenuVoice;
#if TARGET_OS_TV
        [self focusMenuVoice:_currentMenuVoice];
#endif
    }
}

-(void) setAllowedAxis:(DZAMenuAxis)allowedAxis
{
    _allowedAxis = allowedAxis;
}

-(NSArray *) menuVoices
{
    NSMutableArray * menuVoices = [NSMutableArray arrayWithCapacity:10];
    for (SKNode * node in self.children)
    {
        if ([node isKindOfClass:[DZAMenuVoiceNode class]])
        {
            [menuVoices addObject:node];
        }
    }
    return menuVoices;
}

-(DZAMenuVoiceNode *) nextMenuVoice
{
    DZAMenuVoiceNode * nextMenuVoice = nil;
    NSArray * menuVoices = [self menuVoices];
    for (DZAMenuVoiceNode * menuNode in menuVoices)
    {
        if (menuNode.tag > _currentMenuVoice.tag)
        {
            if (nextMenuVoice == nil)
            {
                nextMenuVoice = menuNode;
            } else if (menuNode.tag < nextMenuVoice.tag)
            {
                nextMenuVoice = menuNode;
            }
        }
    }
    return nextMenuVoice;
}

-(DZAMenuVoiceNode *) previousMenuVoice
{
    DZAMenuVoiceNode * previousMenuVoice = nil;
    NSArray * menuVoices = [self menuVoices];
    for (DZAMenuVoiceNode * menuNode in menuVoices)
    {
        if ( (menuNode.tag < _currentMenuVoice.tag) && (menuNode.tag > previousMenuVoice.tag) )
        {
            if (previousMenuVoice == nil)
            {
                previousMenuVoice = menuNode;
            } else if (menuNode.tag > previousMenuVoice.tag)
            {
                previousMenuVoice = menuNode;
            }
        }
    }
    return previousMenuVoice;

}

-(DZAMenuVoiceNode *) moveSelection:(DZAMenuDirection) direction;
{
    DZAMenuVoiceNode * nextSelectionMenuNode = nil;
    if (_allowedAxis == DZAMenuAxisHorizontal)
    {
        if (direction == DZAMenuDirectionLeft)
        {
            nextSelectionMenuNode = [self previousMenuVoice];
        } else if (direction == DZAMenuDirectionRight)
        {
            nextSelectionMenuNode = [self nextMenuVoice];
        }
    } else
    {
        if (direction == DZAMenuDirectionDown)
        {
            nextSelectionMenuNode = [self nextMenuVoice];
        } else if (direction == DZAMenuDirectionUp)
        {
            nextSelectionMenuNode = [self previousMenuVoice];
        }
    }
    if (nextSelectionMenuNode != nil)
    {
        self.currentMenuVoice = nextSelectionMenuNode;
#if TARGET_OS_TV
        if (_selectSoundName)
        {
            [self runAction:[SKAction playSoundFileNamed:_selectSoundName waitForCompletion:NO]];
        }
#endif
    }
    return self.currentMenuVoice;
}

#pragma mark tvOS touch handling

#if TARGET_OS_TV

-(void) focusMenuVoice:(DZAMenuVoiceNode *) menuVoiceNode
{
    SKAction * scaleAction = [SKAction scaleTo:1.2 duration:0.05];
    [menuVoiceNode runAction:scaleAction];
    menuVoiceNode.zPosition = 100000;
    NSLog(@"Focus %i", menuVoiceNode.tag);
}

-(void) defocusMenuVoice:(DZAMenuVoiceNode *) menuVoiceNode
{
    SKAction * scaleAction = [SKAction scaleTo:1.0 duration:0.3];
    [menuVoiceNode runAction:scaleAction];
    menuVoiceNode.zPosition = menuVoiceNode.tag;
    NSLog(@"Defocus %i", menuVoiceNode.tag);
}

-(CGFloat) horizontalThreeshold
{
    if (_allowedAxis == DZAMenuAxisHorizontal)
    {
        return THREESHOLD;
    } else
    {
        return THREESHOLD / 4;
    }
}

-(CGFloat) verticalThreeshold
{
    if (_allowedAxis == DZAMenuAxisVertical)
    {
        return THREESHOLD;
    } else
    {
        return THREESHOLD / 4;
    }
}

-(void) panGestureRecognized:(UIPanGestureRecognizer *) _panGestureRecognizer
{
    if (_panGestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        initialTranslation = CGPointMake(0, 0);
        CGPoint point = [_panGestureRecognizer locationInView:self.scene.view];
        NSLog(@"position %@", NSStringFromCGPoint(point));
        [self focusMenuVoice:_currentMenuVoice];
    } else if (_panGestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        CGPoint point = [_panGestureRecognizer locationInView:self.scene.view];
        CGPoint translationPoint = CGPointMake( (point.x - initialTranslation.x) / 30.0f, (point.y - initialTranslation.y) / 30.0f);
        CGFloat horizontalThreeshold = [self horizontalThreeshold];
        CGFloat verticalThreeshold = [self verticalThreeshold];
        if (translationPoint.x > horizontalThreeshold)
        {
            translationPoint.x = horizontalThreeshold;
            if (_allowedAxis == DZAMenuAxisHorizontal)
            {
                initialTranslation = point;
                [self cancelTouch];
                [self moveSelection:DZAMenuDirectionRight];
            }
        } else if (translationPoint.x < -horizontalThreeshold)
        {
            translationPoint.x = -horizontalThreeshold;
            if (_allowedAxis == DZAMenuAxisHorizontal)
            {
                initialTranslation = point;
                [self cancelTouch];
                [self moveSelection:DZAMenuDirectionLeft];
            }
        }
        if (translationPoint.y > verticalThreeshold)
        {
            translationPoint.y = verticalThreeshold;
            if (_allowedAxis == DZAMenuAxisVertical)
            {
                initialTranslation = point;
                [self cancelTouch];
                [self moveSelection:DZAMenuDirectionDown];
            }
        } else if (translationPoint.y < -verticalThreeshold)
        {
            translationPoint.y = -verticalThreeshold;
            if (_allowedAxis == DZAMenuAxisVertical)
            {
                initialTranslation = point;
                [self cancelTouch];
                [self moveSelection:DZAMenuDirectionUp];
            }
        }
        NSLog(@"position %@", NSStringFromCGPoint(point));
        SKAction * moveAction = [SKAction moveTo:CGPointMake(_currentMenuVoice.originalPosition.x + translationPoint.x, _currentMenuVoice.originalPosition.y - translationPoint.y) duration:0.1];
        [_currentMenuVoice runAction:moveAction];
    } else
    {
        initialTranslation = CGPointMake(0, 0);
        [self cancelTouch];
    }
}
/*
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (currentTouch == nil)
    {
        initialTranslation = CGPointMake(0, 0);
        currentTouch = [touches anyObject];
        CGPoint point = [currentTouch locationInNode:self];
        NSLog(@"position %@", NSStringFromCGPoint(point));
        [self focusMenuVoice:_currentMenuVoice];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    currentTouch = [touches anyObject];
    CGPoint point = [currentTouch locationInNode:self];
    CGPoint translationPoint = CGPointMake( (point.x - initialTranslation.x) / 30.0f, (point.y - initialTranslation.y) / 30.0f);
    CGFloat horizontalThreeshold = [self horizontalThreeshold];
    CGFloat verticalThreeshold = [self verticalThreeshold];
    if (translationPoint.x > horizontalThreeshold)
    {
        translationPoint.x = horizontalThreeshold;
        if (_allowedAxis == DZAMenuAxisHorizontal)
        {
            initialTranslation = point;
            [self cancelTouch];
            [self moveSelection:DZAMenuDirectionRight];
        }
    } else if (translationPoint.x < -horizontalThreeshold)
    {
        translationPoint.x = -horizontalThreeshold;
        if (_allowedAxis == DZAMenuAxisHorizontal)
        {
            initialTranslation = point;
            [self cancelTouch];
            [self moveSelection:DZAMenuDirectionLeft];
        }
    }
    if (translationPoint.y > verticalThreeshold)
    {
        translationPoint.y = verticalThreeshold;
        if (_allowedAxis == DZAMenuAxisVertical)
        {
            initialTranslation = point;
            [self cancelTouch];
            [self moveSelection:DZAMenuDirectionUp];
        }
    } else if (translationPoint.y < -verticalThreeshold)
    {
        translationPoint.y = -verticalThreeshold;
        if (_allowedAxis == DZAMenuAxisVertical)
        {
            initialTranslation = point;
            [self cancelTouch];
            [self moveSelection:DZAMenuDirectionDown];
        }
    }
    NSLog(@"position %@", NSStringFromCGPoint(point));
    SKAction * moveAction = [SKAction moveTo:CGPointMake(_currentMenuVoice.originalPosition.x + translationPoint.x, _currentMenuVoice.originalPosition.y + translationPoint.y) duration:0.1];
    [_currentMenuVoice runAction:moveAction];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    initialTranslation = CGPointMake(0, 0);
    [self cancelTouch];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    initialTranslation = CGPointMake(0, 0);
    [self cancelTouch];
}
*/
-(void) cancelTouch
{
    SKAction * moveAction = [SKAction moveTo:_currentMenuVoice.originalPosition duration:0.5];
    [_currentMenuVoice runAction:moveAction];
//    currentTouch = nil;
}

#endif

#pragma mark AGSpriteButtonDelegate

-(void) spriteButton:(AGSpriteButton *) spriteButton didMoveToDirection:(DZAMenuDirection) direction;
{
    [self moveSelection:direction];
}

-(void) pressSelection;
{
#if TARGET_OS_TV
    [_currentMenuVoice forceTouchUpInside];
    if (_selectSoundName)
    {
        [self runAction:[SKAction playSoundFileNamed:_openSoundName waitForCompletion:NO]];
    }
#endif
}

-(void) setupGameController:(GCController *) controller;
{
    __weak DZAMenuNode * weakSelf = self;
    GCControllerButtonValueChangedHandler buttonHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        NSLog(@"BOTTONE");
    };
    GCControllerButtonValueChangedHandler leftHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        [self moveSelection:DZAMenuDirectionLeft];
    };
    GCControllerButtonValueChangedHandler rightHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        [self moveSelection:DZAMenuDirectionRight];
    };
    GCControllerDirectionPadValueChangedHandler handler = ^(GCControllerDirectionPad *dpad, float xValue, float yValue)
    {
        
    };
#if TARGET_OS_TV
    if (controller.microGamepad)
    {
        controller.microGamepad.buttonA.pressedChangedHandler = buttonHandler;
        controller.microGamepad.buttonX.pressedChangedHandler = buttonHandler;
    }
#endif
    if (controller.gamepad)
    {
        controller.gamepad.buttonA.pressedChangedHandler = buttonHandler;
        controller.gamepad.leftShoulder.pressedChangedHandler = leftHandler;
        controller.gamepad.rightShoulder.pressedChangedHandler = rightHandler;
    }
    if (controller.extendedGamepad)
    {
        controller.extendedGamepad.buttonA.pressedChangedHandler = buttonHandler;
        controller.extendedGamepad.leftTrigger.pressedChangedHandler = leftHandler;
        controller.extendedGamepad.rightTrigger.pressedChangedHandler = rightHandler;
    }
}

@end

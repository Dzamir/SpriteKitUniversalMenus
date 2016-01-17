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
    CGPoint initialTranslation;
    DZATapGestureRecognizer * tapGestureRecognizer;
    DZAPanGestureRecognizer * panGestureRecognizer;
    
    CGPoint currentScroll;
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

-(void) reloadMenu;
{
    if (!tapGestureRecognizer)
    {
        tapGestureRecognizer = [[DZATapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognized:)];
        [self.scene.view addGestureRecognizer:tapGestureRecognizer];
    }
    if (!panGestureRecognizer)
    {
        panGestureRecognizer = [[DZAPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)];
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
        [self defocusMenuVoice:_currentMenuVoice];
        _currentMenuVoice = currentMenuVoice;
        [self focusMenuVoice:_currentMenuVoice];
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
        if (menuNode.tag < _currentMenuVoice.tag)
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

-(void) focusMenuVoice:(DZAMenuVoiceNode *) menuVoiceNode
{
#if TARGET_OS_TV
    SKAction * scaleAction = [SKAction scaleTo:1.2 duration:0.05];
    [menuVoiceNode runAction:scaleAction];
    menuVoiceNode.zPosition = 100000;
#else
    SKAction * scaleAction = [SKAction scaleTo:1.08 duration:0.05];
    [menuVoiceNode runAction:scaleAction];
    menuVoiceNode.zPosition = 100000;
#endif
    NSLog(@"Focus %i", menuVoiceNode.tag);
}

-(void) defocusMenuVoice:(DZAMenuVoiceNode *) menuVoiceNode
{
#if TARGET_OS_TV
    SKAction * scaleAction = [SKAction scaleTo:1.0 duration:0.3];
    [menuVoiceNode runAction:scaleAction];
    menuVoiceNode.zPosition = menuVoiceNode.tag;
#else
    SKAction * scaleAction = [SKAction scaleTo:1.0 duration:0.3];
    [menuVoiceNode runAction:scaleAction];
    menuVoiceNode.zPosition = menuVoiceNode.tag;
#endif
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

-(void) tapGestureRecognized:(DZATapGestureRecognizer *) _tapGestureRecognizer
{
#if TARGET_OS_IPHONE
    [self pressSelection];
#else
    CGPoint touchLocationInView = [_tapGestureRecognizer locationInView:_tapGestureRecognizer.view];
    CGPoint touchLocationInScene = [self.scene convertPointFromView:touchLocationInView];
    CGPoint touchLocationInNode = [self.scene convertPoint:touchLocationInScene toNode:self];

    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchLocationInNode];
    if ([touchedNode isKindOfClass:[DZAMenuVoiceNode class]])
    {
        self.currentMenuVoice = (DZAMenuVoiceNode *)touchedNode;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(),^
        {
           [self pressSelection];
        });
    }
#endif
}

#if !TARGET_OS_IPHONE

- (void)keyDown:(NSEvent *)theEvent;
{
    NSString *eventChars = [theEvent charactersIgnoringModifiers];
    unichar keyChar = [eventChars characterAtIndex:0];
    
    if (( keyChar == NSEnterCharacter ) || ( keyChar == NSCarriageReturnCharacter ))
    {
        [self pressSelection];
    } else if ([theEvent modifierFlags] & NSNumericPadKeyMask)
    { // arrow keys have this mask
        NSString *theArrow = [theEvent charactersIgnoringModifiers];
        unichar keyChar = 0;
        if ( [theArrow length] == 0
            )
            return;            // reject dead keys
        if ( [theArrow length] == 1 )
        {
            keyChar = [theArrow characterAtIndex:0];
            if ( keyChar == NSLeftArrowFunctionKey )
            {
                [self moveSelection:DZAMenuDirectionLeft];
                return;
            }
            if ( keyChar == NSRightArrowFunctionKey )
            {
                [self moveSelection:DZAMenuDirectionRight];
                return;
            }
            if ( keyChar == NSUpArrowFunctionKey )
            {
                [self moveSelection:DZAMenuDirectionUp];
                return;
            }
            if ( keyChar == NSDownArrowFunctionKey )
            {
                [self moveSelection:DZAMenuDirectionDown];
                return;
            }
            [super keyDown:theEvent];
        }
    }
    [super keyDown:theEvent];
}

- (void)keyUp:(NSEvent *)theEvent;
{
    int c = 0;
    c++;
}

-(void) scrollWheel:(NSEvent *) event
{
    if ( (event.phase == NSEventPhaseBegan) || (event.phase == NSEventPhaseChanged) )
    {
        currentScroll = CGPointMake(currentScroll.x - event.deltaX, currentScroll.y - event.deltaY);
        CGFloat horizontalThreeshold = [self horizontalThreeshold];
        CGFloat verticalThreeshold = [self verticalThreeshold];
        if (currentScroll.x > horizontalThreeshold)
        {
            currentScroll.x = horizontalThreeshold;
            if (_allowedAxis == DZAMenuAxisHorizontal)
            {
                currentScroll = CGPointMake(0, 0);
                [self cancelTouch];
                [self moveSelection:DZAMenuDirectionRight];
            }
        } else if (currentScroll.x < -horizontalThreeshold)
        {
            currentScroll.x = -horizontalThreeshold;
            if (_allowedAxis == DZAMenuAxisHorizontal)
            {
                currentScroll = CGPointMake(0, 0);
                [self cancelTouch];
                [self moveSelection:DZAMenuDirectionLeft];
            }
        }
        if (currentScroll.y > verticalThreeshold)
        {
            currentScroll.y = verticalThreeshold;
            if (_allowedAxis == DZAMenuAxisVertical)
            {
                currentScroll = CGPointMake(0, 0);
                [self cancelTouch];
                [self moveSelection:DZAMenuDirectionDown];
            }
        } else if (currentScroll.y < -verticalThreeshold)
        {
            currentScroll.y = -verticalThreeshold;
            if (_allowedAxis == DZAMenuAxisVertical)
            {
                currentScroll = CGPointMake(0, 0);
                [self cancelTouch];
                [self moveSelection:DZAMenuDirectionUp];
            }
        }
        SKAction * moveAction = [SKAction moveTo:CGPointMake(_currentMenuVoice.originalPosition.x + currentScroll.x, _currentMenuVoice.originalPosition.y - currentScroll.y) duration:0.1];
        [_currentMenuVoice runAction:moveAction];
    } else if ( (event.phase == NSEventPhaseEnded) || (event.phase == NSEventPhaseCancelled) )
    {
        currentScroll = CGPointMake(0, 0);
        [self cancelTouch];
    }

}

#endif

-(void) panGestureRecognized:(DZAPanGestureRecognizer *) _panGestureRecognizer
{
    if (_panGestureRecognizer.state == DZAGestureRecognizerStateBegan)
    {
        CGPoint point = [_panGestureRecognizer locationInView:self.scene.view];
        initialTranslation = point;
        [self focusMenuVoice:_currentMenuVoice];
    } else if (_panGestureRecognizer.state == DZAGestureRecognizerStateChanged)
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
        SKAction * moveAction = [SKAction moveTo:CGPointMake(_currentMenuVoice.originalPosition.x + translationPoint.x, _currentMenuVoice.originalPosition.y - translationPoint.y) duration:0.1];
        [_currentMenuVoice runAction:moveAction];
    } else
    {
        initialTranslation = CGPointMake(0, 0);
        [self cancelTouch];
    }
}

-(void) cancelTouch
{
    SKAction * moveAction = [SKAction moveTo:_currentMenuVoice.originalPosition duration:0.5];
    [_currentMenuVoice runAction:moveAction];
}


#pragma mark AGSpriteButtonDelegate

-(void) spriteButton:(AGSpriteButton *) spriteButton didMoveToDirection:(DZAMenuDirection) direction;
{
    [self moveSelection:direction];
}

-(void) pressSelection;
{
    [self pressMenuVoice:_currentMenuVoice];
}

-(void) pressMenuVoice:(DZAMenuVoiceNode *) menuVoiceNode
{
    [menuVoiceNode forceTouchUpInside];
    if (_selectSoundName)
    {
        [self runAction:[SKAction playSoundFileNamed:_openSoundName waitForCompletion:NO]];
    }
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
        [weakSelf moveSelection:DZAMenuDirectionLeft];
    };
    GCControllerButtonValueChangedHandler rightHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        [weakSelf moveSelection:DZAMenuDirectionRight];
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

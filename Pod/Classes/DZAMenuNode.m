//
//  DZAMenuNode.m
//  Pods
//
//  Created by Davide Di Stefano on 06/01/16.
//
//

#import "DZAMenuNode.h"

@implementation DZAMenuNode

-(void) reloadMenu;
{
    _currentMenuVoice = nil;
    // take the first node as current
    _currentMenuVoice = [self nextMenuVoice];
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
    if (_horizontalMenu)
    {
        if (direction == DZAMenuDirectionLeft)
        {
            _currentMenuVoice = [self previousMenuVoice];
        } else if (direction == DZAMenuDirectionRight)
        {
            _currentMenuVoice = [self nextMenuVoice];
        }
    } else
    {
        if (direction == DZAMenuDirectionDown)
        {
            _currentMenuVoice = [self previousMenuVoice];
        } else if (direction == DZAMenuDirectionUp)
        {
            _currentMenuVoice = [self nextMenuVoice];
        }
    }
    return _currentMenuVoice;
}

@end

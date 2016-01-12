//
//  Bridges.h
//  Pods
//
//  Created by Davide Di Stefano on 09/01/16.
//
//

#ifndef Bridges_h
#define Bridges_h

#if TARGET_OS_IPHONE
    #define DZAFont UIFont
    #define DZATouch UITouch
    #define DZAColor UIColor
    #define DZATapGestureRecognizer UITapGestureRecognizer
    #define DZAPanGestureRecognizer UIPanGestureRecognizer
    #define DZAGestureRecognizerStateBegan UIGestureRecognizerStateBegan
    #define DZAGestureRecognizerStateChanged UIGestureRecognizerStateChanged
#else
    #define DZAFont NSFont
    #define DZATouch NSTouch
    #define DZAColor NSColor
    #define DZATapGestureRecognizer NSClickGestureRecognizer
    #define DZAPanGestureRecognizer NSPanGestureRecognizer
    #define DZAGestureRecognizerStateBegan NSGestureRecognizerStateBegan
    #define DZAGestureRecognizerStateChanged NSGestureRecognizerStateChanged
#endif

#endif /* Bridges_h */

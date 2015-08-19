//
//  TestView.m
//  BFNavigationControllerExample
//
//  Created by Heiko Dreyer on 27.04.12.
//  Copyright (c) 2012 boxedfolder.com. All rights reserved.
//

#import "TestView.h"

@implementation TestView

- (void)drawRect:(NSRect)dirtyRect {
    NSColor *color = _backgroundColor ?: [NSColor whiteColor];
    [color setFill];
    NSRectFill(dirtyRect);
}

@end

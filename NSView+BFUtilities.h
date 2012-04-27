//
//  NSView+BFUtilities.h
//
//  Created by Heiko Dreyer on 27.04.12.
//  Copyright (c) 2012 boxedfolder.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSView (BFUtilities)

/**
 *  Flattens view+subviews, return NSImage.
 */
-(NSImage *)flattenWithSubviews;

@end

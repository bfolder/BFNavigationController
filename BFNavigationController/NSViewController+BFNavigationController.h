//
//  NSViewController+BFNavigationController.h
//  BFNavigationControllerExample
//
//  Created by Patrick Twohig on 8/11/15.
//  Copyright (c) 2015 boxedfolder.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@class BFNavigationController;

@interface NSViewController (BFNavigationController)
@property (nonatomic, readonly, weak) BFNavigationController *bfNavigationController;
@end

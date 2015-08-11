//
//  NSViewController+BFNavigationController.m
//  BFNavigationControllerExample
//
//  Created by Patrick Twohig on 8/11/15.
//  Copyright (c) 2015 boxedfolder.com. All rights reserved.
//

#import "BFNavigationController.h"
#import "NSViewController+BFNavigationController.h"

@implementation NSViewController (BFNavigationController)

-(BFNavigationController*) bfNavigationController {

    NSViewController * viewController;

    do {
        viewController = self.parentViewController;
    } while(viewController.parentViewController);

    return [viewController isKindOfClass:[BFNavigationController class]] ? (BFNavigationController*) viewController : nil;

}

@end

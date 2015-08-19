//
//  NSViewController+BFNavigationController.m
//  BFNavigationControllerExample
//
//  Created by Patrick Twohig on 8/11/15.
//  Copyright (c) 2015 boxedfolder.com. All rights reserved.
//

#import "BFNavigationController.h"
#import "NSViewController+BFNavigationController.h"
#import <objc/runtime.h>

@implementation NSViewController (BFNavigationController)

static const void *BFNavigationControllerKey = &BFNavigationControllerKey;

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

- (void)setNavigationController:(BFNavigationController *)navigationController {
    objc_setAssociatedObject(self, BFNavigationControllerKey, navigationController, OBJC_ASSOCIATION_ASSIGN);
}

///////////////////////////////////////////////////////////////////////////////////////////////////

- (BFNavigationController *)navigationController {
    return objc_getAssociatedObject(self, BFNavigationControllerKey);
}

@end

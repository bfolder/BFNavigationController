//
//  NSViewController+BFViewController.m
//  BFNavigationControllerExample
//
//  Created by Lukas Riebel on 14/03/15.
//  Copyright (c) 2015 boxedfolder.com. All rights reserved.
//

#import "NSViewController+BFViewController.h"
#import <objc/runtime.h>

@implementation NSViewController (BFViewController)

static const void *BFNavigationControllerKey = &BFNavigationControllerKey;

- (void)setNavigationController:(BFNavigationController *)navigationController
{
    objc_setAssociatedObject(self, BFNavigationControllerKey, navigationController, OBJC_ASSOCIATION_ASSIGN);
}

- (BFNavigationController *)navigationController
{
    return objc_getAssociatedObject(self, BFNavigationControllerKey);
}

@end

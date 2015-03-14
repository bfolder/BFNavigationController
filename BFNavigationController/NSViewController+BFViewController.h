//
//  NSViewController+BFViewController.h
//  BFNavigationControllerExample
//
//  Created by Lukas Riebel on 14/03/15.
//  Copyright (c) 2015 boxedfolder.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class BFNavigationController;
@interface NSViewController (BFViewController)

@property (nonatomic, readonly) BFNavigationController *navigationController;

@end

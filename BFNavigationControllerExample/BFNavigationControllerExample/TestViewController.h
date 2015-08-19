//
//  TestViewController.h
//  BFNavigationControllerExample
//
//  Created by Heiko Dreyer on 27.04.12.
//  Copyright (c) 2012 boxedfolder.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BFViewController.h"

@interface TestViewController : NSViewController <BFViewController>

@property (nonatomic, assign) IBOutlet NSButton *pushItButton;
@property (nonatomic, assign) IBOutlet NSTextField *label;

@end

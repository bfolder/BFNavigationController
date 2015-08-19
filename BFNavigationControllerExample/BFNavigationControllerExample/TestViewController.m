//
//  TestViewController.m
//  BFNavigationControllerExample
//
//  Created by Heiko Dreyer on 04/27/12.
//  Copyright (c) 2012 boxedfolder.com. All rights reserved.
//

#import "TestView.h"
#import "TestViewController.h"
#import "BFNavigationController.h"
#import "NSViewController+BFNavigationController.h"

@interface TestViewController ()
@end

@implementation TestViewController

- (id)initWithNibName: (NSString *)nibNameOrNil bundle: (NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)loadView {
    [super loadView];
    if (self.title) {
        [_label setStringValue:self.title];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"%@ - viewWillAppear: %i", self.title, animated);
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"%@ - viewDidAppear: %i", self.title, animated);
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"%@ - viewWillDisappear: %i", self.title, animated);
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"%@ - viewDidDisappear: %i", self.title, animated);
}

@end

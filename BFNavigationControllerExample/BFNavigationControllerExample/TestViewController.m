//
//  TestViewController.m
//  BFNavigationControllerExample
//
//  Created by Heiko Dreyer on 27.04.12.
//  Copyright (c) 2012 boxedfolder.com. All rights reserved.
//

#import "TestView.h"
#import "TestViewController.h"
#import "BFNavigationController.h"
#import "NSViewController+BFNavigationController.h"

@interface TestViewController ()

@end

@implementation TestViewController

@synthesize label = _label;

-(id)initWithNibName: (NSString *)nibNameOrNil bundle: (NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) 
    {
        // Initialization code here.
    }
    
    return self;
}

-(void)loadView
{
    [super loadView];
    [_label setStringValue: self.title];
}

-(IBAction)pushIt:(id)sender {
    TestViewController *controller = [[TestViewController alloc] initWithNibName: @"TestViewController" bundle: nil];
    [controller setTitle: [NSString stringWithFormat: @"View Controller #%i", (int)[self.bfNavigationController.viewControllers count] + 1]];
    NSColor *color = [NSColor colorWithCalibratedRed:(arc4random() % 255) / 255.0 green:(arc4random() % 255) / 255.0 blue:(arc4random() % 255) / 255.0 alpha: 1.0];
    [((TestView *)controller.view) setBackgroundColor: color];
    [self.bfNavigationController pushViewController: controller animated: YES];
}

-(void)viewWillAppear: (BOOL)animated
{
    NSLog(@"%@ - viewWillAppear: %i", self.title, animated);
}

-(void)viewDidAppear: (BOOL)animated
{
    NSLog(@"%@ - viewDidAppear: %i", self.title, animated);
}

-(void)viewWillDisappear: (BOOL)animated
{
    NSLog(@"%@ - viewWillDisappear: %i", self.title, animated);
}

-(void)viewDidDisappear: (BOOL)animated
{
    NSLog(@"%@ - viewDidDisappear: %i", self.title, animated);
}


@end

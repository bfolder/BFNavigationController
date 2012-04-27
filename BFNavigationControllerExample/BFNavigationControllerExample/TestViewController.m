//
//  TestViewController.m
//  BFNavigationControllerExample
//
//  Created by Heiko Dreyer on 27.04.12.
//  Copyright (c) 2012 boxedfolder.com. All rights reserved.
//

#import "TestViewController.h"

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

@end

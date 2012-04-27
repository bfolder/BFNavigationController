//
//  BFAppDelegate.m
//  BFNavigationControllerExample
//
//  Created by Heiko Dreyer on 26.04.12.
//  Copyright (c) 2012 boxedfolder.com. All rights reserved.
//

#import "BFAppDelegate.h"
#import "BFNavigationController.h"
#import "TestViewController.h"
#import "TestView.h"

@implementation BFAppDelegate
{
    BFNavigationController *_navigationController;
    NSWindowController *_controlWindowController;

}

@synthesize window = _window;

-(void)applicationDidFinishLaunching: (NSNotification *)aNotification
{
    // First view controller
    TestViewController *controller = [[TestViewController alloc] initWithNibName: @"TestViewController" bundle: nil];
    [controller setTitle: @"View Controller"];
    
    // Init navigation controller and add to window
    _navigationController = [[BFNavigationController alloc] initWithFrame: NSMakeRect(0, 0, self.window.frame.size.width, self.window.frame.size.height) 
                                                       rootViewController: controller];
    
    [_window.contentView addSubview: _navigationController.view];
    
    // Control window
    _controlWindowController = [[NSWindowController alloc] initWithWindowNibName: @"ControlWindow"];
    [_controlWindowController performSelector: @selector(showWindow:) withObject: nil afterDelay: 0.5];
}

-(IBAction)pushNewController: (id)sender
{
    NSArray *subviews = [sender superview].subviews;
    BOOL animated = [(NSButton *)[subviews objectAtIndex: [subviews count] - 1] state];
    
    TestViewController *controller = [[TestViewController alloc] initWithNibName: @"TestViewController" bundle: nil];
    [controller setTitle: @"View Controller"];
    NSColor *color = [NSColor colorWithCalibratedRed:(arc4random() % 255) / 255.0 green:(arc4random() % 255) / 255.0 blue:(arc4random() % 255) / 255.0 alpha: 1.0];
    [((TestView *)controller.view) setBackgroundColor: color];
    
    [_navigationController pushViewController: controller animated: animated];
}

-(IBAction)popController: (id)sender
{
    NSArray *subviews = [sender superview].subviews;
    BOOL animated = [(NSButton *)[subviews objectAtIndex: [subviews count] - 1] state];
    
    [_navigationController popViewControllerAnimated: animated];
}

-(IBAction)popToRootController: (id)sender
{
    NSArray *subviews = [sender superview].subviews;
    BOOL animated = [(NSButton *)[subviews objectAtIndex: [subviews count] - 1] state];
    
    [_navigationController popToRootViewControllerAnimated: animated];
}

-(IBAction)newStack: (id)sender
{
    NSArray *subviews = [sender superview].subviews;
    BOOL animated = [(NSButton *)[subviews objectAtIndex: [subviews count] - 1] state];
        
    NSMutableArray *newControllers = [NSMutableArray array];
    for(uint i = 0; i < 6; i++) 
    {
        TestViewController *controller = [[TestViewController alloc] initWithNibName: @"TestViewController" bundle: nil];
        [controller setTitle: @"View Controller"];
        NSColor *color = [NSColor colorWithCalibratedRed:(arc4random() % 255) / 255.0 green:(arc4random() % 255) / 255.0 blue:(arc4random() % 255) / 255.0 alpha: 1.0];
        [((TestView *)controller.view) setBackgroundColor: color];
        [newControllers addObject: controller];
    }
    
    [_navigationController setViewControllers: newControllers animated: animated];
}

@end

//
//  BFNavigationController.m
//
//  Created by Heiko Dreyer on 26.04.12.
//  Copyright (c) 2012 boxedfolder.com. All rights reserved.
//

#import "BFNavigationController.h"

@interface BFNavigationController ()

-(void)_setViewControllers: (NSArray *)controllers animated: (BOOL)animated;
-(void)_navigateFromViewController: (NSViewController *)lastController 
                  toViewController: (NSViewController *)newController 
                          animated: (BOOL)animated
                              push: (BOOL)push;
@end

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation BFNavigationController
{
    NSMutableArray *_viewControllers;
}

@synthesize delegate = _delegate;

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Init Methods

-(id)initWithNibName: (NSString *)nibNameOrNil bundle: (NSBundle *)nibBundleOrNil
{
    if(self = [super initWithNibName: nibNameOrNil bundle: nibBundleOrNil]) 
    {
        _viewControllers = [NSMutableArray array];
    }
    
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

-(id)initWithFrame: (NSRect)aFrame rootViewController: (NSViewController *)controller
{
    if(self = [self initWithNibName: nil bundle: nil])
    {
        // Create View
        self.view = [[NSView alloc] initWithFrame: aFrame];
        self.view.autoresizingMask = NSViewMinXMargin | NSViewMaxXMargin | NSViewMinYMargin | NSViewMaxYMargin | NSViewWidthSizable | NSViewHeightSizable;
        
        // Add dummy controller if none provided
        if(!controller)
            controller = [[NSViewController alloc] init];
        
        [_viewControllers addObject: controller];
        controller.view.autoresizingMask = self.view.autoresizingMask;
        [self.view addSubview: controller.view];
    }
    
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Accessors

-(NSViewController *)topViewController
{
    return [_viewControllers lastObject];
}

///////////////////////////////////////////////////////////////////////////////////////////////////

-(NSViewController *)visibleViewController
{
    return [_viewControllers lastObject];
}

///////////////////////////////////////////////////////////////////////////////////////////////////

-(NSArray *)viewControllers
{
    return [NSArray arrayWithArray: _viewControllers];
}

///////////////////////////////////////////////////////////////////////////////////////////////////

-(void)setViewControllers: (NSArray *)viewControllers
{
    [self _setViewControllers: viewControllers animated: NO];
}

///////////////////////////////////////////////////////////////////////////////////////////////////

-(void)setViewControllers: (NSArray *)viewControllers animated: (BOOL)animated
{
    [self _setViewControllers: viewControllers animated: animated];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Helpers & Navigation

-(void)_setViewControllers: (NSArray *)controllers animated: (BOOL)animated
{
    // Stack Operations
    NSViewController *visibleController = [_viewControllers lastObject];
    _viewControllers = [controllers mutableCopy];
    
    // Decide if pop or push - If visible controller already in new stack, but is not topmost, use pop otherwise push
    BOOL push = !([controllers containsObject: _viewControllers] && [controllers indexOfObject: _viewControllers] < [controllers count] - 1);
      
    // Navigate
    [self _navigateFromViewController: visibleController toViewController: [_viewControllers lastObject] animated: animated push: push];
}

///////////////////////////////////////////////////////////////////////////////////////////////////

-(void)_navigateFromViewController: (NSViewController *)lastController 
                  toViewController: (NSViewController *)newController 
                          animated: (BOOL)animated
                              push: (BOOL)push
{
    CGFloat animationDuration = kPushPopAnimationDuration;
    
    // Perform basic setup tasks
    NSRect newControllerStartFrame = self.view.frame;
    newControllerStartFrame.origin.x = push ? newControllerStartFrame.size.width : -newControllerStartFrame.size.width;
    
    newController.view.autoresizingMask = self.view.autoresizingMask;
    newController.view.frame = newControllerStartFrame;
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Push / Pop Controllers

-(void)pushViewController: (NSViewController *)viewController animated: (BOOL)animated
{
    // Stack Operations
    NSViewController *visibleController = [_viewControllers lastObject];
    [_viewControllers addObject: viewController];
    
    // Navigate
    [self _navigateFromViewController: visibleController toViewController: [_viewControllers lastObject] animated: animated push: YES];
}

///////////////////////////////////////////////////////////////////////////////////////////////////

-(NSViewController *)popViewControllerAnimated: (BOOL)animated
{
    // Stack Operations
    NSViewController *controller = [_viewControllers lastObject];
    [_viewControllers removeLastObject];
    
    // Navigate
    [self _navigateFromViewController: controller toViewController: [_viewControllers lastObject] animated: animated push: NO];
    
    // Return popping controller
    return controller;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

-(NSArray *)popToRootViewControllerAnimated: (BOOL)animated
{
    // Stack Operations
    NSViewController *rootController = [_viewControllers objectAtIndex: 0];
    [_viewControllers removeObject: rootController];
    NSArray *dispControllers = [NSArray arrayWithArray: _viewControllers];
    _viewControllers = [NSArray arrayWithObject: rootController];
    
    // Navigate
    [self _navigateFromViewController: rootController toViewController: [dispControllers lastObject] animated: animated push: NO];
    
    // Return popping controller stack
    return dispControllers;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

-(NSArray *)popToViewController: (NSViewController *)viewController animated: (BOOL)animated
{
    if(![_viewControllers containsObject: viewController])
        return nil;
    
    // Stack Operations
    NSUInteger index = [_viewControllers indexOfObject: viewController];
    NSUInteger length = index - [_viewControllers count];
    NSRange range = NSMakeRange(index, length);
    NSArray *dispControllers = [_viewControllers subarrayWithRange: range];
    [_viewControllers removeObjectsInArray: dispControllers];
    
    // Navigate
    [self _navigateFromViewController: [dispControllers lastObject] toViewController: viewController animated: animated push: NO];
    
    // Return popping controller stack
    return dispControllers;
}

@end

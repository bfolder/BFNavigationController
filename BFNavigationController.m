//
//  BFNavigationController.m
//
//  Created by Heiko Dreyer on 26.04.12.
//  Copyright (c) 2012 boxedfolder.com. All rights reserved.
//

#import "BFNavigationController.h"
#import "NSView+BFUtilities.h"

@interface BFNavigationController ()

-(void)_setViewControllers: (NSArray *)controllers animated: (BOOL)animated;
-(void)_navigationCompletionHandler: (void (^)(void))completionBlock;
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
        // Create view
        self.view = [[NSView alloc] initWithFrame: aFrame];
        self.view.autoresizingMask = NSViewMinXMargin | NSViewMaxXMargin | NSViewMinYMargin | NSViewMaxYMargin | NSViewWidthSizable | NSViewHeightSizable;
        
        // Add dummy controller if none provided
        if(!controller)
            controller = [[NSViewController alloc] init];
        
        [_viewControllers addObject: controller];
        controller.view.autoresizingMask = self.view.autoresizingMask;
        controller.view.frame = self.view.bounds;
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
    NSViewController *visibleController = self.visibleViewController;
    NSViewController *newTopmostController = [controllers lastObject];
    
    // Decide if pop or push - If visible controller already in new stack, but is not topmost, use pop otherwise push
    BOOL push = !([_viewControllers containsObject: newTopmostController] && [_viewControllers indexOfObject: newTopmostController] < [_viewControllers count] - 1);
    
    _viewControllers = [controllers mutableCopy];
    
    // Navigate
    [self _navigateFromViewController: visibleController toViewController: newTopmostController animated: animated push: push];
}

///////////////////////////////////////////////////////////////////////////////////////////////////

-(void)_navigateFromViewController: (NSViewController *)lastController 
                  toViewController: (NSViewController *)newController 
                          animated: (BOOL)animated
                              push: (BOOL)push
{
    CGFloat animationDuration = kPushPopAnimationDuration;
    
    NSRect newControllerStartFrame = self.view.bounds;
    NSRect lastControllerEndFrame = self.view.bounds;
    
    newController.view.autoresizingMask = self.view.autoresizingMask;
    
    // Call Delegate
    if(_delegate && [_delegate respondsToSelector: @selector(navigationController:willShowViewController:animated:)])
        [_delegate navigationController: self willShowViewController: newController animated: animated];

    if(animated)
    {
        newControllerStartFrame.origin.x = push ? newControllerStartFrame.size.width : -newControllerStartFrame.size.width;
        lastControllerEndFrame.origin.x = push ? -lastControllerEndFrame.size.width : lastControllerEndFrame.size.width;
        
        // Assign start frame
        newController.view.frame = newControllerStartFrame;
        
        // Remove last controller from superview
        [lastController.view removeFromSuperview];
        
        // We use NSImageViews to cache animating views. Of course we could animate using Core Animation Layers - Do it if you like that.
        NSImageView *lastControllerImageView = [[NSImageView alloc] initWithFrame: self.view.bounds];
        NSImageView *newControllerImageView = [[NSImageView alloc] initWithFrame: newControllerStartFrame];
        
        [lastControllerImageView setImage: [lastController.view flattenWithSubviews]];
        [newControllerImageView setImage: [newController.view flattenWithSubviews]];
        
        [self.view addSubview: lastControllerImageView];
        [self.view addSubview: newControllerImageView];
        
        // Animation 'block' - Using default timing function
        [NSAnimationContext beginGrouping];
        [[NSAnimationContext currentContext] setDuration: animationDuration];
        [[lastControllerImageView animator] setFrame: lastControllerEndFrame];
        [[newControllerImageView animator] setFrame: self.view.bounds];
        [NSAnimationContext endGrouping];
        
        void (^completionBlock)(void) = ^{
            [lastControllerImageView removeFromSuperview];
            [self.view replaceSubview: newControllerImageView with: newController.view];
            newController.view.frame = self.view.bounds;
            
            // Call Delegate
            if(_delegate && [_delegate respondsToSelector: @selector(navigationController:didShowViewController:animated:)])
                [_delegate navigationController: self didShowViewController: newController animated: YES];
        };
        
        // Could have just used setCompletionHandler: on animation context if it was Lion only.
        [self performSelector: @selector(_navigationCompletionHandler:) 
                   withObject: completionBlock
                   afterDelay: animationDuration];
    }
    else
    {
        newController.view.frame = newControllerStartFrame;
        [self.view addSubview: newController.view];
        [lastController.view removeFromSuperview];
        
        // Call Delegate
        if(_delegate && [_delegate respondsToSelector: @selector(navigationController:didShowViewController:animated:)])
            [_delegate navigationController: self didShowViewController: newController animated: NO];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////

-(void)_navigationCompletionHandler: (void (^)(void))completionBlock
{
    completionBlock();
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Push / Pop Controllers

-(void)pushViewController: (NSViewController *)viewController animated: (BOOL)animated
{
    NSViewController *visibleController = self.visibleViewController;
    [_viewControllers addObject: viewController];
    
    // Navigate
    [self _navigateFromViewController: visibleController toViewController: [_viewControllers lastObject] animated: animated push: YES];
}

///////////////////////////////////////////////////////////////////////////////////////////////////

-(NSViewController *)popViewControllerAnimated: (BOOL)animated
{
    // Don't pop last controller
    if([_viewControllers count] == 1)
        return nil;
    
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
    // Don't pop last controller
    if([_viewControllers count] == 1)
        return nil;
    
    NSViewController *rootController = [_viewControllers objectAtIndex: 0];
    [_viewControllers removeObject: rootController];
    NSArray *dispControllers = [NSArray arrayWithArray: _viewControllers];
    _viewControllers = [NSMutableArray arrayWithObject: rootController];
    
    // Navigate
    [self _navigateFromViewController: [dispControllers lastObject] toViewController: rootController animated: animated push: NO];
    
    // Return popping controller stack
    return dispControllers;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

-(NSArray *)popToViewController: (NSViewController *)viewController animated: (BOOL)animated
{
    if(![_viewControllers containsObject: viewController])
        return nil;
    
    NSViewController *visibleController = self.visibleViewController;
    NSUInteger index = [_viewControllers indexOfObject: viewController];
    NSUInteger length = [_viewControllers count] - (index + 1);
    NSRange range = NSMakeRange(index + 1, length);
    NSArray *dispControllers = [_viewControllers subarrayWithRange: range];
    [_viewControllers removeObjectsInArray: dispControllers];
    
    // Don't pop last controller
    if(visibleController == viewController)
        return nil;
    
    // Navigate
    [self _navigateFromViewController: visibleController toViewController: viewController animated: animated push: NO];
    
    // Return popping controller stack
    return dispControllers;
}

@end

//
//  BFAppDelegate.h
//  BFNavigationControllerExample
//
//  Created by Heiko Dreyer on 26.04.12.
//  Copyright (c) 2012 boxedfolder.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface BFAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

-(IBAction)pushNewController: (id)sender;
-(IBAction)popController: (id)sender;

@end

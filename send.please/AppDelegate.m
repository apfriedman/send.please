//
//  AppDelegate.m
//  send.please
//
//  Created by Aaron Friedman on 2/18/15.
//  Copyright (c) 2015 Aaron Friedman. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)helpItemSelected:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://github.com/apfriedman/send.please/wiki"]];
}

@end

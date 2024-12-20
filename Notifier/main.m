//
//  main.m
//  Notifier
//
//  Created by 冷秋 on 2020/05/02.
//  Copyright © 2020 Magic-Unique. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Send.h"
#import "NFAppDelegate.h"

void SIGTERM_handler(int signum) {
    [[NFAppDelegate sharedDelegate] exit];
}

void SIGWINCH_handler(int signum) {
    dispatch_async(dispatch_get_main_queue(), ^{
        CLPrintf(@"Winchange");
    });
}

@interface Notifier : CLCommand @end
@implementation Notifier

command_configuration(command) {
    command.note = @"Send notification on macOS from command line.";
    command.version = @"1.0.0";
    command.subcommands = @[[Send class]];
}

@end


int main(int argc, const char * argv[]) {
    int ret = 0;
    @autoreleasepool {
        signal(SIGTERM, SIGTERM_handler);
        signal(SIGINT, SIGTERM_handler);
        signal(SIGWINCH, SIGWINCH_handler);
        
        ret = [Notifier main:argc argv:argv];
    }
    return 0;
}

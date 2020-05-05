//
//  main.m
//  Notifier
//
//  Created by 冷秋 on 2020/05/02.
//  Copyright © 2020 Magic-Unique. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Notifier.h"
#import "NFAppDelegate.h"

void SIGTERM_handler(int signum) {
    [[NFAppDelegate sharedDelegate] exit];
}

void SIGWINCH_handler(int signum) {
    dispatch_async(dispatch_get_main_queue(), ^{
        CLPrintf(@"Winchange");
    });
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        signal(SIGTERM, SIGTERM_handler);
        signal(SIGINT, SIGTERM_handler);
        signal(SIGWINCH, SIGWINCH_handler);
        
        [CLCommand setParametersSortType:CLSortTypeByAddingQueue];
        CLCommand.mainCommand.version = @"1.0.0";
        CLMainExplain = @"Send notification on macOS from command line.";
        CLMakeSubcommand(Notifier, __init_);
        CLCommandMain();
    }
    return 0;
}

//
//  Notifier+Commands.m
//  Notifier
//
//  Created by wushuang on 2020/05/02.
//  Copyright © 2020 吴双. All rights reserved.
//

#import "Notifier+Commands.h"

@implementation Notifier (Commands)

+ (void)__init_cmd {
    // define command `demo`, You can exec to do the block:
    // $ notify demo
    CLCommand *cmd = [[CLCommand mainCommand] defineSubcommand:@"cmd"];
    cmd.explain = @"This command description.";
    [cmd handleProcess:^int(CLCommand * _Nonnull command, CLProcess * _Nonnull process) {
        // handle arguments with `process`
        
        return 0; // return the command result.
    }];
}

@end

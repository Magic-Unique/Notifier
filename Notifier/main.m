//
//  main.m
//  Notifier
//
//  Created by 冷秋 on 2020/05/02.
//  Copyright © 2020 Magic-Unique. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Notifier.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        [CLCommand setParametersSortType:CLSortTypeByAddingQueue];
        CLCommand.mainCommand.version = @"1.0.0";
        CLMainExplain = @"Send notification on macOS from command line.";
        CLMakeSubcommand(Notifier, __init_);
        CLCommandMain();
    }
    return 0;
}

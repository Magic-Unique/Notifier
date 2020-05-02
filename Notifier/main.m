//
//  main.m
//  Notifier
//
//  Created by wushuang on 2020/05/02.
//  Copyright © 2020 吴双. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Notifier.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        CLMainExplain = @"This is command line project";
        CLMakeSubcommand(Notifier, __init_);
        CLCommandMain();
    }
    return 0;
}

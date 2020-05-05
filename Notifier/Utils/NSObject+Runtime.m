//
//  NSObject+Runtime.m
//  Notifier
//
//  Created by 吴双 on 2020/5/5.
//  Copyright © 2020 Magic-Unique. All rights reserved.
//

#import "NSObject+Runtime.h"
#import <objc/runtime.h>

@implementation NSObject (Runtime)

+ (void)exchange:(SEL)sel1 with:(SEL)sel2 {
    Method m1 = class_getInstanceMethod(self, sel1);
    Method m2 = class_getInstanceMethod(self, sel2);
    method_exchangeImplementations(m1, m2);
}

@end

//
//  NSBundle+Notifier.m
//  Notifier
//
//  Created by Magic-Unique on 2020/5/3.
//  Copyright © 2020 Magic-Unique. All rights reserved.
//

#import "NSBundle+Notifier.h"
#import <objc/runtime.h>

@implementation NSBundle (Notifier)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method m1 = class_getInstanceMethod(self, @selector(bundleIdentifier));
        Method m2 = class_getInstanceMethod(self, @selector(nf_bundleIdentifier));
        method_exchangeImplementations(m1, m2);
    });
}

- (NSString *)nf_bundleIdentifier {
    NSString *bid = self.nf_bundleIdentifierFaker?:[self nf_bundleIdentifier];
    return bid;
}

- (void)setNf_bundleIdentifierFaker:(NSString *)nf_bundleIdentifierFaker {
    objc_setAssociatedObject(self, @selector(bundleIdentifier), nf_bundleIdentifierFaker, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)nf_bundleIdentifierFaker {
    return objc_getAssociatedObject(self, @selector(bundleIdentifier));
}

@end

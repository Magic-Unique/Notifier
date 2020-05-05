//
//  NSBundle+Notifier.m
//  Notifier
//
//  Created by Magic-Unique on 2020/5/3.
//  Copyright © 2020 Magic-Unique. All rights reserved.
//

#import "NSBundle+Notifier.h"
#import "NSObject+Runtime.h"
#import <objc/runtime.h>

@implementation NSBundle (Notifier)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self exchange:@selector(bundleIdentifier) with:@selector(nf_bundleIdentifier)];
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

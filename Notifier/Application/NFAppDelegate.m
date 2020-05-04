//
//  NFAppDelegate.m
//  Notifier
//
//  Created by Magic-Unique on 2020/5/2.
//  Copyright © 2020 Magic-Unique. All rights reserved.
//

#import "NFAppDelegate.h"
#import "NSBundle+Notifier.h"

@interface NFAppDelegate ()

@property (nonatomic, strong, readonly) NSString *UUID;

@property (nonatomic, strong, readonly) NFNotification *notification;

@property (nonatomic, strong, readonly) NSUserNotification *currentNotification;

@end

@implementation NFAppDelegate

+ (instancetype)sharedDelegate {
    static NFAppDelegate *sharedDelegate = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDelegate = [self new];
    });
    return sharedDelegate;
}

#pragma mark - Public Method

- (void)runWithNotification:(NFNotification *)notification {
    _notification = notification;
    [NSApplication sharedApplication].delegate = self;
    [[NSApplication sharedApplication] run];
}

#pragma mark - Application Delegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    if (self.notification) {
        [NSUserNotificationCenter defaultUserNotificationCenter].delegate = self;
        [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:self.notification.userNotification];
    }
}

#pragma mark - User Notification Center Delegate

- (void)userNotificationCenter:(NSUserNotificationCenter *)center
        didDeliverNotification:(NSUserNotification *)notification {
    _currentNotification = notification;
    
    // 检测是否关闭
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        do {
            BOOL notificationStillPresent = NO;
            for (NSUserNotification *notification in [[NSUserNotificationCenter defaultUserNotificationCenter] deliveredNotifications]) {
                if ([notification.userInfo[@"uuid"] isEqualToString:self.notification.UUID]) {
                    notificationStillPresent = YES;
                    break;
                }
            }
            if (notificationStillPresent) {
                [NSThread sleepForTimeInterval:0.1f];
            } else {
                break;
            }
        } while (YES);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self removeCurrentNotification];
            [self response:@"close" content:@"close"];
            exit(0);
        });
    });
    
    // 检测超时
    if (self.notification.timeout) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.notification.timeout * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self removeCurrentNotification];
            [self response:@"timeout" content:@"timeout"];
            exit(0);
        });
    }
}

- (void)userNotificationCenter:(NSUserNotificationCenter *)center
       didActivateNotification:(NSUserNotification *)notification {
    
    if (![notification.userInfo[@"uuid"] isEqualToString:self.notification.UUID]) {
        return;
    };
    
    switch (notification.activationType) {
        case NSUserNotificationActivationTypeContentsClicked: {
            return;
        }
        case NSUserNotificationActivationTypeAdditionalActionClicked: {
            NSUserNotificationAction *action = notification.additionalActivationAction;
            [self response:@"action" content:action.title];
            break;
        }
        case NSUserNotificationActivationTypeActionButtonClicked: {
            [self response:@"action" content:notification.actionButtonTitle];
            break;
        }
        case NSUserNotificationActivationTypeReplied: {
            NSString *content = notification.response.string;
            [self response:@"reply" content:content];
            break;
        }
        case NSUserNotificationActivationTypeNone:
        default: {
            [self response:@"none" content:@"none"];
            break;
        }
    }
    [self removeCurrentNotification];
    exit(0);
}

- (void)response:(NSString *)action content:(NSString *)content {
    BOOL useJSON = [[CLProcess currentProcess] flag:@"json"];
    if (useJSON) {
        NSMutableDictionary *JSON = [NSMutableDictionary dictionary];
        JSON[@"action"] = action;
        JSON[@"content"] = content;
        NSData *data = [NSJSONSerialization dataWithJSONObject:JSON options:kNilOptions error:nil];
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        CLPrintf(@"%@\n", result);
    } else {
        CLPrintf(@"%@\n", content?:@"");
    }
}

- (void)removeCurrentNotification {
    [self removeNotificationWithUUID:self.notification.UUID];
}

- (void)removeNotificationWithUUID:(NSString *)UUID {
    if (!UUID) {
        return;
    }
    NSArray<NSUserNotification *> *notifications = [NSDefaultUserNotificationCenter deliveredNotifications];
    for (NSUserNotification *notification in notifications) {
        NSString *uuid = notification.userInfo[@"uuid"];
        if (uuid) {
            if ([uuid isEqualToString:UUID]) {
                NSLog(@"Remove");
                [NSDefaultUserNotificationCenter removeDeliveredNotification:notification];
            }
        }
    }
}

@synthesize UUID = _UUID;
- (NSString *)UUID {
    if (!_UUID) {
        _UUID = [[NSUUID alloc] init].UUIDString;
    }
    return _UUID;
}

@end

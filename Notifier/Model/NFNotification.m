//
//  NFNotification.m
//  Notifier
//
//  Created by Magic-Unique on 2020/5/3.
//  Copyright © 2020 Magic-Unique. All rights reserved.
//

#import "NFNotification.h"

@implementation NFNotification

- (instancetype)init {
    self = [super init];
    if (self) {
        _UUID = [NSUUID UUID].UUIDString;
    }
    return self;;
}

- (NSUserNotification *)userNotification {
    NSUserNotification *userNotification = [[NSUserNotification alloc] init];
    userNotification.title = self.title;
    userNotification.subtitle = self.subtitle;
    userNotification.informativeText = self.message;
    userNotification.hasActionButton = NO;
    [userNotification setValue:@NO forKey:@"_alwaysShowAlternateActionMenu"];
    [userNotification setValue:@NO forKey:@"_showsButtons"];
    
    if (self.close) {
        userNotification.otherButtonTitle = self.close;
    }
    
    if (self.reply) {
        userNotification.hasReplyButton = YES;
        userNotification.responsePlaceholder = self.reply;
    }
    else if (self.actions.count) {
        userNotification.hasActionButton = YES;
        
        if (self.actions.count > 1) {
            
            userNotification.additionalActions = ({
                NSMutableArray *actions = [NSMutableArray array];
                for (NSString *btn in self.actions) {
                    NSUserNotificationAction *action = [NSUserNotificationAction actionWithIdentifier:btn title:btn];
                    [actions addObject:action];
                }
                actions;
            });
            [userNotification setValue:@YES forKey:@"_alwaysShowAlternateActionMenu"];
            
            if (self.menu) {
                userNotification.actionButtonTitle = self.menu;
            }
        } else {
            userNotification.actionButtonTitle = self.actions.firstObject;
        }
    }
    
    if (self.icon) {
        NSImage *icon = [[NSImage alloc] initWithContentsOfFile:self.icon];
        if (icon) {
            [userNotification setValue:icon forKey:@"_identityImage"];
        }
    }
    
    if (self.image) {
        NSImage *image = [[NSImage alloc] initWithContentsOfFile:self.image];
        if (image) {
            userNotification.contentImage = image;
        }
    }
    
    if (self.sound) {
        if ([self.sound isEqualToString:@"default"]) {
            userNotification.soundName = NSUserNotificationDefaultSoundName;
        } else {
            userNotification.soundName = self.sound;
        }
    }
    
    userNotification.userInfo = ({
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        userInfo[@"uuid"] = self.UUID;
        userInfo;
    });
    
    return userNotification;
}

@end

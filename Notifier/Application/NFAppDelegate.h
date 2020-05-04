//
//  NFAppDelegate.h
//  Notifier
//
//  Created by Magic-Unique on 2020/5/2.
//  Copyright © 2020 Magic-Unique. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NFNotification.h"

@interface NFAppDelegate : NSObject <NSApplicationDelegate, NSUserNotificationCenterDelegate>

+ (instancetype)sharedDelegate;

- (void)runWithNotification:(NFNotification *)notification;
 
@end

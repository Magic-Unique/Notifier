//
//  NFAppDelegate.h
//  Notifier
//
//  Created by Magic-Unique on 2020/5/2.
//  Copyright © 2020 Magic-Unique. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NFNotification.h"

@class NFAppDelegate;

@protocol NFAppDelegateHandler <NSObject>

@optional

- (void)delegate:(NFAppDelegate *)delegate response:(NSString *)action content:(NSString *)content;

@end

@interface NFAppDelegate : NSObject <NSApplicationDelegate, NSUserNotificationCenterDelegate>

@property (nonatomic, weak) id<NFAppDelegateHandler> handler;

+ (instancetype)sharedDelegate;

- (void)runWithNotification:(NFNotification *)notification;

- (void)exit;
 
@end

//
//  Notifier+Commands.m
//  Notifier
//
//  Created by 冷秋 on 2020/05/02.
//  Copyright © 2020 Magic-Unique. All rights reserved.
//

#import "Notifier+Send.h"
#import "NFAppDelegate.h"
#import "NSBundle+Notifier.h"

@implementation Notifier (Send)

+ (void)__init_send {
    CLCommand *send = [CLCommand mainCommand];
    send.explain = @"Send a notification.";
    
    send.setQuery(@"title").setAbbr('t')
    .optional()
    .setExample(@"TITLE")
    .setExplain(@"Notification title.");
    
    send.setQuery(@"subtitle").setAbbr('s')
    .optional()
    .setExample(@"SUBTITLE")
    .setExplain(@"Notification subtitle.");
    
//    send.setQuery(@"message").setAbbr('m')
//    .optional()
//    .setExample(@"MESSAGE")
//    .setExplain(@"Notification message.");
    
    send.setQuery(@"action").setAbbr('a')
    .optional()
    .setMultiType(CLQueryMultiTypeMoreKeyValue)
    .setExample(@"BUTTON")
    .setExplain(@"Title for actions");
    
    send.setQuery(@"menu").setAbbr('m')
    .optional()
    .setExample(@"MENU")
    .setExplain(@"Menu button title. Enabled when it contains two or more action buttons");
    
    send.setQuery(@"close").setAbbr('c')
    .optional()
    .setExample(@"CLOSE")
    .setExplain(@"Close button title");
    
    send.setQuery(@"reply").setAbbr('r')
    .optional()
    .setExample(@"Reply placeholder")
    .setExplain(@"Enable reply and set the placeholder text.");
    
    send.setQuery(@"icon").setAbbr('i')
    .optional()
    .setExample(@"/path/to/icon.png")
    .setExplain(@"Notification icon on the pannel left.");
    
    send.setQuery(@"image").setAbbr('I')
    .optional()
    .setExample(@"/path/to/image.png")
    .setExplain(@"Notification image on the pannel right.");
    
    send.setQuery(@"sound").setAbbr('S')
    .optional()
    .setExample(@"'default' or SOUND_NAME")
    .setExplain(@"Notification sound, no sound for default, 'default' is system default sound");
    
    send.setQuery(@"sender").setAbbr('A')
    .optional()
    .setExample(@"BUNDLE_ID")
    .setExplain(@"Notification applciation bundle identifier.");
    
    send.setQuery(@"timeout").setAbbr('T')
    .optional()
    .asNumber()
    .setExample(@"SECOND")
    .setExplain(@"Auto hide and return `timeout` after the second.");
    
    send.setFlag(@"json").setAbbr('J')
    .setExplain(@"Print result with JSON format");
    
    send.addRequirePath(@"message").setExample(@"MESSAGE").setExplain(@"Notification message.");
    
    [send handleProcess:^int(CLCommand * _Nonnull command, CLProcess * _Nonnull process) {
        
        NFNotification *notification = [NFNotification new];
#ifdef DEBUG
        notification.title = @"Title";
        notification.subtitle = @"Subtitle";
        notification.message = @"Message";
        notification.menu = @"MENU";
        notification.actions = @[@"a1", @"a2"];
        //        notification.reply = @"REPLY";
        notification.close = @"CLOSE";
        notification.sender = @"com.apple.safari";
        //        notification.timeout = 5;
        
        NSString *image = @"/Users/冷秋/Desktop/icon.png";
        
        notification.icon = image;
        notification.image = image;
#else
        notification.title = process.queries[@"title"];
        notification.subtitle = process.queries[@"subtitle"];
        notification.message = process.paths.firstObject;
        notification.menu  = process.queries[@"menu"];
        notification.actions = process.queries[@"action"];
        notification.reply = process.queries[@"reply"];
        notification.close = process.queries[@"close"];
        
        if (process.queries[@"timeout"]) {
            NSNumber *timeout = process.queries[@"timeout"];
            NSTimeInterval time = timeout.doubleValue;
            notification.timeout = time;
        }
        
        if (process.queries[@"sound"]) {
            notification.sound = process.queries[@"sound"];
        }
        if (process.queries[@"icon"]) {
            notification.icon = [process pathForQuery:@"icon"];
        }
        
        if (process.queries[@"image"]) {
            notification.image = [process pathForQuery:@"image"];
        }
        
        notification.sender = process.queries[@"sender"];
#endif
        
        if (notification.sender) {
            [NSBundle mainBundle].nf_bundleIdentifierFaker = notification.sender;
        }
        
        [[NFAppDelegate sharedDelegate] runWithNotification:notification];
        
        return 0;
    }];
}

@end

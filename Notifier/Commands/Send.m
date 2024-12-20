//
//  Send.m
//  Notifier
//
//  Created by 冷秋 on 2020/05/02.
//  Copyright © 2020 Magic-Unique. All rights reserved.
//

#import "Send.h"
#import "NFAppDelegate.h"
#import "NSBundle+Notifier.h"

@interface Send () <NFAppDelegateHandler>

@end

@implementation Send

command_configuration(command) {
    command.note = @"Send a notification.";
}

command_argument(CLString, message, note=@"Notification message.", placeholder=@"MESSAGE")

command_option(CLString, title, shortName='t', nullable, note=@"Notification title", placeholder=@"TITLE");
command_option(CLString, subtitle, shortName='s', nullable, note=@"Notification subtitle", placeholder=@"SUBTITLE")

command_options(CLString, action, shortName='a', nullable, note=@"Title for action.", placeholder=@"BUTTON")
command_option(CLString, menu, shortName='m', nullable, note=@"Menu button title. Enabled when it contains two or more action buttons", placeholder=@"MENU")
command_option(CLString, closeButton, name=@"close", shortName='c', nullable, note=@"Close button title", placeholder=@"CLOSE")

command_option(NSUInteger, timeout, nullable, shortName='T', note=@"Auto hide and return `timeout` after the second.", placeholder=@"SECOND")
command_option(CLString, sender, shortName='A', nullable, note=@"Notification applciation bundle identifier.", placeholder=@"BUNDLE_ID")
command_option(CLString, icon, shortName='i', nullable, note=@"Notification icon on the pannel left.", placeholder=@"/path/to/icon.png")
command_option(CLString, image, shortName='I', nullable, note=@"Notification image on the pannel right.", placeholder=@"/path/to/image.png")
command_option(CLString, sound, shortName='S', nullable, note=@"Notification sound, no sound for default, 'default' is system default sound", placeholder=@"'default' or SOUND_NAME")
command_option(CLString, reply, shortName='r', nullable, note=@"Enable reply and set the placeholder text.", placeholder=@"Reply placeholder")

command_option(BOOL, json, shortName='J', note=@"Print result with JSON format")

+ (void)__init_send {
//    send.setQuery(@"reply").setAbbr('r')
//    .optional()
//    .setExample(@"Reply placeholder")
//    .setExplain(@"Enable reply and set the placeholder text.");
//
//
}

command_main() {
    NFNotification *notification = [NFNotification new];
//#ifdef DEBUG
    //        notification.title = @"Title";
    //        notification.subtitle = @"Subtitle";
    //        notification.message = @"Message";
    //        notification.menu = @"MENU";
    //        notification.actions = @[@"a1", @"a2"];
    //        notification.reply = @"REPLY";
    //        notification.close = @"CLOSE";
    //        notification.sender = @"com.apple.safari";
    //        notification.timeout = 5;
    
    //        NSString *image = @"/Users/冷秋/Desktop/icon.png";
    
    //        notification.icon = image;
    //        notification.image = image;
//#else
    notification.title = title;
    notification.subtitle = subtitle;
    notification.message = message;
    notification.menu = menu;
    notification.actions = action;
    notification.reply = reply;
    notification.close = closeButton;
    
    notification.timeout = timeout;
    notification.icon = icon;
    notification.image = image;
    notification.sound = sound;
    
    notification.sender = sender;
//#endif
    
    if (notification.sender) {
        [NSBundle mainBundle].nf_bundleIdentifierFaker = notification.sender;
    }
    
    [NFAppDelegate sharedDelegate].handler = self;
    [[NFAppDelegate sharedDelegate] runWithNotification:notification];
    
    return 0;
}

- (void)delegate:(NFAppDelegate *)delegate response:(NSString *)action content:(NSString *)content {
    BOOL useJSON = [self json];
    if (useJSON) {
        NSMutableDictionary *JSON = [NSMutableDictionary dictionary];
        JSON[@"action"] = action;
        JSON[@"content"] = content;
        NSData *data = [NSJSONSerialization dataWithJSONObject:JSON options:kNilOptions error:nil];
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        CLPrintf(@"%@\n", result);
    } else {
        CLPrintf(@"%@\n", content?:action);
    }
}

@end

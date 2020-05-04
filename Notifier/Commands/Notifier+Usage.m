//
//  Notifier+Usage.m
//  Notifier
//
//  Created by Magic-Unique on 2020/5/3.
//  Copyright © 2020 Magic-Unique. All rights reserved.
//

#import "Notifier+Usage.h"
#import "NFGraphices.h"

@implementation Notifier (Usage)

//+ (void)__init_usage {
//    CLCommand *usage = [[CLCommand mainCommand] defineSubcommand:@"usage"];
//    usage.explain = @"Usage documents for this command line";
//
//    usage.setFlag(@"title").setAbbr('t').setExplain(@"Send with a title");
//    usage.setFlag(@"subtitle").setAbbr('s').setExplain(@"Send with a subtitle");
//    usage.setQuery(@"actions").setAbbr('a').asNumber().optional().setExample(@"1").setExplain(@"Number of action titles");
//    usage.setFlag(@"menu").setAbbr('m').setExplain(@"Send with a menu title");
//    usage.setFlag(@"close").setAbbr('c').setExplain(@"Send with a close button");
//    usage.setFlag(@"reply").setAbbr('r').setExplain(@"Send with a reply text field");
//    usage.setFlag(@"icon").setAbbr('i').setExplain(@"Send with an icon");
//    usage.setFlag(@"image").setAbbr('I').setExplain(@"Send with an image");
//    [usage handleProcess:^int(CLCommand * _Nonnull command, CLProcess * _Nonnull process) {
//        NFGraphices *graphices = [NFGraphices new];
//        [graphices show];
//        return 0;
//    }];
//}

@end

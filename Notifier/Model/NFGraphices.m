//
//  NFGraphices.m
//  Notifier
//
//  Created by Magic-Unique on 2020/5/3.
//  Copyright © 2020 Magic-Unique. All rights reserved.
//

#import "NFGraphices.h"

static NSString *NFRepeatString(NSString *string,NSUInteger length) {
    NSMutableString *whitespace = [NSMutableString string];
    for (NSUInteger i = 0; i < length; i++) {
        [whitespace appendString:string];
    }
    return whitespace;
}

static NSString *NFWhitespace(NSUInteger length) {
    return NFRepeatString(@" ", length);
}

static NSString *NFLabel(NSString *content, NSTextAlignment alignment, NSUInteger length) {
    NSMutableString *label = [NSMutableString string];
    NSUInteger spaces = length - content.length;
    if (spaces > 0) {
        BOOL odd = (spaces % 2);
        switch (alignment) {
            case NSTextAlignmentLeft:
                [label appendString:content];
                [label appendString:NFWhitespace(spaces)];
                break;
            case NSTextAlignmentCenter:
                if (odd) {
                    [label appendString:NFWhitespace(spaces / 2)];
                    [label appendString:content];
                    [label appendString:NFWhitespace(spaces / 2 + 1)];
                } else {
                    [label appendString:NFWhitespace(spaces / 2)];
                    [label appendString:content];
                    [label appendString:NFWhitespace(spaces / 2)];
                }
                break;
            case NSTextAlignmentRight:
                [label appendString:NFWhitespace(spaces)];
                [label appendString:content];
                break;
                
            default:
                break;
        }
        return label;
    } else {
        return content;
    }
}

#define MARGIN_ICON 2
#define MARGIN_BODY 3
#define MARGIN_IMAGE 0
#define MARGIN_ACTION 2

#define WIDTH_ICON 10
#define WIDTH_BODY 21
#define WIDTH_IMAGE 13
#define WIDTH_ACTION 22

@implementation NFGraphices

- (instancetype)init {
    self = [super init];
    if (self) {
        self.message = YES;
        
        self.subtitle = YES;
        self.image = YES;
        self.icon = YES;
        self.actions = 2;
        self.menu = YES;
//        self.reply = YES;
    }
    return self;
}

- (void)show {
    CLPrintf(@"|------------------------------------------------------------------------|\n");
    NSArray<NSString *>
    *iconLines = [self _iconLines],
    *bodyLines = [self _bodyLines],
    *imageLines = [self _imageLines],
    *actionLines = [self _actionLines];
    for (NSUInteger i = 0; i < 7; i++) {
        CLPrintf(@"|");
        CLPrintf(@"%@", NFWhitespace(MARGIN_ICON));
        CLPrintf(@"%@", iconLines[i]);
        CLPrintf(@"%@", NFWhitespace(3));
        CLPrintf(@"%@", bodyLines[i]);
        CLPrintf(@"%@", imageLines[i]);
        CLPrintf(@"%@", NFWhitespace(2));
        CLPrintf(@"%@", actionLines[i]);
        CLPrintf(@"\n");
    }
    if (self.actions == 0 || self.actions == 1 || self.reply) {
        CLPrintf(@"|------------------------------------------------------------------------|\n");
        return;
    }
    CLPrintf(@"|---------------------------------------------------|--------------------|\n");
}

- (NSArray<NSString *> *)_iconLines {
    NSMutableArray *lines = [NSMutableArray array];
    [lines addObject:NFWhitespace(10)];
    if (self.icon) {
        [lines addObject:@"----------"];
        [lines addObject:@"|        |"];
        [lines addObject:@"|  Icon  |"];
        [lines addObject:@"|        |"];
        [lines addObject:@"----------"];
    } else {
        [lines addObject:@"----------"];
        [lines addObject:@"|        |"];
        [lines addObject:@"|App Icon|"];
        [lines addObject:@"|        |"];
        [lines addObject:@"----------"];
    }
    [lines addObject:NFWhitespace(10)];
    return lines;
}

- (NSArray<NSString *> *)_bodyLines {
    NSMutableArray *lines = [NSMutableArray array];
    [lines addObject:NFWhitespace(21)];
    if (self.subtitle && self.message) {
        if (self.title) {
            [lines addObject:NFLabel(@"Title", NSTextAlignmentLeft, 21)];
        } else {
            [lines addObject:NFLabel(@"App Name", NSTextAlignmentLeft, 21)];
        }
        [lines addObject:NFWhitespace(21)];
        [lines addObject:NFLabel(@"Subtitle", NSTextAlignmentLeft, 21)];
        [lines addObject:NFWhitespace(21)];
        [lines addObject:NFLabel(@"Message", NSTextAlignmentLeft, 21)];
    } else {
        [lines addObject:NFWhitespace(21)];
        if (self.title) {
            [lines addObject:NFLabel(@"Title", NSTextAlignmentLeft, 21)];
        } else {
            [lines addObject:NFLabel(@"App Name", NSTextAlignmentLeft, 21)];
        }
        [lines addObject:NFWhitespace(21)];
        if (self.subtitle) {
            [lines addObject:NFLabel(@"Subtitle", NSTextAlignmentLeft, 21)];
        } else {
            [lines addObject:NFLabel(@"Message", NSTextAlignmentLeft, 21)];
        }
        [lines addObject:NFWhitespace(21)];
    }
    [lines addObject:NFWhitespace(21)];
    return lines;
}

- (NSArray<NSString *> *)_imageLines {
    NSMutableArray *lines = [NSMutableArray array];
    if (self.image) {
        [lines addObject:@"-------------"];
        [lines addObject:@"|           |"];
        [lines addObject:@"|           |"];
        [lines addObject:@"|   image   |"];
        [lines addObject:@"|           |"];
        [lines addObject:@"|           |"];
        [lines addObject:@"-------------"];
    } else {
        for (NSUInteger i = 0; i < 7; i++) {
            [lines addObject:NFWhitespace(13)];
        }
    }
    return lines;
}

- (NSArray<NSString *> *)_actionLines {
    NSMutableArray *lines = [NSMutableArray array];
    if (self.actions || self.reply) {
        if (self.reply) {
            [lines addObject:@"|                    |"];
            [lines addObject:@"|       close        |"];
            [lines addObject:@"|                    |"];
            [lines addObject:@"|--------------------|"];
            [lines addObject:@"|                    |"];
            [lines addObject:@"|       reply        |"];
            [lines addObject:@"|                    |"];
        }
        else if (self.actions == 1) {
            [lines addObject:@"|                    |"];
            [lines addObject:@"|       close        |"];
            [lines addObject:@"|                    |"];
            [lines addObject:@"|--------------------|"];
            [lines addObject:@"|                    |"];
            [lines addObject:@"|       action       |"];
            [lines addObject:@"|                    |"];
        }
        else if (self.menu) {
            [lines addObject:@"|                    |"];
            [lines addObject:@"|       close        |"];
            [lines addObject:@"|                    |"];
            [lines addObject:@"|--------------------|"];
            [lines addObject:@"|                    |"];
            [lines addObject:@"|       menu  ↓      |"];
            [lines addObject:@"|                    |"];
        } else {
            [lines addObject:@"|                    |"];
            [lines addObject:@"|       close        |"];
            [lines addObject:@"|                    |"];
            [lines addObject:@"|--------------------|"];
            [lines addObject:@"|                    |"];
            [lines addObject:@"|       display      |"];
            [lines addObject:@"|                    |"];
        }
    } else {
        [lines addObject:@"|                    |"];
        [lines addObject:@"|                    |"];
        [lines addObject:@"|                    |"];
        [lines addObject:@"|       close        |"];
        [lines addObject:@"|                    |"];
        [lines addObject:@"|                    |"];
        [lines addObject:@"|                    |"];
    }
    return lines;
}


@end

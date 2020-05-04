//
//  NFNotification.h
//  Notifier
//
//  Created by Magic-Unique on 2020/5/3.
//  Copyright © 2020 Magic-Unique. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * |------------------------------------------------------------------------|
 * |                                    -------------  |                    |
 * |  ----------   Title                |           |  |        Close       |
 * |  |        |                        |           |  |                    |
 * |  |  Icon  |   Subtitle             |   Image   |  |--------------------|
 * |  |        |                        |           |  |                    |
 * |  ----------   Message              |           |  |   Reply or Menu↓   |
 * |                                    -------------  |                    |
 * |---------------------------------------------------|--------------------|
 *                                                     |                    |
 *                                                     |      Action 1      |
 *                                                     |                    |
 *                                                     |--------------------|
 *                                                     |                    |
 *                                                     |      Action 2      |
 *                                                     |                    |
 *                                                     |--------------------|
 *
 */

@interface NFNotification : NSObject


@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, copy) NSString *message;





@property (nonatomic, copy) NSString *close;



@property (nonatomic, strong) NSArray<NSString *> *actions;
@property (nonatomic, copy) NSString *menu;



@property (nonatomic, copy) NSString *reply;


@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *sound;


@property (nonatomic, assign) NSTimeInterval timeout;

@property (nonatomic, copy) NSString *sender;

@property (nonatomic, copy, readonly) NSString *UUID;

@end


@interface NFNotification (Convert)

@property (nonatomic, strong, readonly) NSUserNotification *userNotification;

@end

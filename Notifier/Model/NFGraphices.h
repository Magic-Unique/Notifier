//
//  NFGraphices.h
//  Notifier
//
//  Created by Magic-Unique on 2020/5/3.
//  Copyright © 2020 Magic-Unique. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 |------------------------------------------------------------------------|
 |                                    -------------  |                    |
 |  ----------   Title                |           |  |        close       |
 |  |        |                        |           |  |                    |
 |  |App Icon|   Subtitle             |   image   |  |--------------------|
 |  |        |                        |           |  |                    |
 |  ----------   Message              |           |  |   reply or menu↓   |
 |                                    -------------  |                    |
 |------------------------------------------------------------------------|
 
 
 |------------------------------------------------------------------------|
 |                                    -------------  |                    |
 |  ----------   Title                |           |  |        close       |
 |  |        |                        |           |  |                    |
 |  |App Icon|   Subtitle             |   image   |  |--------------------|
 |  |        |                        |           |  |                    |
 |  ----------   Message              |           |  |   reply or menu↓   |
 |                                    -------------  |                    |
 |---------------------------------------------------|--------------------|
                                                     |                    |
                                                     |      action 1      |
                                                     |                    |
                                                     |--------------------|
                                                     |                    |
                                                     |      action 2      |
                                                     |                    |
                                                     |--------------------|
 */

@interface NFGraphices : NSObject

@property (nonatomic, assign) BOOL title;

@property (nonatomic, assign) BOOL subtitle;

@property (nonatomic, assign) BOOL message;

@property (nonatomic, assign) NSUInteger actions;
@property (nonatomic, assign) BOOL menu;

@property (nonatomic, assign) BOOL close;

@property (nonatomic, assign) BOOL reply;

@property (nonatomic, assign) BOOL icon;

@property (nonatomic, assign) BOOL image;

@property (nonatomic, assign) BOOL sound;

- (void)show;

@end

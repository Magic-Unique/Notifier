//
//  NSObject+Runtime.h
//  Notifier
//
//  Created by 吴双 on 2020/5/5.
//  Copyright © 2020 Magic-Unique. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Runtime)

+ (void)exchange:(SEL)sel1 with:(SEL)sel2;

@end

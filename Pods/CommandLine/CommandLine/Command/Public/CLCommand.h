//
//  CLCommand.h
//  CommandLineDemo
//
//  Created by 冷秋 on 2022/8/31.
//  Copyright © 2022 Magic-Unique. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLRunner.h"
#import "metamacros.h"
#import "CLCommandInfo.h"
#import "CLType.h"

NS_INLINE NSArray *NSArrayWithMap(NSArray *array, id(^mapBlock)(id obj)) {
    NSMutableArray *newarray = [NSMutableArray arrayWithCapacity:array.count];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id ret = mapBlock(obj);
        if (ret) {
            [newarray addObject:ret];
        }
    }];
    return [newarray copy];
}



@protocol CLRunnable <NSObject>

@optional
- (int)main;

@end



@interface CLCommandConfiguration : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *note;

@property (nonatomic, strong) NSString *version;

@property (nonatomic, strong) NSArray *subcommands;

@end


@interface CLCommand : NSObject <CLRunnable>

@property (nonatomic, strong, readonly) CLRunner *runner;

+ (int)main;
+ (int)main:(int)argc argv:(const char *[])argv;
+ (int)main:(NSArray<NSString *> *)arguments;

+ (instancetype)currentCommand;

@end

@interface CLCommand (Predefine)

@property (nonatomic, assign, readonly) BOOL verbose;
@property (nonatomic, assign, readonly) BOOL help;
@property (nonatomic, assign, readonly) BOOL silent;
@property (nonatomic, assign, readonly) BOOL noANSI;

@end

#define CLRunnableMain(cmd) \
int main(int argc, const char * argv[]) { \
    int ret = 0; @autoreleasepool { ret = [cmd main]; } return ret; \
}

#define CLCommandEntry(command) \
@interface Main : CLCommand @end \
void CLCommandLineMakeMain(CLCommandConfiguration *command); \
int main(int argc, const char * argv[]) { return [Main main]; } \
@implementation Main \
command_configuration(cmd) { CLCommandLineMakeMain(cmd); } \
@end \
void CLCommandLineMakeMain(CLCommandConfiguration *command) \


#define _CL_CONCAT_4(sep, A, B, C, D)    A##sep##B##sep##C##sep##D
#define _CL_CONCAT_3(sep, A, B, C)       A##sep##B##sep##C
#define _CL_CONCAT_2(sep, A, B)          A##sep##B##sep
#define _CL_ATTRS(INDEX, CTX, VAR)  __unused __auto_type _var_##INDEX = (CTX.VAR);

#pragma mark - Option

#define _CL_OPTION(index, type, name, ...) \
+ (void)_CL_CONCAT_3(_, __CLOPT, index, name):(CLOptionInfo *)name {\
    [name setType:@#type]; \
    metamacro_foreach_cxt(_CL_ATTRS,,name,nonnull,##__VA_ARGS__) \
} \
- (type)name { return name; } \
- (void)_CL_CONCAT_3(_, __Init, index, name):(CLRunner *)runner { \
    id value = [runner __valueForTag:index]; \
    if (!value) return; \
    NSError *error = nil; \
    name = CLConvert_##type(value, &error); \
    if (error) [runner __failure:error]; \
} static type name;

#define command_option(type, name, ...) _CL_OPTION(__COUNTER__, type, name, ##__VA_ARGS__)

#pragma mark - Argument

#define _CL_ARGUMENT(index, type, name, ...) \
+ (void)_CL_CONCAT_3(_, __CLARG, index, name):(CLArgumentInfo *)name { \
    [name setType:@#type]; \
    metamacro_foreach_cxt(_CL_ATTRS,,name,self,##__VA_ARGS__) \
} \
- (type)name { return name; } \
- (void)_CL_CONCAT_3(_, __Init, index, name):(CLRunner *)runner { \
    id value = [runner __valueForTag:index]; \
    if (!value) return; \
    NSError *error = nil; \
    name = CLConvert_##type(value, &error); \
    if (error) [runner __failure:error]; \
} static type name;

#define command_argument(type, name, ...) _CL_ARGUMENT(__COUNTER__, type, name, ##__VA_ARGS__)

#pragma mark - Array

#define _CL_ARRAY_MAP(array, statement) NSArrayWithMap((array), ^id(id obj) { \
    NSError *error = nil; \
    id result = (statement); \
    if (error) [runner __failure:error]; \
    return result; \
})

#define _CL_OPTIONS(index, type, name, ...) \
+ (void)_CL_CONCAT_3(_, __CLOPTS, index, name):(CLOptionInfo *)name {\
    [name setType:@#type]; \
    metamacro_foreach_cxt(_CL_ATTRS,,name,nonnull,##__VA_ARGS__) \
} \
- (NSArray<type> *)name { return name; } \
- (void)_CL_CONCAT_3(_, __Init, index, name):(CLRunner *)runner { \
    NSArray *array = [runner __valueForTag:index]; \
    if (!array) return; \
    name = _CL_ARRAY_MAP(array, CLConvert_##type(obj, &error)); \
} static NSArray<type> *name;

#define command_options(type, name, ...) _CL_OPTIONS(__COUNTER__, type, name, ##__VA_ARGS__)

#define _CL_ARRAY(index, type, name, ...) \
+ (void)_CL_CONCAT_3(_, __CLARY, index, name):(CLArgumentInfo *)name { \
    [name setType:@#type]; \
    metamacro_foreach_cxt(_CL_ATTRS,,name,self,##__VA_ARGS__) \
} \
- (NSArray<type> *)name { return name; } \
- (void)_CL_CONCAT_3(_, __Init, index, name):(CLRunner *)runner { \
    NSArray *array = [runner __valueForTag:index]; \
    if (!array) return; \
    name = _CL_ARRAY_MAP(array, CLConvert_##type(obj, &error)); \
} static NSArray<type> *name; + (void)_This_command_should_not_contains_two_array_input {};

#define command_arguments(type, name, ...) _CL_ARRAY(__COUNTER__, type, name, ##__VA_ARGS__)

#pragma mark - Command

#define _CL_EACH_SUBCMD(INDEX, CTX, VAR) [VAR class],
#define command_subcommands(...) \
+ (void)This_command_should_contain_one_of_subcmd_or_main_function {} \
+ (NSArray<Class> *)subcommands {\
    return @[metamacro_foreach_cxt(_CL_EACH_SUBCMD,,,##__VA_ARGS__)]; \
}

#define command_main() \
+ (void)This_command_should_contain_one_of_subcmd_or_main_function {} \
- (int)main

#define command_configuration(command) \
+ (void)__configuration:(CLCommandConfiguration *)command

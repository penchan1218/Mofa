//
//  UIDevice+DeviceType.m
//  MOFA
//
//  Created by 陈颖鹏 on 15/4/3.
//  Copyright (c) 2015年 hustunique. All rights reserved.
//

#import "UIDevice+DeviceType.h"
#include "sys/types.h"
#include "sys/sysctl.h"

@implementation UIDevice (DeviceType)

- (NSString*)machine
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char* name = (char*)malloc(size);
    sysctlbyname("hw.machine", name, &size, NULL, 0);
//    NSString *machine = [NSString stringWithUTF8String:name];
    NSString* machine = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
    free(name);
    
    NSString *location = [[NSBundle mainBundle] pathForResource:@"PhoneTypes" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:location];
    
    return dic[machine];
}

@end

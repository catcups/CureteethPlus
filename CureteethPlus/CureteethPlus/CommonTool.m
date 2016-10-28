//
//  CommonTool.m
//  iCity2
//
//  Created by higgses on 14-4-15.
//  Copyright (c) 2014年 Chanly Inc. All rights reserved.
//

#import "CommonTool.h"

@implementation CommonTool

+(void)storeUserDefaults:(id)data ForKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)removeUserDefaultsByKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(id)readUserDefaultsByKey:(NSString *)key
{
	return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}


@end

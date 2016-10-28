//
//  CommonTool.h
//  iCity2
//
//  Created by higgses on 14-4-15.
//  Copyright (c) 2014年 Chanly Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonTool : NSObject


/**
 *  保存数据到NSUserDefaults
 *
 *  @param data 保存对象
 *  @param key  保存对象key
 */
+(void)storeUserDefaults:(id)data ForKey:(NSString *)key;

/**
 *  NSUserDefaults读取数据
 *
 *  @param key 数据对应的key
 *
 *  @return 返回结果
 */
+(id)readUserDefaultsByKey:(NSString *)key;

/**
 *  删除NSUserDefaults数据
 *
 *  @param key 数据对应key
 */

+(void)removeUserDefaultsByKey:(NSString *)key;


@end

//
//  NSDictionary+multiKeys.h
//  MZNetWorking
//
//  Created by LiXiangming on 2017/3/18.
//  Copyright © 2017年 LiXiangming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary <__covariant KeyType, __covariant ObjectType>(multiKeys)

/**
   get value from an string's array ,if a key has value ,return the value ,then continue
 */
- (ObjectType)objectForKeys:(NSArray<NSString*>*)keys;
/**
    get value from an string's array ,if a key has value and is kindof class of clazz,
    return the value ,then continue
 */
- (ObjectType)objectForKeys:(NSArray<NSString*>*)keys isKindof:(id)clazz;
/**
  get string from an string's array ,if a key has a string value ,return the value ,then continue
 */
- (NSString*)stringForKeys:(NSArray<ObjectType>*)keys;

- (BOOL)hasKey:(id)key;

+ (instancetype)dictWithJsonOfURL:(NSURL*)url;

- (BOOL)containsObjectForKey:(id)key;

- (NSDictionary *)dicEntriesForKeys:(NSArray *)keys;
@end

//
//  NSDictionary+multiKeys.m
//  MZNetWorking
//
//  Created by LiXiangming on 2017/3/18.
//  Copyright © 2017年 LiXiangming. All rights reserved.
//

#import "NSDictionary+multiKeys.h"

@implementation NSDictionary (multiKeys)

- (id)objectForKeys:(NSArray<id>*)keys{
    NSParameterAssert(keys);

    __block id value = nil;
    [keys enumerateObjectsUsingBlock:^(id _Nonnull element, NSUInteger idx, BOOL * _Nonnull stop){
        value = self[element];
        if (value) *stop = YES;
    }];
    return value;
}

- (id)objectForKeys:(NSArray<id>*)keys isKindof:(id)clazz{
    NSParameterAssert(keys);

    for (id element in keys) {
        id value = self[element];
        if (value && [value isKindOfClass:[clazz class]]) return value;
    }
    return nil;
}

- (NSString*)stringForKeys:(NSArray<id>*)keys{
    NSParameterAssert(keys);

    id value = [self objectForKeys:keys];
    if (value) {
        if ([value isKindOfClass:[NSString class]]) return value;
        return [value description];
    }
    return nil;
}

- (BOOL)hasKey:(id)key{
    return key && self[key];
}

+ (instancetype)dictWithJsonOfURL:(NSURL*)url{
    NSParameterAssert(url);

    NSError *error;
    NSData *data = [NSData dataWithContentsOfURL:url options:0 error:&error];
    if (error) {
        NSLog(@"%s: %@", __PRETTY_FUNCTION__, error.localizedDescription);
        return nil;
    }

    NSJSONReadingOptions opt;
    if (self == [NSDictionary class]) { opt = 0; }
    else { opt = NSJSONReadingMutableContainers; }

    NSDictionary* obj = [NSJSONSerialization JSONObjectWithData:data options:opt error:&error];
    if (error) {
        NSLog(@"%s: %@", __PRETTY_FUNCTION__, error.localizedDescription);
    } else if (![obj isKindOfClass:[NSDictionary class]]) {
        NSLog(@"%s: %@", __PRETTY_FUNCTION__, @"json obj is not dict!");
    }
    return obj;
}

- (BOOL)containsObjectForKey:(id)key {
    if (!key) return NO;
    return self[key] != nil;
}

- (NSDictionary *)dicEntriesForKeys:(NSArray *)keys {
    NSParameterAssert(keys);

    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    for (id element in keys) {
        if (element && self[element]) {
            dict[element] = self[element];
        }
    }
    return dict;
}
@end

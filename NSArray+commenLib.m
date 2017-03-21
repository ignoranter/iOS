//
//  NSArray+commenLib.m
//  MZNetWorking
//
//  Created by LiXiangming on 2017/3/17.
//  Copyright © 2017年 LiXiangming. All rights reserved.
//

#import "NSArray+commenLib.h"

@implementation NSArray (collection)

+ (NSArray*)arrayWithJsonOfFile:(NSString*)filePath{
    NSParameterAssert(filePath);
    return [self arrayWithJsonOfURL:[NSURL fileURLWithPath:filePath]];
}

+ (NSArray*)arrayWithJsonOfURL:(NSURL*)fileURL{
    NSParameterAssert(fileURL);

    NSError *error;
    NSData *data = [NSData dataWithContentsOfURL:fileURL
                                         options:0
                                           error:&error];
    if (error) NSLog(@"ERROR:[%s: %@]",__PRETTY_FUNCTION__,error.localizedDescription);

    NSJSONReadingOptions opt;
    if (self == [NSArray class]) { opt = 0; }
    else { opt = NSJSONReadingMutableContainers; }
    id obj = [NSJSONSerialization JSONObjectWithData:data
                                             options:0
                                               error:&error];
    if (error) {
        NSLog(@"ERROR:[%s: %@]", __PRETTY_FUNCTION__, error.localizedDescription);
    } else if (![obj isKindOfClass:[NSArray class]]) {
        obj = [self arrayWithObject:obj]; // Auto Pack to an array
    }
    return obj;
}

+ (NSArray*)arrayWithPListData:(NSData*)plist{
    NSParameterAssert(plist);

    if (!plist)return nil;
    NSArray *array = [NSPropertyListSerialization propertyListWithData:plist
                                                               options:NSPropertyListImmutable
                                                                format:nil
                                                                 error:nil];
    if (array && [array isKindOfClass:NSArray.class])
        return array;
    return nil;
}

+ (instancetype)arrayWithPListString:(NSString*)plist{
    NSParameterAssert(plist);

    NSData *plistData = [plist dataUsingEncoding:NSUTF8StringEncoding];
    if (plistData) {
        return [self arrayWithPListData:plistData];
    }
    return nil;
}

+ (NSData *)plistData {
    return [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListBinaryFormat_v1_0 options:kNilOptions error:NULL];
}

+ (NSString *)plistString {
    NSError *error;
    NSData *plist = [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListXMLFormat_v1_0 options:kNilOptions error:&error];
    if (plist){
        return [[NSString alloc] initWithData:plist encoding:NSUTF8StringEncoding];
    }
    return nil;
}
@end

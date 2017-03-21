//
//  NSArray+commenLib.h
//  MZNetWorking
//
//  Created by LiXiangming on 2017/3/17.
//  Copyright © 2017年 LiXiangming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (collection)

+ (NSArray*)arrayWithJsonOfFile:(NSString*)filePath;

+ (NSArray*)arrayWithJsonOfURL:(NSURL*)fileURL;

+ (NSArray*)arrayWithPListData:(NSData*)plist;

+ (instancetype)arrayWithPListString:(NSString*)plist;

+ (NSData *)plistData;

+ (NSString *)plistString;

@end

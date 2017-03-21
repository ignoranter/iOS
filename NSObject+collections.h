//
//  NSObject+collections.h
//  MZNetWorking
//
//  Created by LiXiangming on 2017/3/20.
//  Copyright © 2017年 LiXiangming. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSArray (collections)

- (_Nullable id)objAtIndex:(NSUInteger)index;
- (_Nullable id)objAtIndex:(NSUInteger)index default:(_Nonnull id)defaultKey;

- (NSInteger)integerValueOfIndex:(NSInteger)index;
- (NSInteger)integerValueOfIndex:(NSInteger)index def:(NSInteger)def;

- (BOOL)boolValueOfIndex:(NSInteger)index;
- (BOOL)boolValueOfIndex:(NSInteger)index def:(BOOL)def;

- ( NSString* _Nullable )strValueOfIndex:(NSInteger)index;
- ( NSString* _Nullable )strValueOfIndex:(NSInteger)index def:(NSString* _Nullable)def;
@end


@interface NSDictionary (collections)
/** these methods make param check. and ensure return correct type object */
-(nullable id           )objOfType:(nonnull Class)cls forKey:(nullable id)key;
-(nullable id           )objOfType:(nonnull Class)cls forKey:(nullable id)key def:(nullable id)def;

- (nullable id)objForKey:(nullable id)key;
- (nullable id)objForKey:(nullable id)key def:(nullable id)def;

-(nullable NSString*    )strForKey:        (nullable id)key;
-(nullable NSString*    )strForKey:        (nullable id)key def:(nullable NSString*)str;
-(nullable NSString*    )descriptionForKey:(nullable id)key;  ///< return [objForKey description]. thus ensure return String if key exists
-(nullable NSString*    )descriptionForKey:(nullable id)key def:(nullable NSString*)str;
-(nullable NSNumber*    )numberForKey:     (nullable id)key;
-(nullable NSArray*     )arrayForKey:      (nullable id)key;
-(nullable NSDictionary*)dictForKey:       (nullable id)key;

-(BOOL     )boolForKey:    (nullable id)key;        ///< default NO if not found
-(NSInteger)integerForKey: (nullable id)key;        ///< default 0
-(long long)longLongForKey:(nullable id)key;        ///< default 0
-(float    )floatForKey:   (nullable id)key;        ///< default 0
-(double   )doubleForKey:  (nullable id)key;        ///< default 0
-(BOOL     )boolForKey:    (nullable id)key def:(BOOL     )val;
-(NSInteger)integerForKey: (nullable id)key def:(NSInteger)val;
-(long long)longLongForKey:(nullable id)key def:(long long)val;
-(float    )floatForKey:   (nullable id)key def:(float    )val;
-(double   )doubleForKey:  (nullable id)key def:(double   )val;

@end
@interface NSObject (collections)

@end

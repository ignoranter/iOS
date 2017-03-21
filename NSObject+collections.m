//
//  NSObject+collections.m
//  MZNetWorking
//
//  Created by LiXiangming on 2017/3/20.
//  Copyright © 2017年 LiXiangming. All rights reserved.
//

#import "NSObject+collections.h"


@implementation NSArray (collections)

- (id)objAtIndex:(NSUInteger)index{
    if (index < self.count)
        return self[index];
    return nil;
}

-(id)objAtIndex:(NSUInteger)index default:(id)defaultKey{
    id obj = [self objAtIndex:index];
    if (!obj) {
        obj = defaultKey;
    }
    return obj;
}

#define return_scalar_ofIndex_def_SEL(_index, _def, _sel)           \
    NSParameterAssert(index<self.count);                            \
    if (_index < self.count) {                                      \
        id obj = [self objAtIndex:_index];                          \
        if ([obj respondsToSelector:@selector(_sel)]) {             \
            return [obj _sel];                                      \
        }                                                           \
    }                                                               \
    return _def;                                                    \

- (NSInteger)integerValueOfIndex:(NSInteger)index{return [self integerValueOfIndex:index def:0];}
- (NSInteger)integerValueOfIndex:(NSInteger)index def:(NSInteger)def{
    return_scalar_ofIndex_def_SEL(index, 0, integerValue);
}
- (BOOL)boolValueOfIndex:(NSInteger)index{return [self boolValueOfIndex:index def:NO];}
- (BOOL)boolValueOfIndex:(NSInteger)index def:(BOOL)def{
    return_scalar_ofIndex_def_SEL(index, def, boolValue);
}
- (NSString*)strValueOfIndex:(NSInteger)index{return [self strValueOfIndex:index def:@""];}
- (NSString*)strValueOfIndex:(NSInteger)index def:(NSString*)def{
    return_scalar_ofIndex_def_SEL(index, def, stringValue);
}
- (float)floatValueOfIndex:(NSInteger)index{return [self floatValueOfIndex:index def:0.0f];}
- (float)floatValueOfIndex:(NSInteger)index def:(float)def{
    return_scalar_ofIndex_def_SEL(index, def, floatValue);
}
- (double)doubleAtIndex:(NSUInteger)index {return [self doubleAtIndex:index def:0];}
- (double)doubleAtIndex:(NSUInteger)index def:(double)val {
    return_scalar_ofIndex_def_SEL(index, val, doubleValue);
}
@end

@implementation NSDictionary (collections)
/** these methods make param check. and ensure return correct type object */
- (id)objForKey:(id)key { return [self objForKey:key def:nil]; }
- (id)objForKey:(id)key def:(id)def {
    if (key) { return [self objectForKey:key]; }
    return def;
}

static inline id objForKey_type_def(NSDictionary* self, id key, Class cls, id def) {
    if (key) {
        id ret = [self objectForKey:key];
        if (ret && [ret isKindOfClass:cls]) { return ret; }
    }
    return def;
}

- (id)objOfType:(Class)cls forKey:(id)key { return objForKey_type_def(self, key, cls, nil); }
- (id)objOfType:(Class)cls forKey:(id)key def:(nullable id)def{
    return objForKey_type_def(self, key, cls, def);
}
- (NSString*)strForKey:(id)key { return objForKey_type_def(self, key, [NSString class], nil); }
- (NSString*)strForKey:(id)key def:(NSString*)str{
    return objForKey_type_def(self, key, [NSString class], str);
}

- (NSString*)descriptionForKey:(id)key { return [self descriptionForKey:key def:nil]; }
- (NSString*)descriptionForKey:(id)key def:(NSString*)str {
    if (key) {
        NSString* ret = [self objectForKey:key];
        if (ret && ret != (id)kCFNull) { return [ret description]; }
    }
    return str;
}

- (NSNumber*)numberForKey:(id)key { return objForKey_type_def(self, key, [NSNumber class], nil); }
- (NSArray*)arrayForKey:(id)key { return objForKey_type_def(self, key, [NSArray class], nil); }
- (NSDictionary*)dictForKey:(id)key { return objForKey_type_def(self, key, [NSDictionary class], nil); }

#define ret_ScalarForKey_Def_SEL(_key, _def, _sel)                  \
    if (_key) {                                                     \
        id obj = [self objectForKey:_key];                          \
        if ([obj respondsToSelector:@selector(_sel)]) {             \
            return [obj _sel];                                      \
        }                                                           \
    }                                                               \
    return _def;                                                    \

- (BOOL)boolForKey:(id)key          { return [self boolForKey:key def:NO]; }
- (NSInteger)integerForKey:(id)key  { return [self integerForKey:key def:0]; }
- (long long)longLongForKey:(id)key { return [self longLongForKey:key def:0]; }
- (float)floatForKey:(id)key        { return [self floatForKey:key def:0]; }
- (double)doubleForKey:(id)key      { return [self doubleForKey:key def:0]; }
- (BOOL)boolForKey:(id)key def:(BOOL)val { ret_ScalarForKey_Def_SEL(key, val, boolValue); }
- (NSInteger)integerForKey:(id)key def:(NSInteger)val  { ret_ScalarForKey_Def_SEL(key, val, integerValue); }
- (long long)longLongForKey:(id)key def:(long long)val { ret_ScalarForKey_Def_SEL(key, val, longLongValue);}
- (float)floatForKey:(id)key def:(float)val    { ret_ScalarForKey_Def_SEL(key, val, floatValue); }
- (double)doubleForKey:(id)key def:(double)val { ret_ScalarForKey_Def_SEL(key, val, doubleValue); }

@end


@implementation NSObject (collections)

@end

//
//  BMBaseModel.m
//  BM4Group
//
//  Created by Chrain on 15/5/25.
//  Copyright (c) 2015年 蓝色互动. All rights reserved.
//

#import "BMBaseModel.h"

@implementation BMBaseModel

#if __has_include(<MJExtension/MJExtension.h>)
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"objectID": @"id"};
}

+ (id)mj_getNewValueFromObject:(__unsafe_unretained id)object oldValue:(__unsafe_unretained id)oldValue property:(MJProperty *__unsafe_unretained)property {
    if (property.type.typeClass == [NSDate class]) {
        if ([oldValue isKindOfClass:[NSString class]] && [oldValue isExist]) {
            return [self.defaultDateFormatter dateFromString:oldValue];
        } else {
            return nil;
        }
    } else if (property.type.typeClass == [NSURL class]) {
        if ([oldValue isKindOfClass:[NSString class]] && [oldValue isExist]) {
            return [NSURL URLWithString:oldValue];
        } else {
            return nil;
        }
    } else {
        return oldValue;
    }
}
#endif

+ (NSDateFormatter *)defaultDateFormatter
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return formatter;
}

@end

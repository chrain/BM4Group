//
//  BMBaseModel.m
//  BM4Group
//
//  Created by Chrain on 15/5/25.
//  Copyright (c) 2015年 蓝色互动. All rights reserved.
//

#import "BMBaseModel.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused"
/// Parse string to date.
static NSDate *BMNSDateFromString(__unsafe_unretained NSString *string)
{
    typedef NSDate * (^YYNSDateParseBlock)(NSString *string);
#define kParserNum 32
    static YYNSDateParseBlock blocks[kParserNum + 1] = {0};
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        {
            /*
             2014-01-20  // Google
             */
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            formatter.dateFormat = @"yyyy-MM-dd";
            blocks[10] = ^(NSString *string) {
        return [formatter dateFromString:string]; };
}

{
    /*
             2014-01-20 12:24:48
             2014-01-20T12:24:48   // Google
             */
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    formatter1.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    formatter1.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    formatter1.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";

    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    formatter2.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    formatter2.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    formatter2.dateFormat = @"yyyy-MM-dd HH:mm:ss";

    blocks[19] = ^(NSString *string) {
                if ([string characterAtIndex:10] == 'T') {
                    return [formatter1 dateFromString:string];
                } else {
                    return [formatter2 dateFromString:string];
                }
    };
}

{
    /*
             2014-01-20T12:24:48Z        // Github, Apple
             2014-01-20T12:24:48+0800    // Facebook
             2014-01-20T12:24:48+12:00   // Google
             */
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
    blocks[20] = ^(NSString *string) { return [formatter dateFromString:string];
    };
    blocks[24] = ^(NSString *string) { return [formatter dateFromString:string];
    };
    blocks[25] = ^(NSString *string) { return [formatter dateFromString:string];
    };
}

{
    /*
             Fri Sep 04 00:12:21 +0800 2015 // Weibo, Twitter
             */
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    blocks[30] = ^(NSString *string) { return [formatter dateFromString:string];
    };
}
});
if (!string) return nil;
if (string.length > kParserNum) return nil;
YYNSDateParseBlock parser = blocks[string.length];
if (!parser) return nil;
return parser(string);
#undef kParserNum
}
#pragma clang diagnostic pop


@implementation BMBaseModel

#if __has_include(<MJExtension/MJExtension.h>)
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{ @"objectID" : @"id" };
}

+ (id)mj_getNewValueFromObject:(__unsafe_unretained id)object oldValue:(__unsafe_unretained id)oldValue property:(MJProperty *__unsafe_unretained)property
{
    if (property.type.typeClass == [NSDate class]) {
        if ([oldValue isKindOfClass:[NSString class]]) {
            return BMNSDateFromString(oldValue);
        } else {
            return nil;
        }
    } else if (property.type.typeClass == [NSURL class]) {
        if ([oldValue isKindOfClass:[NSString class]]) {
            return [NSURL URLWithString:oldValue];
        } else {
            return nil;
        }
    } else {
        return oldValue;
    }
}
#endif

@end

//
//  BMUtils.m
//  BM4Group
//
//  Created by Chrain on 15/5/25.
//  Copyright (c) 2015年 蓝色互动. All rights reserved.
//

#import "BMUtils.h"
#import <UIKit/UIWebView.h>
#import "NSString+Exist.h"

#if __has_include(<BRCocoaLumberjack/BRCocoaLumberjack.h>)
#import <BRCocoaLumberjack/BRCocoaLumberjack.h>
#endif

NSString *const kPreviewFeatureVersionKey = @"previewFeatureVersion";


@implementation BMUtils

+ (BOOL)showNewFeature
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *previewFeatureVersion = [userDefaults stringForKey:kPreviewFeatureVersionKey];

    if (![previewFeatureVersion isExist]) return YES;

    NSString *version = [NSBundle mainBundle].infoDictionary[(__bridge NSString *)kCFBundleVersionKey];
    return ![previewFeatureVersion isEqualToString:version];
}

+ (void)updateFeatureVersion
{
    NSString *version = [NSBundle mainBundle].infoDictionary[(__bridge NSString *)kCFBundleVersionKey];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:version forKey:kPreviewFeatureVersionKey];
    [userDefaults synchronize];
}

+ (void)callWithPhoneNumber:(NSString *)phone
{
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phone]];
    UIWebView *phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
    //    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", phone]];
    //    [[UIApplication sharedApplication] openURL:url];
}

+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15， 17， 18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(17[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

+ (BOOL)isValidateIDCard:(NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

+ (BOOL)isValidateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", carRegex];
    return [carTest evaluateWithObject:carNo];
}

+ (NSString *)weekdayStringFromDate:(NSDate *)inputDate
{
    NSArray *weekdays = [NSArray arrayWithObjects:[NSNull null], @"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];

    [calendar setTimeZone:timeZone];

    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;

    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];

    return [weekdays objectAtIndex:theComponents.weekday];
}

+ (NSString *)getChineseCalendarWithDate:(NSDate *)date
{
    NSArray *chineseYears = [NSArray arrayWithObjects:
                                         @"甲子", @"乙丑", @"丙寅", @"丁卯", @"戊辰", @"己巳", @"庚午", @"辛未", @"壬申", @"癸酉",
                                         @"甲戌", @"乙亥", @"丙子", @"丁丑", @"戊寅", @"己卯", @"庚辰", @"辛己", @"壬午", @"癸未",
                                         @"甲申", @"乙酉", @"丙戌", @"丁亥", @"戊子", @"己丑", @"庚寅", @"辛卯", @"壬辰", @"癸巳",
                                         @"甲午", @"乙未", @"丙申", @"丁酉", @"戊戌", @"己亥", @"庚子", @"辛丑", @"壬寅", @"癸丑",
                                         @"甲辰", @"乙巳", @"丙午", @"丁未", @"戊申", @"己酉", @"庚戌", @"辛亥", @"壬子", @"癸丑",
                                         @"甲寅", @"乙卯", @"丙辰", @"丁巳", @"戊午", @"己未", @"庚申", @"辛酉", @"壬戌", @"癸亥", nil];

    NSArray *chineseMonths = [NSArray arrayWithObjects:
                                          @"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
                                          @"九月", @"十月", @"冬月", @"腊月", nil];


    NSArray *chineseDays = [NSArray arrayWithObjects:
                                        @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                                        @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                                        @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十", nil];


    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];

    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;

    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:date];

    NSLog(@"%zd_%zd_%zd", localeComp.year, localeComp.month, localeComp.day);

    NSString *y_str = [chineseYears objectAtIndex:localeComp.year - 1];
    NSString *m_str = [chineseMonths objectAtIndex:localeComp.month - 1];
    NSString *d_str = [chineseDays objectAtIndex:localeComp.day - 1];

    NSString *chineseCal_str = [NSString stringWithFormat:@"%@_%@_%@", y_str, m_str, d_str];

    return chineseCal_str;
}

+ (void)setupLog
{
    setenv("XcodeColors", "YES", 0);
#if __has_include(<BRCocoaLumberjack/BRCocoaLumberjack.h>)
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithRed:0.122 green:0.319 blue:1.000 alpha:1.000] backgroundColor:nil forFlag:DDLogFlagDebug];
    BRLoggingSetupDefaultLogging();
#endif
}

@end

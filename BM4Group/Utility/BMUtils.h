//
//  BMUtils.h
//  BM4Group
//
//  Created by Chrain on 15/5/25.
//  Copyright (c) 2015年 蓝色互动. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BMUtils : NSObject

/**
 *  是否新版本
 *
 *  @return YES:表示为新版本
 */
+ (BOOL)showNewFeature;

/**
 *  更新版本信息
 */
+ (void)updateFeatureVersion;

/**
 *  拨打电话
 */
+ (void)callWithPhoneNumber:(NSString *)phone;

#pragma mark - 邮箱、手机等是否有效验证.
/**邮箱验证 */
+ (BOOL)isValidateEmail:(NSString *)email;

/**手机号码验证 */
+ (BOOL)isValidateMobile:(NSString *)mobile;

/**身份证号码验证*/
+ (BOOL)isValidateIDCard:(NSString *)identityCard;

/**车牌号验证 */
+ (BOOL)isValidateCarNo:(NSString *)carNo;

///获得某个NSDate的星期几
+ (NSString *)weekdayStringFromDate:(NSDate *)inputDate;

///获得某个NSDate的农历表示法
+ (NSString *)getChineseCalendarWithDate:(NSDate *)date;

/**
 *  设置日志控制
 */
+ (void)setupLog NS_EXTENSION_UNAVAILABLE("由于Xcode8不支持插件，cosel颜色输出已无效");

@end

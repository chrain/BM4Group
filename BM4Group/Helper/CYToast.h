//
//  CYToast.h
//  MoonLight
//
//  Created by 陈宇 on 16/2/3.
//  Copyright © 2016年 陈宇. All rights reserved.
//

#import <UIKit/UIKit.h>

#if __has_include(<YYKit/YYKit.h>)

@interface CYToast : NSObject

+ (void)makeText:(NSString *)text;

+ (void)makeText:(NSString *)text offset:(CGFloat)offset;

+ (void)makeText:(NSString *)text duration:(CFTimeInterval)duration;

+ (void)makeText:(NSString *)text duration:(CFTimeInterval)duration offset:(CGFloat)offset;

@end

#endif
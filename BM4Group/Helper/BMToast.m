//
//  CYToast.m
//  MoonLight
//
//  Created by 陈宇 on 16/2/3.
//  Copyright © 2016年 陈宇. All rights reserved.
//

#import "BMToast.h"
#import "NSString+Exist.h"
#import "UIView+Extension.h"

#if __has_include(<YYKit/YYKit.h>)
#import <YYKit/YYKit.h>
#endif


@implementation BMToast

+ (void)makeText:(NSString *)text
{
    [self makeText:text duration:2 offset:0];
}

+ (void)makeText:(NSString *)text duration:(CFTimeInterval)duration
{
    [self makeText:text duration:duration offset:0];
}

+ (void)makeText:(NSString *)text offset:(CGFloat)offset
{
    [self makeText:text duration:2 offset:offset];
}

#if __has_include(<YYKit/YYKit.h>)
static YYLabel *label = nil;
#else
static UILabel *label = nil;
#endif

+ (void)makeText:(NSString *)text duration:(CFTimeInterval)duration offset:(CGFloat)offset
{
    if (![text isExist]) return;

    static CGFloat padding = 10.f;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#if __has_include(<YYKit/YYKit.h>)
        label = [[YYLabel alloc] init];
        label.textContainerInset = UIEdgeInsetsMake(0.5 * padding, padding * 1.5, 0.5 * padding, padding * 1.5);
#else
        label = [[UILabel alloc] init];
#endif
        label.numberOfLines = 0;
        label.userInteractionEnabled = NO;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14.f];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        label.layer.cornerRadius = 5.f;
        label.layer.masksToBounds = YES;
    });

    label.size = [text sizeForFont:label.font size:CGSizeMake([UIScreen mainScreen].bounds.size.width - padding * 7, HUGE) mode:NSLineBreakByWordWrapping];
    label.width += 3 * padding;
    label.height += padding;

    UIView *superView = [UIApplication sharedApplication].keyWindow ?: [UIApplication sharedApplication].windows.lastObject;

    label.centerX = superView.centerX;
    label.bottom = [UIScreen mainScreen].bounds.size.height - 60.f;

    [superView addSubview:label];
    label.text = text;

    if (label.superview) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideToast) object:nil];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            label.alpha = 1.f;
        }];
    }
    [self performSelector:@selector(hideToast) withObject:nil afterDelay:duration];
}

+ (void)hideToast
{
    [UIView animateWithDuration:0.2 animations:^{
        label.alpha = 0.f;
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
        label.alpha = 1.f;
    }];
}

@end

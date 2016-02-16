//
//  CYToast.m
//  MoonLight
//
//  Created by 陈宇 on 16/2/3.
//  Copyright © 2016年 陈宇. All rights reserved.
//

#import "CYToast.h"

#if __has_include(<YYKit/YYKit.h>)
#import <YYKit/YYKit.h>

@implementation CYToast

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

static UILabel *label = nil;

+(void)makeText:(NSString *)text duration:(CFTimeInterval)duration offset:(CGFloat)offset
{
    if (![text isNotBlank]) return;
    
    static CGFloat padding = 10.f;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.userInteractionEnabled = NO;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14.f];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
//        label.textContainerInset = UIEdgeInsetsMake(padding, padding * 2, padding, padding * 2);
        label.layer.cornerRadius = 5.f;
        label.layer.masksToBounds = YES;
    });
    
    label.width = kScreenWidth - padding * 4;
    label.size = [text sizeForFont:label.font size:CGSizeMake(label.width - 4 * padding, HUGE) mode:NSLineBreakByWordWrapping];
    label.width += padding * 3;
    label.height += padding * 1.4;
    
    UIView *superView = [UIApplication sharedApplication].keyWindow ?: [UIApplication sharedApplication].windows.lastObject;
    
    label.centerX = superView.centerX;
    label.bottom = kScreenHeight - 60.f;
    
    [superView addSubview:label];
    label.text = text;
    
    if (label.superview) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideToast) object:nil];
    }
    else {
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

#endif

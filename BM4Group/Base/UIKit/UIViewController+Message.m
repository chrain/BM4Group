//
//  UIViewController+Hint.m
//  BM4Group
//
//  Created by 陈宇 on 16/2/1.
//  Copyright © 2016年 陈宇. All rights reserved.
//

#import "UIViewController+Message.h"
#import "NSString+Exist.h"
#import "UIView+Extension.h"

#if __has_include(<YYKit/YYKit.h>)
#import <YYKit/YYKit.h>
#endif


@implementation UIViewController (Message)

#if __has_include(<YYKit/YYKit.h>)
static YYLabel *_label;
#else
static UILabel *_label;
#endif

- (void)showMessage:(NSString *)message
{
    [self showMessage:message type:HintTypeSuccessful];
}

- (void)showMessage:(NSString *)message offset:(CGFloat)offset
{
    [self showMessage:message type:HintTypeSuccessful offset:offset];
}

- (void)showMessage:(NSString *)message type:(HintType)type
{
    [self showMessage:message type:type offset:0];
}

- (void)showMessage:(NSString *)message type:(HintType)type offset:(CGFloat)offset
{
    if (![message isExist]) return;

    static CGFloat padding = 10.f;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#if __has_include(<YYKit/YYKit.h>)
        _label = [[YYLabel alloc] init];
        _label.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        _label.textContainerInset = UIEdgeInsetsMake(padding, padding * 2, padding, padding * 2);
#else
        _label = [[UILabel alloc] init];
#endif
        _label.numberOfLines = 0;
        _label.userInteractionEnabled = NO;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:14.f];
        _label.textColor = [UIColor whiteColor];
    });

    // 设置背景色
    switch (type) {
        case HintTypeSuccessful:
            _label.backgroundColor = [UIColor colorWithRed:0.033 green:0.685 blue:0.978 alpha:0.830];
            break;
        case HintTypeFailure:
            _label.backgroundColor = [UIColor colorWithRed:0.963 green:0.085 blue:0.078 alpha:0.830];
            break;
    }

    CGRect labelF = _label.frame;
    labelF.size.width = self.view.bounds.size.width;
    labelF.size.height = [message sizeForFont:_label.font size:CGSizeMake(labelF.size.width - 4 * padding, HUGE) mode:NSLineBreakByWordWrapping].height + 2 * padding;
    _label.frame = labelF;

    _label.text = message;

    if (_label.superview) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideMessage) object:nil];
        _label.top = [self defaultOffset] + offset;
    } else {
        _label.bottom = [self defaultOffset] + offset;
        if (self.navigationController && ![self.navigationController isNavigationBarHidden]) {
            [self.navigationController.view insertSubview:_label belowSubview:self.navigationController.navigationBar];
        } else {
            [self.view insertSubview:_label atIndex:self.view.subviews.count];
        }
        [UIView animateWithDuration:0.2 animations:^{
            _label.transform = CGAffineTransformMakeTranslation(0, _label.height);
        }];
    }
    [self performSelector:@selector(hideMessage) withObject:nil afterDelay:2];
}

- (void)hideMessage
{
    [UIView animateWithDuration:0.2 animations:^{
        _label.transform = CGAffineTransformIdentity;
    }
        completion:^(BOOL finished) {
                         [_label removeFromSuperview];
        }];
}

- (CGFloat)defaultOffset
{
    CGFloat offset = 0.f;

    if (![UIApplication sharedApplication].statusBarHidden) offset += 20.f;

    if (self.navigationController && !self.navigationController.navigationBarHidden) offset += 44.f;

    return offset;
}

- (BOOL)isNavigationBarShow
{
    return self.navigationController && ![self.navigationController.navigationBar isHidden];
}

@end

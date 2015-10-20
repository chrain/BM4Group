//
//  BMAvatarView.m
//  xbrc
//
//  Created by 陈宇 on 15/7/13.
//  Copyright (c) 2015年 陈宇. All rights reserved.
//

#import "BMAvatarView.h"

@implementation BMAvatarView

- (instancetype)init
{
    if (self = [super init]) {
        [self configuration];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self configuration];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self configuration];
    }
    return self;
}

- (void)configuration
{
    self.backgroundColor = [UIColor clearColor];
    self.borderColor = [UIColor whiteColor];
    self.borderWidth = 2.f;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    //画背景圆环
    [self.borderColor set];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, rect);
    CGContextFillPath(ctx);
    
    //画圆形头像
    CGContextAddEllipseInRect(ctx, CGRectInset(rect, _borderWidth, _borderWidth));
    CGContextClip(ctx);
    [self.avatar drawInRect:rect];
}

- (void)setAvatar:(UIImage *)avatar
{
    _avatar = avatar;
    [self setNeedsDisplay];
}

@end

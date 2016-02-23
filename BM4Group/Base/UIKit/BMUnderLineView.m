//
//  UnderLineView.m
//  Express
//
//  Created by 陈宇 on 15/10/25.
//  Copyright © 2015年 陈宇. All rights reserved.
//

#import "BMUnderLineView.h"
#import "BM4GroupMacro.h"

static void *UnderLineSerializerObserverContext = &UnderLineSerializerObserverContext;


@implementation BMUnderLineView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.lineHeight = k1PX_WIDTH;
    self.lineColor = kRGB(216, 216, 216);
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    [self.lineColor set];

    UIRectFill(CGRectMake(self.lineInserts.left, rect.size.height - self.lineInserts.bottom - self.lineHeight, rect.size.width - self.lineInserts.left - self.lineInserts.right, self.lineHeight));
}

- (void)setLineHeight:(CGFloat)lineHeight
{
    _lineHeight = lineHeight;
    [self setNeedsDisplay];
}

- (void)setLineInserts:(UIEdgeInsets)lineInserts
{
    _lineInserts = lineInserts;
    [self setNeedsDisplay];
}

- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    [self setNeedsDisplay];
}

#pragma mark - KVO

- (void)registerForKVO
{
    for (NSString *keyPath in [self observableKeypaths]) {
        [self addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:NULL];
    }
}

- (void)unregisterFromKVO
{
    for (NSString *keyPath in [self observableKeypaths]) {
        [self removeObserver:self forKeyPath:keyPath];
    }
}

- (NSArray *)observableKeypaths
{
    return [NSArray arrayWithObjects:@"lineHeight", @"lineInserts", @"lineColor", nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setNeedsDisplay];
}

@end

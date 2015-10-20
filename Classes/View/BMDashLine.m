//
//  BMDashLine.m
//  特种车调度
//
//  Created by 陈宇 on 15/8/19.
//
//

#import "BMDashLine.h"

@implementation BMDashLine

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    [BMColor(217, 217, 217, 1) setStroke];
    CGFloat lengths[] = {4, 4};
    CGContextSetLineDash(context, 0, lengths, 2);
    CGContextMoveToPoint(context, 0, 0);
    
    BOOL horizontal = rect.size.width > rect.size.height;
    
    if (horizontal) {
        CGContextSetLineWidth(context, rect.size.height);
        CGContextAddLineToPoint(context, rect.size.width, 0);
    } else {
        CGContextSetLineWidth(context, rect.size.width);
        CGContextAddLineToPoint(context, 0, rect.size.height);
    }
    CGContextStrokePath(context);
}

@end

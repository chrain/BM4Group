//
//  UIView+AutoLayoutDebugging.m
//  特种车调度
//
//  Created by 陈宇 on 15/9/2.
//
//

#import "UIView+AutoLayoutDebugging.h"

@implementation UIView (AutoLayoutDebugging)

- (void)printAutoLayoutTrace
{
#ifdef DEBUG
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    NSLog(@"%@", [self performSelector:@selector(_autolayoutTrace)]);
#pragma clang diagnostic pop
#endif
}

@end

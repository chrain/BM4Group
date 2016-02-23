//
//  UnderLineView.h
//  Express
//
//  Created by 陈宇 on 15/10/25.
//  Copyright © 2015年 陈宇. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE


@interface BMUnderLineView : UIView

/**
 *  默认为1px
 */
@property (nonatomic, assign) IBInspectable CGFloat lineHeight;

/**
 *  默认为UIEdgeInsetZero
 */
@property (nonatomic, assign) UIEdgeInsets lineInserts;

@property (nonatomic, strong) IBInspectable UIColor *lineColor;

@end

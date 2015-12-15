//
//  BMAvatarView.h
//  xbrc
//
//  Created by 陈宇 on 15/7/13.
//  Copyright (c) 2015年 陈宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMAvatarView : UIView

/**
 *  底色，也就是边框色。默认是白色
 */
@property (nonatomic, strong) UIColor *borderColor;

/**
 *  底色显示宽度，也就是边框色宽度。默认为2.f
 */
@property (nonatomic, assign) CGFloat borderWidth;

@property (nonatomic, strong) UIImage *avatar;

@end

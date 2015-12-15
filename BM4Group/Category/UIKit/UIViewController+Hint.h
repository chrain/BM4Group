//
//  UIViewController+BM.h
//  BM4Group
//
//  Created by Chrain on 15/6/5.
//  Copyright (c) 2015年 蓝色互动武汉项目4部. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Hint)

/**
 *  在一个给定的View上显示默认的菊花
 *
 *  @param view 需要显示菊花的View
 *  @param hint message
 */
- (void)showHudInView:(UIView *)view hint:(NSString *)hint;

/**
 *  如果有导航控制器，显示在导航控制器View上，没有则显示在当前控制器view上
 *
 *  @param hint message
 */
- (void)showHudWithHint:(NSString *)hint;

/**
 *  对应隐藏showHudInView: hint:以及showHudWithHint:方法显示出来的菊花
 */
- (void)hideHud;

/**
 *  显示一个类似于android的Toast的提示消息。
 *
 *  @param hint message
 */
- (void)showHint:(NSString *)hint;

/// 从默认(showHint:)显示的位置再往上(下)yOffset
- (void)showHint:(NSString *)hint yOffset:(float)yOffset;

/**
 *  快快速弹出一个显示alert的消息，只有一个确定按钮，不做任何操作。
 *
 *  @param message message
 */
- (void)alertWith:(NSString *)message;

/**
 *  快快速弹出一个显示alert的消息，确定按钮可以传入对应操作。
 *
 *  @param message mesage
 *  @param ok      确定按钮对应的操作
 */
- (void)alertWith:(NSString *)message okHandler:(void (^)())ok;

@end

//
//  UIViewController+BM.h
//  BM4Group
//
//  Created by Chrain on 15/6/5.
//  Copyright (c) 2015年 蓝色互动武汉项目4部. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewController (Alert)

/**
 *  快快速弹出一个显示alert的消息，只有一个确定按钮，不做任何操作。
 *
 *  @param message message
 */
- (void)showAlertWithMessage:(NSString *)message;

/**
 *  快快速弹出一个显示alert的消息，确定按钮可以传入对应操作。
 *
 *  @param message mesage
 *  @param ok      确定按钮对应的操作
 */
- (void)showAlertWithMessage:(NSString *)message okHandler:(dispatch_block_t)okHandler;

@end

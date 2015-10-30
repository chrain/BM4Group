//
//  UIViewController+BM.h
//  BM4Group
//
//  Created by Chrain on 15/6/5.
//  Copyright (c) 2015年 蓝色互动武汉项目4部. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (BM)

- (void)showHudInView:(UIView *)view hint:(NSString *)hint;

- (void)hideHud;

- (void)showHint:(NSString *)hint;

// 从默认(showHint:)显示的位置再往上(下)yOffset
- (void)showHint:(NSString *)hint yOffset:(float)yOffset;

- (void)alertFor:(NSString *)message;

- (void)alertFor:(NSString *)message okHandler:(void (^)())ok;

@end

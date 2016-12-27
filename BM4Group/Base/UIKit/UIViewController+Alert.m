//
//  UIViewController+BM.m
//  BM4Group
//
//  Created by Chrain on 15/6/5.
//  Copyright (c) 2015年 蓝色互动武汉项目4部. All rights reserved.
//

#import "UIViewController+Alert.h"


@implementation UIViewController (Alert)

- (void)showAlertWithMessage:(NSString *)message
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"确定", @"确定") style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)showAlertWithMessage:(NSString *)message okHandler:(dispatch_block_t)okHandler
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"取消", @"取消") style:UIAlertActionStyleCancel handler:nil]];
    [alertVC addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"确定", @"确定") style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
        okHandler();
    }]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end

//
//  UIViewController+BM.m
//  BM4Group
//
//  Created by Chrain on 15/6/5.
//  Copyright (c) 2015年 蓝色互动武汉项目4部. All rights reserved.
//

#import "UIViewController+Hint.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>

static const void *HttpRequestHUDKey = &HttpRequestHUDKey;

@implementation UIViewController (Hint)

- (MBProgressHUD *)HUD{
    MBProgressHUD *HUD = objc_getAssociatedObject(self, HttpRequestHUDKey);
    if (!HUD) {
        HUD = [[MBProgressHUD alloc] initWithView:view];
        objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return HUD;
}

- (void)showHudInView:(UIView *)view hint:(NSString *)hint{
    MBProgressHUD *HUD = self.HUD;
    HUD.detailsLabelText = hint;
    [view addSubview:HUD];
    [HUD show:YES];
}

- (void)showHudWithHint:(NSString *)hint {
    [self showHudInView:self.navigationController.view ?: self.view hint:hint];
}


- (void)showHint:(NSString *)hint
{
    [self showHint:hint yOffset:0.f];
}

- (void)showHint:(NSString *)hint yOffset:(float)yOffset {
    if ([self isViewLoaded] && self.view.window) {
        //显示提示信息
        UIView *view = [[UIApplication sharedApplication].delegate window];
        NSArray * huds = [MBProgressHUD allHUDsForView:view];
        [huds makeObjectsPerformSelector:@selector(removeFromSuperview)];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.userInteractionEnabled = NO;
        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeText;
        hud.animationType = MBProgressHUDAnimationZoom;
        hud.opacity = 0.5;
        hud.detailsLabelText = hint;
        hud.margin = 10.f;
        hud.yOffset = IS_IPHONE_5 ? 200.f : 150.f;
        hud.yOffset += yOffset;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1.5f];
    }
}

- (void)hideHud{
    [[self HUD] hide:YES];
}

- (void)alertWith:(NSString *)message
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)alertWith:(NSString *)message okHandler:(void (^)())ok
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ok();
    }]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end

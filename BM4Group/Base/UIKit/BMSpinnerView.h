//
//  BMSpinnerView.h
//  项目结构
//
//  Created by 陈宇 on 15/10/30.
//  Copyright © 2015年 陈宇. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BMSpinnerView : UITableView <UITableViewDataSource, UITableViewDelegate>

/**
 *  数据模型，BMBaseModel或者NSString
 */
@property (nonatomic, strong) NSArray *datas;

/**
 *  默认选中的序号
 */
@property (nonatomic, assign) NSInteger defaultSelectedIndex;

/**
 *  点击dim是否消失
 */
@property (nonatomic, assign) BOOL touchOutsideHide;

/**
 *  点击时的回掉
 */
@property (nonatomic, copy) void (^callback)(NSIndexPath *);

/**
 *  spinnerView显示在哪个view下面
 *
 *  @param target 显示在目标的view下面，并且宽度和目标View等宽。
 */
- (void)showBelowWith:(UIView *)target;

/**
 *  隐藏spinnerView
 *
 *  @param animate 动画
 */
- (void)hideWithAnimate:(BOOL)animate;

@end

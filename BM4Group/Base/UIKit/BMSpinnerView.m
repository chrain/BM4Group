//
//  BMSpinnerView.m
//  项目结构
//
//  Created by 陈宇 on 15/10/30.
//  Copyright © 2015年 陈宇. All rights reserved.
//

#import "BMSpinnerView.h"
#import "BMBaseModel.h"


@interface StatusBarLightController : UIViewController

@end


@implementation StatusBarLightController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [UIApplication sharedApplication].keyWindow.rootViewController.preferredStatusBarStyle;
}

@end


@implementation BMSpinnerView

#pragma mark - 生命周期方法

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

#pragma mark - 私有方法

- (void)initialize
{
    _touchOutsideHide = YES;
    _defaultSelectedIndex = NSNotFound;
    self.layer.cornerRadius = 2.f;
    self.delegate = self;
    self.dataSource = self;
}

static UIWindow *_window;
static UIButton *_cover;

#pragma mark - 公开开发

- (void)showBelowWith:(UIView *)target
{
    [target.window endEditing:YES];

    [self reloadData];

    _window = [[UIWindow alloc] init];
    _window.hidden = NO;
    _window.windowLevel = UIWindowLevelAlert;
    _window.frame = [UIScreen mainScreen].bounds;
    _window.backgroundColor = [UIColor clearColor];
    _window.rootViewController = [StatusBarLightController new];

    _cover = [UIButton new];
    _cover.userInteractionEnabled = self.touchOutsideHide;
    _cover.frame = _window.frame;
    _cover.backgroundColor = [UIColor clearColor];
    [_cover addTarget:self action:@selector(coverClicked) forControlEvents:UIControlEventTouchUpInside];
    _cover.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_window addSubview:_cover];

    CGRect frame = [target.superview convertRect:target.frame toView:target.window];
    //计算targetview之下还有多少高度
    CGFloat useHeight = _window.bounds.size.height - CGRectGetMaxY(frame) - 5.f;

    CGRect tableF = self.frame;

    tableF.size.height = 0.f;
    tableF.size.width = frame.size.width;
    tableF.origin = CGPointMake(frame.origin.x, CGRectGetMaxY(frame));
    self.frame = tableF;
    [_window addSubview:self];

    [UIView animateWithDuration:0.25f delay:0.f usingSpringWithDamping:1.0 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _cover.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.15];
        if (useHeight >= self.contentSize.height) {
            CGRect tableF = self.frame;
            tableF.size.height = self.contentSize.height;
            self.frame = tableF;
        } else {
            CGRect tableF = self.frame;
            tableF.size.height = useHeight;
            self.frame = tableF;
        }
    } completion:^(BOOL finished){

    }];
}

- (void)coverClicked
{
    [self hideWithAnimate:YES];
}

- (void)hideWithAnimate:(BOOL)animate
{
    [UIView animateWithDuration:animate ? 0.25f : 0.f delay:0.f usingSpringWithDamping:0.9 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _cover.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.0f];
        CGRect tableF = self.frame;
        tableF.size.height = 0.f;
        self.frame = tableF;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [_cover removeFromSuperview];
        _cover = nil;
        _window = nil;
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kReuseIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kReuseIdentifier];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:13.f];
        cell.textLabel.textColor = [UIColor darkGrayColor];
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.05];
        cell.selectedBackgroundView = bgView;
    }

    // 设置数据
    id data = _datas[indexPath.row];
    if ([data isKindOfClass:[NSString class]]) {
        cell.textLabel.text = data;
    } else if ([data isKindOfClass:[BMBaseModel class]]) {
        cell.textLabel.text = [(BMBaseModel *)data name];
    } else {
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:@"BMSpinner数据源必须为NSString或者BMBaseModel类型"
                                     userInfo:nil];
    }

    // 设置默认选中
    if (self.defaultSelectedIndex == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (_callback) {
        self.callback(indexPath);
    }
}

@end

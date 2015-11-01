//
//  BMTextView.m
//  ZPM
//
//  Created by 陈宇 on 15/4/18.
//  Copyright (c) 2015年 蓝色互动. All rights reserved.
//

#import "BMTextView.h"
#import "UIView+Convenience.h"

@interface BMTextView ()

@property (nonatomic, strong) UILabel *placeHolderLabel;

@end

@implementation BMTextView

- (instancetype)init
{
    if (self = [super init]) {
        [self registeNoti];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self registeNoti];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self registeNoti];
}

- (void)registeNoti
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UILabel *)placeHolderLabel
{
    if (!_placeHolderLabel) {
        _placeHolderLabel = [[UILabel alloc] init];
        _placeHolderLabel.y = 8.f;
        _placeHolderLabel.x = 4.5f;
        _placeHolderLabel.width = self.width;
        _placeHolderLabel.font = [UIFont systemFontOfSize:11.f];
        if (_placeHolderColor) {
            _placeHolderLabel.textColor = _placeHolderColor;
        } else {
            _placeHolderLabel.textColor = [UIColor lightGrayColor];
        }
        [self addSubview:_placeHolderLabel];
    }
    return _placeHolderLabel;
}

- (void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = [placeHolder copy];
    self.placeHolderLabel.text = _placeHolder;
    _placeHolderLabel.height = [_placeHolder sizeWithAttributes:@{NSFontAttributeName: _placeHolderLabel.font}].height;
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor
{
    _placeHolderColor = placeHolderColor;
    _placeHolderLabel.textColor = _placeHolderColor;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    _placeHolderLabel.font = font;
}

- (void)textChange:(NSNotification *)noti
{
    _placeHolderLabel.hidden = self.text.length != 0;
}

@end

//
//  UIView+Extension.h
//  BM4GroupExample
//
//  Created by 陈宇 on 16/2/20.
//  Copyright © 2016年 陈宇. All rights reserved.
//

#import <UIKit/UIKit.h>

#if !__has_include(<YYKit/YYKit.h>)


@interface UIView (Extension)

@property (nonatomic) CGFloat left;    ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat top;     ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat right;   ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;  ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;   ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat height;  ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat centerX; ///< Shortcut for center.x
@property (nonatomic) CGFloat centerY; ///< Shortcut for center.y
@property (nonatomic) CGPoint origin;  ///< Shortcut for frame.origin.
@property (nonatomic) CGSize size;     ///< Shortcut for frame.size.

@end


@interface NSString (Extension)

- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

@end

#endif

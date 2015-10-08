//
//  UIImage+BM.h
//  BM4Group
//
//  Created by Chrain on 15/5/25.
//  Copyright (c) 2015年 蓝色互动. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BM)

/**
 *  拉伸一张图片
 */
+ (UIImage *)resizeImage:(NSString *)imgName;

/**
 *  通过UIColor创建一张图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

- (UIImage *)fixOrientation;

@end

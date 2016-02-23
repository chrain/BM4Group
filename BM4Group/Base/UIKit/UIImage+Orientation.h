//
//  UIImage+BM.h
//  BM4Group
//
//  Created by Chrain on 15/5/25.
//  Copyright (c) 2015年 蓝色互动. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImage (Orientation)

/**
 *  默认相机拍摄的图片为顺时针转90°，此方法调整类似此类情况图片的方向。
 *
 *  @return 返回调整后的图片
 */
- (UIImage *)fixOrientation;

@end

//
//  BMGlobalMacro.h
//  BM4Group
//
//  Created by 陈宇 on 15/4/26.
//  Copyright (c) 2015年 蓝色互动. All rights reserved.
//

#ifndef BM4Group_BMGlobalMacro_h
#define BM4Group_BMGlobalMacro_h

//日志控制
#ifdef DEBUG
#define BMLog(format, ...) NSLog(@"DEBUG MESSAGE:\n%s第%d行：" format, __func__, __LINE__, ##__VA_ARGS__)
#else
#define BMLog(...)
#endif

#define weakSelf(self)  __weak typeof(self)weakSelf = self

//window
#define kWindow            [UIApplication sharedApplication].keyWindow

//屏幕宽高
#define kScreenHeight MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#define kScreenWidth MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

//定义颜色
#define BMColorFromRGB(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]
#define BMColor(r,g,b,a)     [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:a]
#define BMRandomColor      BMColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), 1.f)

#endif
//
//  BMGlobalMacro.h
//  BM4Group
//
//  Created by 陈宇 on 15/4/26.
//  Copyright (c) 2015年 蓝色互动. All rights reserved.
//

#ifndef BM4GroupMacro_h
#define BM4GroupMacro_h

///------
/// NSLog
///------

#ifdef DEBUG
#define BMLog(...) NSLog(__VA_ARGS__)
#else
#define BMNSLog(...) {}
#endif

///----------------------
/// ErrorLog
///----------------------
#define BMError(error) NSLog(@"Error: %@", error)

///------
/// Color
///------
#define kRGB(r, g, b) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define kRGBAlpha(r, g, b, a) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]
#define kHexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define kHexRGBAlpha(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]
#define kRandomColor      kRGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

///---------
/// App Info
///---------
#define APP_NAME    ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"])
#define APP_VERSION ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])
#define APP_BUILD   ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])

///----------------------
/// Persistence Directory
///----------------------
#define kDOCUMENT_DIRECTORY NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject

#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define kWindow [UIApplication sharedApplication].keyWindow

#define kScaleWidth(iphone6Width) [[UIScreen mainScreen] bounds].size.width / 375.f * iphone6Width
#define kScaleHeight(iphone6Height) [[UIScreen mainScreen] bounds].size.height / 667.f * iphone6Height

#define kScreenWidth  ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

#define k1PX_WIDTH (1 / [UIScreen mainScreen].scale)

#ifndef __IPHONE_9_0
#define _Nonnull
#endif

#endif
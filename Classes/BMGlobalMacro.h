//
//  BMGlobalMacro.h
//  BM4Group
//
//  Created by 陈宇 on 15/4/26.
//  Copyright (c) 2015年 蓝色互动. All rights reserved.
//

#ifndef BM4Group_BMGlobalMacro_h
#define BM4Group_BMGlobalMacro_h

///------
/// NSLog
///------

#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif

///------
/// Block
///------

typedef void (^VoidBlock)();
typedef BOOL (^BoolBlock)();
typedef int  (^IntBlock) ();
typedef id   (^IDBlock)  ();

typedef void (^VoidBlock_int)(int);
typedef BOOL (^BoolBlock_int)(int);
typedef int  (^IntBlock_int) (int);
typedef id   (^IDBlock_int)  (int);

typedef void (^VoidBlock_string)(NSString *);
typedef BOOL (^BoolBlock_string)(NSString *);
typedef int  (^IntBlock_string) (NSString *);
typedef id   (^IDBlock_string)  (NSString *);

typedef void (^VoidBlock_id)(id);
typedef BOOL (^BoolBlock_id)(id);
typedef int  (^IntBlock_id) (id);
typedef id   (^IDBlock_id)  (id);

///------
/// Color
///------

#define RGB(r, g, b) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define RGBAlpha(r, g, b, a) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]
#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define HexRGBAlpha(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]
#define RandomColor      BMColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), 1.f)

#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

///---------
/// App Info
///---------
#define APP_NAME    ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"])
#define APP_VERSION ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])
#define APP_BUILD   ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])

#define SharedAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define weakSelf(self)  __weak typeof(self)weakSelf = self

#endif
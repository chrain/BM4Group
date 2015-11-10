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

typedef void (^voidBlock)();
typedef BOOL (^boolBlock)();
typedef int  (^intBlock) ();
typedef id   (^idBlock)  ();

typedef void (^voidBlock_int)(int);
typedef BOOL (^boolBlock_int)(int);
typedef int  (^intBlock_int) (int);
typedef id   (^idBlock_int)  (int);

typedef void (^voidBlock_string)(NSString *);
typedef BOOL (^boolBlock_string)(NSString *);
typedef int  (^intBlock_string) (NSString *);
typedef id   (^idBlock_string)  (NSString *);

typedef void (^voidBlock_id)(id);
typedef BOOL (^boolBlock_id)(id);
typedef int  (^intBlock_id) (id);
typedef id   (^idBlock_id)  (id);

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

#define kWindow [UIApplication sharedApplication].keyWindow

// Details about the choice of backing keyword:
//
// The use of @try/@catch/@finally can cause the compiler to suppress
// return-type warnings.
// The use of @autoreleasepool {} is not optimized away by the compiler,
// resulting in superfluous creation of autorelease pools.
//
// Since neither option is perfect, and with no other alternatives, the
// compromise is to use @autorelease in DEBUG builds to maintain compiler
// analysis, and to use @try/@catch otherwise to avoid insertion of unnecessary
// autorelease pools.
#if DEBUG
#define rac_keywordify autoreleasepool {}
#else
#define rac_keywordify try {} @catch (...) {}
#endif

#define weakify(object) rac_keywordify __weak __typeof__(object) object##_##weak = object

#define strongify(object) rac_keywordify __strong __typeof__(object) object = object##_##weak

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - 568.f ) < DBL_EPSILON )

#define kScaleWidth(iphone6Width) [[UIScreen mainScreen] bounds].size.width / 375.f * iphone6Width

#define kScaleHeight(iphone6Height) [[UIScreen mainScreen] bounds].size.height / 667.f * iphone6Height

#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define kSCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define kSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#ifndef __IPHONE_9_0
#define _Nonnull
#endif

#endif
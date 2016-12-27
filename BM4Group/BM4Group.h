//
//  BM4Group.h
//  BM4Group
//
//  Created by 陈宇 on 15/12/19.
//  Copyright © 2015年 陈宇. All rights reserved.
//

#import <UIKit/UIKit.h>

#if __has_include(<BM4Group/BM4Group.h>)

//! Project version number for BM4Group.
FOUNDATION_EXPORT double BM4GroupVersionNumber;

//! Project version string for BM4Group.
FOUNDATION_EXPORT const unsigned char BM4GroupVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <BM4Group/PublicHeader.h>

#import <BM4Group/BM4GroupMacro.h>

#import <BM4Group/NSNull+Exist.h>
#import <BM4Group/NSString+Exist.h>

#import <BM4Group/BMDashLine.h>
#import <BM4Group/BMSpinnerView.h>
#import <BM4Group/BMUnderLineView.h>
#import <BM4Group/BMEnableIQKeyboardView.h>
#import <BM4Group/UIImage+Orientation.h>
#import <BM4Group/UIView+AutoLayoutDebugging.h>
#import <BM4Group/UIViewController+Alert.h>
#import <BM4Group/UIViewController+Message.h>

#import <BM4Group/BMBaseModel.h>
#import <BM4Group/BMPage.h>

#import <BM4Group/BMToast.h>
#import <BM4Group/HttpClient.h>
#import <BM4Group/AccountHelper.h>

#import <BM4Group/BMUtils.h>
#import <BM4Group/BMMediator.h>
#import <BM4Group/StoreUtility.h>

#else

#import "BM4GroupMacro.h"

#import "NSNull+Exist.h"
#import "NSString+Exist.h"

#import "BMDashLine.h"
#import "BMSpinnerView.h"
#import "BMUnderLineView.h"
#import "BMEnableIQKeyboardView.h"
#import "UIImage+Orientation.h"
#import "UIView+AutoLayoutDebugging.h"
#import "UIViewController+Alert.h"
#import "UIViewController+Message.h"

#import "BMBaseModel.h"
#import "BMPage.h"

#import "BMToast.h"
#import "HttpClient.h"
#import "AccountHelper.h"

#import "BMUtils.h"
#import "BMMediator.h"
#import "StoreUtility.h"

#endif

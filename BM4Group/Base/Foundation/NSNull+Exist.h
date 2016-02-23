//
//  NSNull+Exist.h
//  BM4GroupExample
//
//  Created by 陈宇 on 15/12/15.
//  Copyright © 2015年 陈宇. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSNull (Exist)

/**
 *  服务器返回NSString为nil时，Cocoa默认为NSNull，so取NSString同名方法.
 *
 *  @return 永远返回NO
 */
- (BOOL)isExist;

@end

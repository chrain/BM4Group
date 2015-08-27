//
//  NSString+BM.h
//  BM4Group
//
//  Created by Chrain on 15/5/25.
//  Copyright (c) 2015年 蓝色互动. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BM)

/**
 *  转换字符串成拼音
 *  不支持多音字
 *  @return 返回字符串对应的拼音
 */
- (NSString *)transformToPinyin;

/**
 *  是否为中文
 *
 */
-(BOOL)isChinese;

@end

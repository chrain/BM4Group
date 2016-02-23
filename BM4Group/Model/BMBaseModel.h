//
//  BMBaseModel.h
//  BM4Group
//
//  Created by Chrain on 15/5/25.
//  Copyright (c) 2015年 蓝色互动. All rights reserved.
//

#if __has_include(<MJExtension/MJExtension.h>)
#import <MJExtension/MJExtension.h>
#else
#import <Foundation/Foundation.h>
#endif

/**
 *  所有模型的基类,提供默认的三个基本属性。
 */
@interface BMBaseModel : NSObject {
    uint64_t _objectID;
    NSString *_name;
    BOOL _selected;
}

@property (nonatomic, assign) uint64_t objectID; ///<模型对应的id

@property (nonatomic, copy) NSString *name; ///<模型对应的name

@property (nonatomic, assign) BOOL selected; ///<模型对应的选择状态。Tips:多用于本地选中删除。

@end

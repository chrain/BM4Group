//
//  BMResponse.h
//  ProjectStructure
//
//  Created by 陈宇 on 15/12/1.
//
//

#import "BMBaseModel.h"
#import "BMPage.h"


@interface BMResponse < T : BMBaseModel * > : BMBaseModel

/**
 *  0为成功；其他均为失败
 */
@property(nonatomic, assign) NSInteger status;

/**
 *  提示信息
 */
@property (nonatomic, copy) NSString *msg;

/**
 *  单个实体或实体的集合(可选)
 */
@property (nonatomic, strong) T result;

@property (nonatomic, strong) BMPage *page;
/**
 *  result的原始json类型
 */
@property (nonatomic, strong) id rawResult;

/**
 *  服务器的result是否是个空的.
 */
@property (nonatomic, assign, getter=isEmptyResult) BOOL emptyResult;

/**
 *  数据是否来自缓存
 */
@property (nonatomic, assign) BOOL fromCache;

@property (nonatomic, strong) NSError *error;

@end

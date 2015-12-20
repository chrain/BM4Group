//
//  BMRequest.h
//  ProjectStructure
//
//  Created by 陈宇 on 15/12/1.
//
//

#import "BMBaseModel.h"

@protocol AFMultipartFormData;

typedef void(^AFConstructingBlock)(id<AFMultipartFormData>);

@interface BMRequest : BMBaseModel

/**
 *  接口路径,不要以/开头
 */
@property(nonatomic, copy) NSString *path;

/**
 *  是否忽略缓存,直接请求新数据。
 */
@property(nonatomic, assign) BOOL ignoreCache;

/**
 *  参数
 */
@property(nonatomic, strong) id params;

/**
 *  文件上传的block
 */
@property (nonatomic, copy) AFConstructingBlock constrauctingBlock;

/**
 *  是否从缓存获取
 */
@property(nonatomic, assign) BOOL cache;

/**
 *  服务器返回内容包装key
 *  @see requestWithPath: contentKey:
 */
@property(nonatomic, copy, readonly) NSString *contentKey;

/**
 *  服务器返回的结果直接在result里
 *
 *  @param path 接口路径
 *
 *  @return 返回该请求对象
 */
+ (instancetype)requestWithPath:(NSString *)path;

/**
 *  服务器返回的结果包装了一层
 *
 *  @param path 接口路径
 *  @param key  result内部包装的key
 *
 *  @return 返回该请求对象
 */
+ (instancetype)requestWithPath:(NSString *)path contentKey:(NSString *)key;

@end

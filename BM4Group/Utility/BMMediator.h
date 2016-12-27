//
//  BMMediator.h
//  BM4GroupExample
//
//  Created by 陈宇 on 2016/12/27.
//  Copyright © 2016年 陈宇. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 模块化中间件
 模块名字:Target_[Example],调用名为[Example],可以使用setTargetPrefix定制化。
 方法名字:action_[Example],调用名为[Example],可以使用setActionPrefix定制化。
 */
@interface BMMediator : NSObject

+ (instancetype)sharedInstance;

+ (void)setTargetPrefix:(NSString *)targetPrefix;
+ (void)setActionPrefix:(NSString *)actionPrefix;

// 远程App调用入口
- (id)performActionWithUrl:(NSURL *)url completion:(void(^)(NSDictionary *info))completion;
// 本地组件调用入口
- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget;
- (void)releaseCachedTargetWithTargetName:(NSString *)targetName;

@end

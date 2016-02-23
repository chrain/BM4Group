//
//  BMResponse.m
//  ProjectStructure
//
//  Created by 陈宇 on 15/12/1.
//
//

#import "BMResponse.h"


@implementation BMResponse

+ (NSArray *)ignoredPropertyNames
{
    return @[ @"result", @"rawResult" ];
}

- (instancetype)init
{
    if (self = [super init]) {
        _status = -1;
    }
    return self;
}

@end

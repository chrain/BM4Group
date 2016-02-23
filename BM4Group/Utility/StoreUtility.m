//
//  StoreUtility.m
//  ProjectStructure
//
//  Created by 陈宇 on 15/12/5.
//
//

#import "StoreUtility.h"
#import "NSString+Exist.h"
#import "AccountHelper.h"
#import "BM4GroupMacro.h"


@implementation StoreUtility

+ (BOOL)storeToUserDirectory:(id)data key:(NSString *)key
{
    NSParameterAssert(data && [data conformsToProtocol:@protocol(NSCoding)]);
    NSParameterAssert([key isExist]);

    return [NSKeyedArchiver archiveRootObject:data toFile:[self userPathByKey:key]];
}

+ (id)fetchByUserDirectory:(NSString *)key
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self userPathByKey:key]];
}

+ (BOOL)deleteUserPathByKey:(NSString *)key
{
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:[self userPathByKey:key]]) {
        return [fm removeItemAtPath:[self rootPathByKey:key] error:nil];
    } else {
        return NO;
    }
}

+ (BOOL)storeToRootDirectory:(id)data key:(NSString *)key
{
    NSParameterAssert(data && [data conformsToProtocol:@protocol(NSCoding)]);
    NSParameterAssert([key isExist]);

    return [NSKeyedArchiver archiveRootObject:data toFile:[self rootPathByKey:key]];
}

+ (id)fetchByRootDirectory:(NSString *)key
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self rootPathByKey:key]];
}

+ (BOOL)deleteRootPatByKey:(NSString *)key
{
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:[self rootPathByKey:key]]) {
        return [fm removeItemAtPath:[self rootPathByKey:key] error:nil];
    } else {
        return NO;
    }
}

#pragma mark - Private Method

+ (NSString *)userPathByKey:(NSString *)key
{
    return [[self storeUserDirectory] stringByAppendingPathComponent:key];
}

+ (NSString *)rootPathByKey:(NSString *)key
{
    return [[self storeRootDirectory] stringByAppendingPathComponent:key];
}

+ (NSString *)storeUserDirectory
{
    NSString *path = [NSString stringWithFormat:@"%@/store/%@", kDOCUMENT_DIRECTORY, [AccountHelper sharedInstance].user.name];

    BOOL isDirectory;
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];
    if (!isExist || !isDirectory) {
        NSError *error = nil;
        BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (success) {
            [self addSkipBackupAttributeToItemAtPath:path];
        } else {
            BMError(@"%@", error);
        }
    }
    return path;
}

+ (NSString *)storeRootDirectory
{
    NSString *path = [NSString stringWithFormat:@"%@/store", kDOCUMENT_DIRECTORY];

    BOOL isDirectory;
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];
    if (!isExist || !isDirectory) {
        NSError *error = nil;
        BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (success) {
            [self addSkipBackupAttributeToItemAtPath:path];
        } else {
            BMError(@"%@", error);
        }
    }
    return path;
}

/// 让此目录不被iCloud备份
+ (BOOL)addSkipBackupAttributeToItemAtPath:(NSString *)filePathString
{
    NSURL *URL = [NSURL fileURLWithPath:filePathString];

    assert([[NSFileManager defaultManager] fileExistsAtPath:URL.path]);

    NSError *error = nil;
    BOOL success = [URL setResourceValue:@(YES) forKey:NSURLIsExcludedFromBackupKey error:&error];
    if (error) BMError(@"%@", error);

    return success;
}

@end

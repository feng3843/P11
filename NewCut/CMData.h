//
//  CMData.h
//  NewCut
//
//  Created by py on 15-7-18.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PYUserData.h"
#import "AppDelegate.h"

@interface CMData : NSObject
#pragma mark DATABASE_TOOL
//DEFAULT @"0"
+ (NSString*) getStringInDefByKey:(NSString*)key;

+ (NSString*) getStringInDefByKey:(NSString*)key Default:(NSString*) strDefault;

// 查询登录返回的token

+(void)setToken:(NSString*)token;
+(void)setVersion:(NSString*)Version;
+(void)setUserId:(NSString *)userId;
+(void)setUserName:(NSString *)name;
+(void)setPassword:(NSString *)password;

+(void)setLoginType:(BOOL )type;
+(BOOL)getLoginType;

+(NSString*) getToken;
+(NSString*) getVersion;
+(NSString*) getUserName;
+(NSString*) getUserId;
+(NSString*)getPassword;


@end

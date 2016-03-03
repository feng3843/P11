//
//  CMData.m
//  NewCut
//
//  Created by py on 15-7-18.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "CMData.h"
#import "NSDate+Extensions.h"
#import "NSDate+Extensions.h"

#define USER_KEY_ID @"id"
#define USER_KEY_NAME @"name"
#define USER_KEY_TEL @"tel"
#define USER_KEY_USERIMAGE @"userImage"
#define USER_KEY_TOKEN @"token"
#define USER_KEY_PWD @"pwd"
#define USER_KEY_ICKNAME @"ickname"
#define USER_KEY_OTHERLOGIN @"otherLogin"
//#define USER_KEY_JOB @"job"
//#define USER_KEY_EMAIL @"email"
//#define USER_KEY_COMPANY_ID @"tradecode"
//#define USER_KEY_COMPANY_NAME @"companyname"
//#define USER_KEY_AVATAR @"avatar"

//#define USER_KEY_STATUS @"username_status"
//#define USER_KEY_CREATEDATE @"createdate"
//#define USER_KEY_BGCOVER @"bgcover"
//#define USER_KEY_PACKAGE @"package"
//#define USER_KEY_VALID_TIME @"validtime"

@implementation CMData

+(NSString *) getStringInDefByKey:(NSString *)key
{
    
    return [self getStringInDefByKey:key Default:@"0"];
}

+ (NSString*) getStringInDefByKey:(NSString*)key Default:(NSString *)strDefault
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *result = [def valueForKey:key];
    
    if (!result) {
        result = strDefault;
    }
    return result;
}

+(void)setToken:(NSString*)token
{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults setValue:token forKey:USER_KEY_TOKEN];
}


+(void)setUserId:(NSString *)userId
{
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults setValue:userId forKey:USER_KEY_ID];
}

+(void)setUserName:(NSString *)name
{
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults setValue:name forKey:USER_KEY_NAME];
}


+(void)setPassword:(NSString *)password{
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults setValue:password forKey:USER_KEY_PWD];
    
}


+(void)setVersion:(NSString *)Version{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    //    [userDefaults setValue:Version forKey:@"version"];
    //后台的版本是给安卓使用的，iOS直接取pinfo.list里的配置
    [userDefaults setValue:[NSString stringWithFormat:@"v%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]] forKey:@"version"];
}



+(void)setLoginType:(BOOL )type{
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults setBool:type forKey:USER_KEY_OTHERLOGIN];
    
}
+(BOOL)getLoginType{
    
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSLog(@"xxxxxxx%@",[userDefaults valueForKey:USER_KEY_OTHERLOGIN]);
   return [[userDefaults valueForKey:USER_KEY_OTHERLOGIN] isEqualToNumber:@(1)];
 
}
+(NSString *)getVersion{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //读取
    NSString *str=
    //(NSString *)[defaults objectForKey:@"version"];
    [NSString stringWithFormat:@"v%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    return str;
    
}

+(NSString*) getToken
{
    return [self getStringInDefByKey:USER_KEY_TOKEN Default:@""];
}
+(NSString*) getUserName
{
    return [self getStringInDefByKey:USER_KEY_NAME Default:@""];
}
+(NSString*) getUserId
{
    return [self getStringInDefByKey:USER_KEY_ID Default:@""];
}
+(NSString*)getPassword{
   return [self getStringInDefByKey:USER_KEY_PWD Default:@""];
    
}

@end

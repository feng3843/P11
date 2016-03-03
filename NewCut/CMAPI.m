//
//  CMAPI.m
//  NewCut
//
//  Created by py on 15-7-18.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "CMAPI.h"
#import "AFNetworking.h"
#import "AFURLRequestSerialization.h"
#import "HttpRequest.h"
#import "CMData.h"
#import "CMTool.h"
#import "SVProgressHUD.h"
#import "CMDefault.h"

//项目根路径
#ifdef DEBUG
////
 NSString *const CMAPIBaseURL=@"http://139.196.16.137:8080/app/";
//NSString *const CMAPIBaseURL=@"http://172.21.1.168:8081/app/";
//NSString *const CMAPIBaseURL=@"http://172.21.1.28:3306/app/";
//
//NSString *const CMAPIBaseURL=@"http://58.240.32.170:7077/app/";
//NSString *const CMAPIBaseURL=@"http://58.240.32.172/";
//NSString *const CMAPIBaseURL=@"http://58.240.32.172/";
//NSString *const CMAPIBaseURL=@"http://58.240.32.172/tongye/";
//NSString *const CMAPIBaseURL=@"http://172.21.1.28:8898/tongye/";
#else
//NSString *const CMAPIBaseURL=@"http://guanwu.puyuntech.com/yht_api/";
NSString *const CMAPIBaseURL=@"http://139.196.16.137:8080/app/";
#endif

//图片根路径
#ifdef DEBUG
//NSString *const CMRES_BaseURL = @"http://58.240.32.170:7077/res/assets/img/topic/";
NSString *const CMRES_BaseURL = @"http://139.196.16.137:8080/res/assets/img/topic/";
#else
//NSString *const CMRES_BaseURL = @"http://58.240.32.170:7077/res/assets/img/topic/";
NSString *const CMRES_BaseURL = @"http://139.196.16.137:8080/res/assets/img/topic/";
#endif

#ifdef DEBUG
//NSString *const CMRES_ImageURL = @"http://58.240.32.170:7077/res/assets/img/party/";
//NSString *const CMRES_ImageURL = @"http://58.240.32.170:7077/res/assets/img/topic/";
NSString *const CMRES_ImageURL = @"http://139.196.16.137:8080/res/assets/img/topic/";
#else
//NSString *const CMRES_ImageURL = @"http://58.240.32.170:7077/res/assets/img/party/";
//NSString *const CMRES_ImageURL = @"http://58.240.32.170:7077/res/assets/img/topic/";
NSString *const CMRES_ImageURL = @"http://139.196.16.137:8080/res/assets/img/topic/";
#endif

#ifdef DEBUG

//NSString *const CMRES_AVATAR_URL = @"http://58.240.32.170:7077/res/assets/img/topic/";
//NSString *const CMRES_AVATAR_URL = @"http://58.240.32.170:7077/res/assets/avatar";
NSString *const CMRES_AVATAR_URL = @"http://139.196.16.137:8080/res/assets/img/topic/";

#else
NSString *const CMRES_AVATAR_URL = @"http://139.196.16.137:8080/res/assets/img/topic/";
//NSString *const CMRES_AVATAR_URL = @"http://58.240.32.170:7077/res/assets/avatar";
#endif


#define CHECK_WEB

@implementation PYResult
@end

@implementation PYResultSET

- (instancetype)initWithKey:(NSString*)key Type:(PYResultType) type
{
    PYResultSET *setting = [super init];
    [setting setKey:key];
    [setting setType:type];
    return setting;
}

@end

@implementation PyResetValueKey

-(instancetype)initNewkey:(NSString *)newkey OldKey:(NSString *)oldkey
{
    PyResetValueKey *setting=[super init];
    [setting setMynewKey:newkey];
    [setting setOldKey:oldkey];
    return setting;
}

@end

@implementation CMAPI

+(void)checkWeb:(void (^)())end
{
    BOOL result = [CMTool isConnectionAvailable];
#if DEBUG
//    result = NO;
#endif
    if (!result) {
        [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
        return;
    }
    else
    {
        end();
    }
}

+(BOOL)checkWeb
{
    BOOL result = [CMTool isConnectionAvailable];
#if DEBUG
//    result = NO;
#endif
    if (!result) {
        [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
    }
    return result;
}

+(NSDictionary *)addMustParam:(NSDictionary *)param Url:(NSString *)url
{
    NSMutableDictionary* dictMutable = [param mutableCopy];
    if (![dictMutable objectForKey:@"token"]&&![url isEqualToString: API_USER_LOGIN]) {
        [dictMutable setObject:[CMData getToken] forKey:@"token"];
    }

    return [dictMutable copy];
}

+(NSDictionary*)beforeRequest:(NSString*)url Param:(NSDictionary*) param Settings:settings
{

    param = [self addMustParam:param Url:url];
    //显示联网标记
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    return param;

}

//统一处理方法 无返回结果 入口
+(PYResult*) error:(NSError*) error
{
    //隐藏联网标记
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    PYResult* result =[[PYResult alloc] init];
    NSMutableDictionary* dict=[[NSMutableDictionary alloc]init];
    [dict setValue:@"4000" forKey:@"code"];
    NSDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:error.localizedDescription forKey:@"reason"];
    [dict setValue:dic forKey:@"result"];
    [result setCode:[NSString stringWithFormat:@"%ld",(long)error.code]];//设置状态码
    [result setSucceed:NO];//设置成功标识
    [result setResult:dict];//设置返回结果
    return result;
}

//统一处理方法 有返回结果 入口
+ (PYResult*) result:(id)responseObject Settings:(NSArray*) settings
{
    PYResult* pyresult = [[PYResult alloc] init];
    BOOL succeed = NO;
    id code=[responseObject valueForKey:@"code"];
    
    
    NSString* strCode = [NSString stringWithFormat:@"%@",code];
    NSMutableDictionary *dict=nil;
    //    return nil;
    //判断
    if([strCode isEqualToString:@"200"])
    {
        succeed=YES;
        if (settings) {
            dict=[[NSMutableDictionary alloc]init];
            for(PyResetValueKey* setting in settings)
            {
                [dict setValue:[responseObject valueForKey:setting.oldKey] forKey:setting.mynewKey];
            }
        }
        else
        {
            dict = [responseObject copy];
        }
    }
    else
    {
        dict=[[NSMutableDictionary alloc]init];
        succeed=NO;
        
        NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
        [dic setValue: strCode forKey:@"code"];
        
        strCode = [NSString stringWithFormat:@"KEY%@",strCode];
        NSString* strReason = NSLocalizedString(strCode,strCode);
        if (!strReason||[@"" isEqualToString:strReason]) {
            strCode = @"KEY0000";
            strReason = NSLocalizedString(strCode,strCode);
        }
        
        [dic setValue:strReason forKey:@"reason"];
        
        [dict setValue:dic forKey:RESULT];
        
        //[SVProgressHUD showErrorWithStatus:strReason];
    }
    
    [pyresult setCode:strCode];//设置状态码
    [pyresult setSucceed:succeed];//设置成功标识
    [pyresult setResult:dict];//设置返回结果
    
    //隐藏联网标记
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    return pyresult;
    
}


//get方式请求
+(void)getUrl:(NSString *)url Param:(NSDictionary *)param Settings:(id)settings completion:(void (^)(BOOL, NSDictionary *, NSError *))completion
{
    
    param = [self beforeRequest:url Param:param Settings:settings];
    
    [self checkWeb:^{
        
        [HttpRequest get:[NSString stringWithFormat:@"%@%@",CMAPIBaseURL,url] params:param
                 success:^(id responseObject)
         {
             //DDLogVerbose(@"%@",responseObject);
             PYResult* result = [self result:responseObject Settings:settings];
             if (result)
             {
                 completion([result succeed],[result result],nil);
             }
             else
             {
                 completion(NO,nil,nil);
             }
         }
                 failure:^(NSError *error)
         {
             [self error:error];
             PYResult* result =[[PYResult alloc]init];
             
             NSMutableDictionary* dict=[[NSMutableDictionary alloc]init];
             [dict setValue:@"400*" forKey:@"code"];
             NSDictionary *dic=[[NSMutableDictionary alloc]init];
             [dic setValue:error.localizedDescription forKey:@"reason"];
             [dict setValue:dic forKey:@"result"];
             [result setCode:[NSString stringWithFormat:@"%ld",(long)error.code]];//设置状态码
             [result setSucceed:NO];//设置成功标识
             [result setResult:dict];//设置返回结果
             
             completion([result succeed],[result result],error);
         }];
    }];
}

//post请求
+(void)postUrl:(NSString *)url Param:(NSDictionary *)param Settings:(id)settings completion:(void (^)(BOOL, NSDictionary *, NSError *))completion
{
    param = [self beforeRequest:url Param:param Settings:settings];
    
    [self checkWeb:^{
        [HttpRequest post:[NSString stringWithFormat:@"%@%@",CMAPIBaseURL,url] params:param
                  success:^(id responseObject)
         {
             // DDLogVerbose(@"%@",responseObject);
             PYResult* result = [self result:responseObject Settings:settings];
             if (result)
             {
                 completion([result succeed],[result result],nil);
             }
             else
             {
                 completion(NO,nil,nil);
             }
         }
                  failure:^(NSError *error)
         {
             PYResult* result = [self error:error];
             
             completion([result succeed],[result result],error);
         }];
    }];
}

//上传图像
+ (void)uploadUrl:(NSString*) url Param:(NSDictionary*) param  Image:(NSString*)imageName  WithCompletion:(void (^)(BOOL succeed,NSDictionary* detailDict,NSError *error))completion
{
    
    param = [self beforeRequest:url Param:param Settings:nil];
    
    [self checkWeb:^{
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:CMAPIBaseURL]];
        [manager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            NSData *data = [NSData dataWithContentsOfFile:[NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@",imageName]]];
            [formData appendPartWithFileData:data name:@"myavatar.png" fileName:@"myavatar.png" mimeType:@"image/jpeg"];
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            // DDLogVerbose(@"%@",responseObject);
            PYResult* result = [self result:responseObject Settings:nil];
            if (result) {
                completion([result succeed],[result result],nil);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self error:error];
        }];
    }];
}

+(void)postUrl:(NSString *)url Param:(NSDictionary *)param Settings:(id)settings FileData:(NSData*)filedata OpName:(NSString*)opname FileName:(NSString*)filename FileType:(NSString*)filetype completion:(void (^)(BOOL succeed,NSDictionary* detailDict,NSError *error))completion
{
    if(!filedata)
    {
        return;
    }
    param = [self beforeRequest:url Param:param Settings:settings];
    
    [self checkWeb:^{
        [HttpRequest post:[NSString stringWithFormat:@"%@%@",CMAPIBaseURL,url] params:param FileData:filedata  OpName:@"req" FileName:filename FileType:filetype success:^(id responseObject)
         {
             //DDLogVerbose(@"%@",responseObject);
             PYResult* result = [self result:responseObject Settings:nil];
             if (result)
             {
                 completion([result succeed],[result result],nil);
             }
             else
             {
                 completion(NO,nil,nil);
             }
         }
                  failure:^(NSError *error)
         {
             [self error:error];
             completion(NO,nil,error.localizedDescription);
         }];
    }];
}

//批量上传图片
+(void)postUrl:(NSString*)url Param:(NSDictionary *)param ImageDatas:(NSArray*)imageDatas Settings:(id)settings completion:(void (^)(BOOL succeed, NSDictionary * detailDict, NSError * error))completion
{
    
    param = [self beforeRequest:url Param:param Settings:settings];

    [self checkWeb:^{
        [HttpRequest post:[NSString stringWithFormat:@"%@%@",CMAPIBaseURL,url] params:param ImageDatas:imageDatas Key:@"photo_list"
                  success:^(id responseObject){
                      //DDLogVerbose(@"%@",responseObject);
                      PYResult* result = [self result:responseObject Settings:nil];
                      if (result)
                      {
                          completion([result succeed],[result result],nil);
                      }
                      else
                      {
                          completion(NO,nil,nil);
                      }
                  } failure:^(NSError* error){
                      [self error:error];
                      completion(NO,nil,error.localizedDescription);
                  }];

    }];
}


@end

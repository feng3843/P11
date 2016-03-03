//
//  AppDelegate.m
//  NewCut
//
//  Created by py on 15-7-7.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "AppDelegate.h"
#import <SMS_SDK/SMS_SDK.h>

//mob短信
#define SMS_appKey @"991eb543c89c"
#define SMS_appSecret @"eab2bc4d8c3fc86a4bde5c802164117c"
#define SHARE_APP_KEY @"96e42e9f3748"

#import "PYUserData.h"
#import "CMTool.h"
#import "CMAPI.h"
#import "DataBaseTool.h"
#import "SVProgressHUD.h"
#import "CMData.h"
@interface AppDelegate () <WeiboSDKDelegate,QQApiInterfaceDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 启动图片
    
       //设置一个图片;
       CGRect frame = CGRectMake(0 ,0 ,320,0);
//       CGSize size = [UIImage imageNamed:@"Launch.gif"].size;
       frame.size = CGSizeMake(320 , 568 );
       // 读取gif图片数据
       NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"Launch" ofType:@"gif"]];
       // view生成
       UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
        webView.backgroundColor = [UIColor clearColor];
       webView.paginationMode = UIWebPaginationModeTopToBottom;
       webView.userInteractionEnabled = NO;//用户不可交互
       [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    [self.window makeKeyAndVisible];
   
       //添加到场景
    [UIView animateWithDuration:2.8 animations:^{
       
         [self.window addSubview:webView];
        //放到最顶层;
       [self.window bringSubviewToFront:webView];

//        NSDictionary *param = @{@"userName":[NSString stringWithFormat:@"TEL%@",[CMData getUserName]],
//                                @"pwd":[CMData getPassword],
//                                @"nickName":[DataBaseTool getNickName]
//                                };
//        [CMAPI postUrl:API_USER_LOGIN Param:nil Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
//            
//            id result = [detailDict objectForKey:@"code"];
//            if(succeed)
//            {
//                NSDictionary* result = [detailDict valueForKey:@"result"];
////                PYUserData *userData = [PYUserData objectWithKeyValues:[result objectForKey:@"user"]];
//                NSString *token = [result objectForKey:@"token"];
//               [CMData setToken: token];
//            
//     
//                        
//                    }];
        
        
//        NSString *username = [NSString stringWithFormat:@"TEL%@",[CMData getUserName]];
//        NSString  *pwd = [CMData getPassword];
//        NSString *nickName = [DataBaseTool getNickName];
      
        
    } completion:^(BOOL finished) {
        // 完成后执行code
        [webView removeFromSuperview];
    }];

    
    //初始化短信平台接口
    [SMS_SDK registerApp:SMS_appKey
              withSecret:SMS_appSecret];

    //分享
    
        [ShareSDK registerApp:SHARE_APP_KEY];
        
        //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台 （注意：2个方法只用写其中一个就可以）
        [ShareSDK  connectSinaWeiboWithAppKey:@"1982573800"
                                    appSecret:@"c583106bdfb52e94b96e54f26cf8a346"
                                  redirectUri:@"http://www.puyuninfo.com"
                                  weiboSDKCls:[WeiboSDK class]];
        //
   
        //添加QQ应用  注册网址  http://mobile.qq.com/api/
        [ShareSDK connectQQWithQZoneAppKey:@"1104797396"
                             qqApiInterfaceCls:[QQApiInterface class]
                               tencentOAuthCls:[TencentOAuth class]];
        _tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"1104797396" andDelegate:self];
        _tencentOAuth.redirectURI = @"https://itunes.apple.com/us/app/nowcut/id1027209866?l=zh&ls=1&mt=8";
        _permissions =  [NSArray arrayWithObjects:@"get_user_info", @"get_simple_userinfo", @"add_t", nil];
        
        //微信登陆的时候需要初始化
        [ShareSDK connectWeChatWithAppId:@"wxc20536fb6be19186"
                               appSecret:@"e09e8316b6405bd04741e6903f92255e"
                               wechatCls:[WXApi class]];
    
    

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    if (![[CMData getToken] isEqualToString:@""]) {
        NSDictionary *param = @{@"userName":[CMData getUserName],
                                @"pwd":[CMData getPassword],
                                @"nickName":[DataBaseTool getNickName]
                                };
        
        [CMAPI postUrl:API_USER_LOGIN Param:param Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
            //            id result = [detailDict objectForKey:@"code"];
            if(succeed)
            {
                NSDictionary* result = [detailDict valueForKey:@"result"];
                NSString *token = [result objectForKey:@"token"];
                [CMData setToken: token];
            }
            
        }];
        
    }

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark SHARE


- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self]||[QQApi handleOpenURL:url]||[TencentOAuth HandleOpenURL:url]||[QQApiInterface handleOpenURL:url delegate:self]||[WeiboSDK handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self]||[QQApi handleOpenURL:url]||[TencentOAuth HandleOpenURL:url]||[QQApiInterface handleOpenURL:url delegate:self]||[WeiboSDK handleOpenURL:url delegate:self];
}

#pragma mark WEIBO
/**
 收到一个来自微博客户端程序的请求
 
 收到微博的请求后，第三方应用应该按照请求类型进行处理，处理完后必须通过 [WeiboSDK sendResponse:] 将结果回传给微博
 @param request 具体的请求对象
 */
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
}

/**
 收到一个来自微博客户端程序的响应
 
 收到微博的响应后，第三方应用可以通过响应类型、响应的数据和 WBBaseResponse.userInfo 中的数据完成自己的功能
 @param response 具体的响应对象
 */
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
}

#pragma mark QQ
/**
 处理来至QQ的请求
 */
- (void)onReq:(QQBaseReq *)req
{
}

/**
 处理来至QQ的响应
 */
- (void)onResp:(QQBaseResp *)resp
{
}

/**
 处理QQ在线状态的回调
 */
- (void)isOnlineResponse:(NSDictionary *)response
{
}

- (void)tencentDidLogin
{
    
    if (_tencentOAuth.accessToken && 0 != [_tencentOAuth.accessToken length])
    {
        //  记录登录用户的OpenID、Token以及过期时间
        [_tencentOAuth getUserInfo];
    }
    else
    {
    }
}

-(void)tencentDidNotLogin:(BOOL)cancelled
{
    if (cancelled)
    {
    }
    else
    {
    }
}

-(void)tencentDidNotNetWork
{
}

- (void)tencentDidLogout
{
}

-(void)getUserInfoResponse:(APIResponse *)response
{
    PYUserData* uData;
    if (!uData) {
        uData = [[PYUserData alloc] init];
    }
    NSDictionary* userInfo = [response jsonResponse];
    uData.nickName = [userInfo objectForKey:@"nickname"];
    uData.name = [_tencentOAuth openId];
    uData.userImage = [userInfo objectForKey:@"figureurl_qq_2"];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"AUTO_LOGIN" object:uData];
}


#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "compuyun.NewCut" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"NewCut" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"NewCut.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end

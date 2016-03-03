//
//  PYAllCommon.h
//  CM
//
//  Created by 付晨鸣 on 15/2/2.
//  Copyright (c) 2015年 AventLabs. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>
#import "UIColor+Extensions.h"
#import "MD5.h"
#import "Masonry.h"

#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)
#define StatusBarHeight (IOS7==YES ? 0 : 20)
#define BackHeight      (IOS7==YES ? 0 : 15)

#define fNavBarHeigth (IOS7==YES ? 64 : 44)

#define fDeviceWidth ([UIScreen mainScreen].bounds.size.width)
#define fDeviceHeight ([UIScreen mainScreen].bounds.size.height-StatusBarHeight)
//#import "PYExtCommon.h"
//#import "PYViewControllerCommon.h"
//#import "PYViewCommon.h"
//#import "PYObjectCommon.h"
//#import "PYToolCommon.h"
#import "UIViewController+Puyun.h"
//
////添加公共类
//#import "AppDelegate.h"
//
#import "CMAPI.h"//请求
//#import "CMData.h"//本地数据操作
//#import "CMTool.h"//工具类
#import "CMDefault.h"//默认值
//#import "CMNotification.h"//通知KEY
//#import "PYColor.h"//颜色设定



//
//  DataBaseTool.h
//  NewCut
//
//  Created by 夏雪 on 15/7/23.
//  Copyright (c) 2015年 py. All rights reserved.
//   工具

#import <Foundation/Foundation.h>
#import "PYUserData.h"
#import "StarDetailModel.h"
#import "FilmDetailModel.h"
#import "GoodDetailModel.h"


@interface DataBaseTool : NSObject
+ (BOOL)addUserInfo:(PYUserData *)user;

/** 获得手机号*/
+ (NSString *)getUserPhone;

/** 修改手机号*/
+ (BOOL)updateUserPhone;

/** 修改昵称*/
+ (BOOL)updateNickName:(NSString *)nickName;

/** 获得昵称*/
+ (NSString *)getNickName;

/** 修改图像*/
+ (BOOL)updateuserImage:(NSString *)userImage;


/** 获得图像*/
+ (NSString *)getuserImage;


#pragma mark 收藏明星

/**
 *  收藏一个明星
 */
+ (BOOL)addCollectStart:(StarDetailModel *)start;
/**
 *  取消收藏一个明星
 */
+ (BOOL)removeCollectStart:(StarDetailModel *)start;
/**
 *  明星是否收藏
 */
+ (BOOL)isCollectedStart:(StarDetailModel *)start;
/**
 *   我收藏的明星
 */
+ (NSArray *)collectStarts:(int) page;


#pragma mark 收藏影视
/**
 *  收藏一个影视
 */
+ (BOOL)addCollectFilm:(FilmDetailModel *)film;
/**
 *  取消收藏一个影视
 */
+ (BOOL)removeCollectFilm:(FilmDetailModel *)film;
/**
 *  明星是否影视
 */
+ (BOOL)isCollectedFilm:(FilmDetailModel *)film;
/**
 *  我收藏的明星影视
 */
+ (NSArray *)collectFilms:(int) page;


#pragma mark 收藏商品
/**
 *  收藏一个商品
 */
+ (BOOL)addCollectGood:(GoodDetailModel *)good;
/**
 *  取消收藏一个商品
 */
+ (BOOL)removeCollectGood:(GoodDetailModel *)good;
/**
 *  商品是否收藏
 */
+ (BOOL)isCollectedGood:(GoodDetailModel *)good;

/**
 *  我收藏的商品
 */
+ (NSArray *)collectGoods:(int) page;




#pragma mark 收藏图片
/**
 *  收藏一个图片
 */
+ (BOOL)addCollectImage:(NSString *)Image;
/**
 *  取消收藏一个图片
 */
+ (BOOL)removeCollectImage:(NSString *)Image;
/**
 *  图片是否收藏
 */
+ (BOOL)isCollectedImage:(NSString *)Image;
/**
 *  我收藏的图片
 */
+ (NSArray *)collectImages:(int) page;


#pragma mark 点赞
/**
 *  点赞 KEY ,agreeId text not NULL,type text not NULL,userId text not null )"];
 */
+ (BOOL)addCollectAgree:(NSString *)agreeId:(NSString *)type;
/**
 *  取消点赞
 */
+ (BOOL)removeCollectAgree:(NSString *)agreeId:(NSString *)type;
/**
 *  是否赞
 */
+ (BOOL)isCollectAgree:(NSString *)agreeId:(NSString *)type;


/**
 * 踩
 */
+ (BOOL)addCollectStep:(NSString *)stepId;
/**
 *  取消踩
 */
+ (BOOL)removeCollectStep:(NSString *)stepId;
/**
 *  是否踩
 */
+ (BOOL)isCollectStep:(NSString *)stepId;
@end

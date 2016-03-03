//
//  DataBaseTool.m
//  NewCut
//
//  Created by 夏雪 on 15/7/23.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "DataBaseTool.h"
#import "FMDB.h"
#import "PYUserData.h"
#import "CMData.h"
#import "CMAPI.h"

@implementation DataBaseTool

static FMDatabase *_db;
+ (void)initialize
{
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"newcut.sqlite"];
        NSLog(@"%@",file);
    _db = [FMDatabase databaseWithPath:file];
    if (!_db.open)  return;
    // 创建表
    // 用户表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_user_info(id integer PRIMARY KEY ,userId text not null ,tel text ,name text,userImage text ,nickName text )"];
    // 明星表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_collect_start(id integer PRIMARY KEY ,start blob not null ,start_id text not NULL,userId text not null )"];
    // 电影表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_collect_film(id integer PRIMARY KEY ,film blob not null ,film_id text not NULL,userId text not null )"];
    // 商品表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_collect_good(id integer PRIMARY KEY ,good blob not null ,good_id text not NULL,userId text not null )"];
    // 图片表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_collect_image(id integer PRIMARY KEY ,image text not NULL,userId text not null )"];
    // 点赞  type: 电影 1,商品 2,评论 3
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS  t_agree(id integer PRIMARY KEY ,agreeId text not NULL,type text not NULL,userId text not null )"];
    // 踩
     [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS  t_step(id integer PRIMARY KEY ,stepId text not NULL,userId text not null )"];
}


/** 本地数据库里面没有就新增*/
+ (BOOL)addUserInfo:(PYUserData *)user{
    
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT count(*) AS user_count FROM t_user_info WHERE userId = %@;",user.userId];
    [set next];
// 有记录就更新
    if ([set intForColumn:@"user_count"] == 1) {
          return [_db executeUpdateWithFormat:@"UPDATE t_user_info SET userId = %@ ,tel = %@, name = %@, userImage = %@,nickName = %@ where userId = %@",user.userId,user.tel, user.name ,user.userImage,user.nickName,user.userId];;
    }
    return  [_db executeUpdateWithFormat:@"INSERT INTO t_user_info(userId,tel, name,userImage,nickName) VALUES(%@,%@,%@,%@,%@);",user.userId,user.tel,user.name,user.userImage,user.nickName];
}

/** 获得手机号*/
+ (NSString *)getUserPhone
{
    
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT name  FROM t_user_info WHERE userId = %@;", [CMData getUserId]];
    [set next];
    return [set stringForColumn:@"name"];
}
/** 修改手机号*/
+ (BOOL)updateUserPhone
{
    return [_db executeUpdateWithFormat:@"UPDATE t_user_info SET name = %@ ,tel = %@ WHERE userId = %@;",[CMData getUserName],[CMData getUserName],[CMData getUserId]];
}
/** 修改昵称*/
+ (BOOL)updateNickName:(NSString *)nickName
{
    return [_db executeUpdateWithFormat:@"UPDATE t_user_info SET nickName = %@ WHERE userId = %@;",nickName,[CMData getUserId]];
}

/** 获得昵称*/
+ (NSString *)getNickName
{
    
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT nickName FROM t_user_info WHERE userId = %@;",[CMData getUserId]];
    if (set.next) {
            return [set stringForColumn:@"nickName"];
    }
    return @"";

}

/** 修改图像*/
+ (BOOL)updateuserImage:(NSString *)userImage
{
    return [_db executeUpdateWithFormat:@"UPDATE t_user_info SET userImage = %@ WHERE userId = %@;",userImage,[CMData getUserId]];
}


/** 获得昵称*/
+ (NSString *)getuserImage
{
    
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT userImage FROM t_user_info WHERE userId = %@;",[CMData getUserId]];
    if (set.next) {
        return [set stringForColumn:@"userImage"];
    }
    return @"";
    
}



#pragma mark 收藏明星
/**
 *  收藏一个明星
 */
+ (BOOL)addCollectStart:(StarDetailModel *)start
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:start];
    return  [_db executeUpdateWithFormat:@"INSERT INTO t_collect_start(start ,start_id,userId ) VALUES(%@,%@,%@);",data,start.starId,[CMData getUserId]];
}
/**
 *  取消收藏一个明星
 */
+ (BOOL)removeCollectStart:(StarDetailModel *)start
{
    return  [_db executeUpdateWithFormat:@"DELETE FROM t_collect_start WHERE start_id = %@ and userId = %@;", start.starId,[CMData getUserId]];

}
/**
 *  明星是否收藏
 */
+ (BOOL)isCollectedStart:(StarDetailModel *)start
{
    
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT count(*) AS start_count FROM t_collect_start WHERE start_id = %@ and userId = %@;", start.starId,[CMData getUserId]];
    [set next];
    return [set intForColumn:@"start_count"] == 1;
}
/**
 *  我收藏的明星数据
 */
+ (NSArray *)collectStarts:(int) page
{
    int size = 5;
    int pos = (page - 1) * size;
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT * from t_collect_start where userId = %@ ORDER BY id DESC LIMIT %d,%d;",[CMData getUserId],pos , size];
    NSMutableArray *array = [NSMutableArray array];
    while (set.next) {
     
      StarDetailModel *start = [NSKeyedUnarchiver unarchiveObjectWithData:[set objectForColumnName:@"start"]];
        [array addObject:start];
    }
    return array;
}

#pragma mark 收藏影视
/**
 *  收藏一个影视
 */
+ (BOOL)addCollectFilm:(FilmDetailModel *)film
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:film];
    return  [_db executeUpdateWithFormat:@"INSERT INTO t_collect_film(film ,film_id,userId ) VALUES(%@,%@,%@);",data,film.movieId,[CMData getUserId]];
}
/**
 *  取消收藏一个影视
 */
+ (BOOL)removeCollectFilm:(FilmDetailModel *)film
{
    return  [_db executeUpdateWithFormat:@"DELETE FROM t_collect_film WHERE film_id = %@ and userId = %@;", film.movieId,[CMData getUserId]];
    
}
/**
 *  明星是否影视
 */
+ (BOOL)isCollectedFilm:(FilmDetailModel *)film
{
    
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT count(*) AS film_count FROM t_collect_film WHERE film_id = %@ and userId = %@;", film.movieId,[CMData getUserId]];
    [set next];
    return [set intForColumn:@"film_count"] == 1;
}
/**
 *  我收藏的明星影视
 */
+ (NSArray *)collectFilms:(int) page
{
    int size = 5;
    int pos = (page - 1) * size;
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT * from t_collect_film where userId = %@ ORDER BY id DESC LIMIT %d,%d;",[CMData getUserId],pos , size];
    NSMutableArray *array = [NSMutableArray array];
    while (set.next) {
        
        StarDetailModel *start = [NSKeyedUnarchiver unarchiveObjectWithData:[set objectForColumnName:@"film"]];
        [array addObject:start];
    }
    return array;
}

#pragma mark 收藏商品
/**
 *  收藏一个商品
 */
+ (BOOL)addCollectGood:(GoodDetailModel *)good
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:good];
    return  [_db executeUpdateWithFormat:@"INSERT INTO t_collect_good(good ,good_id,userId ) VALUES(%@,%@,%@);",data,good.goodId,[CMData getUserId]];
}
/**
 *  取消收藏一个商品
 */
+ (BOOL)removeCollectGood:(GoodDetailModel *)good
{
    return  [_db executeUpdateWithFormat:@"DELETE FROM t_collect_good WHERE good_id = %@ and userId = %@;", good.goodId,[CMData getUserId]];
    
}
/**
 *  商品是否收藏
 */
+ (BOOL)isCollectedGood:(GoodDetailModel *)good
{
    
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT count(*) AS good_count FROM t_collect_good WHERE good_id = %@ and userId = %@;", good.goodId,[CMData getUserId]];
    [set next];
    return [set intForColumn:@"good_count"] == 1;
}
/**
 *  我收藏的商品
 */
+ (NSArray *)collectGoods:(int) page
{
    int size = 5;
    int pos = (page - 1) * size;
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT * from t_collect_good where userId = %@ ORDER BY id DESC LIMIT %d,%d;",[CMData getUserId],pos , size];
    NSMutableArray *array = [NSMutableArray array];
    while (set.next) {
        
        GoodDetailModel *good = [NSKeyedUnarchiver unarchiveObjectWithData:[set objectForColumnName:@"good"]];
        [array addObject:good];
    }
    return array;
}


#pragma mark 收藏图片
/**
 *  收藏一个图片
 */
+ (BOOL)addCollectImage:(NSString *)Image
{
    return  [_db executeUpdateWithFormat:@"INSERT INTO t_collect_image(image ,userId ) VALUES(%@,%@);",Image,[CMData getUserId]];
}
/**
 *  取消收藏一个图片
 */
+ (BOOL)removeCollectImage:(NSString *)Image
{
    return  [_db executeUpdateWithFormat:@"DELETE FROM t_collect_image WHERE image = %@ and userId = %@;", Image,[CMData getUserId]];
    
}
/**
 *  图片是否收藏
 */
+ (BOOL)isCollectedImage:(NSString *)Image
{
    
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT count(*) AS image_count FROM t_collect_image WHERE image = %@ and userId = %@;", Image,[CMData getUserId]];
    [set next];
    return [set intForColumn:@"image_count"] >= 1;
}
/**
 *  我收藏的图片
 */
+ (NSArray *)collectImages:(int) page
{
    int size = 20;
    int pos = (page - 1) * size;
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT * from t_collect_image where userId = %@ ORDER BY id DESC LIMIT %d,%d;",[CMData getUserId],pos , size];
    NSMutableArray *array = [NSMutableArray array];
    while (set.next) {
        
        [array addObject:[set objectForColumnName:@"image"]];
    }
    return array;
}

#pragma mark 点赞
/**
 *  点赞 KEY
 */
+ (BOOL)addCollectAgree:(NSString *)agreeId:(NSString *)type
{
    return  [_db executeUpdateWithFormat:@"INSERT INTO t_agree(agreeId ,type,userId ) VALUES(%@,%@,%@);",agreeId,type,[CMData getUserId]];
}
/**
 *  取消点赞
 */
+ (BOOL)removeCollectAgree:(NSString *)agreeId:(NSString *)type

{
    return  [_db executeUpdateWithFormat:@"DELETE FROM t_agree WHERE agreeId = %@ and type = %@ and userId = %@;", agreeId,type,[CMData getUserId]];
    
}
/**
 *  是否赞
 */
+ (BOOL)isCollectAgree:(NSString *)agreeId:(NSString *)type
{
    
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT count(*) AS agree_count FROM t_agree WHERE agreeId = %@ and type = %@ and userId = %@;", agreeId,type,[CMData getUserId]];
    [set next];
    return [set intForColumn:@"agree_count"] >= 1;
}
/**
 * 踩
 */
+ (BOOL)addCollectStep:(NSString *)stepId
{
    return  [_db executeUpdateWithFormat:@"INSERT INTO t_step(stepId ,userId ) VALUES(%@,%@);",stepId,[CMData getUserId]];
}
/**
 *  取消踩
 */
+ (BOOL)removeCollectStep:(NSString *)stepId

{
    return  [_db executeUpdateWithFormat:@"DELETE FROM t_step WHERE stepId = %@  and userId = %@;", stepId,[CMData getUserId]];
    
}

/**
 *  是否踩
 */
+ (BOOL)isCollectStep:(NSString *)stepId
{
    
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT count(*) AS step_count FROM t_step WHERE stepId = %@ and userId = %@;", stepId,[CMData getUserId]];
    [set next];
    return [set intForColumn:@"step_count"] >= 1;
}
@end

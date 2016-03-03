//
//  CMAPI.h
//  NewCut
//
//  Created by py on 15-7-18.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CODE @"code"
#define RESULT @"result"
#define LIST @"list"
#define REASON @"reason"

extern NSString *const CMAPIBaseURL;

extern NSString *const CMRES_ImageURL;//图片地址 多张
extern NSString *const CMRES_BaseURL;//图片地址 单张
extern NSString *const CMRES_AVATAR_URL;//图片地址 头像

// 用户是否注册
#define API_USER_IS_REG @"/user/idThere"
//用户注册
#define API_USER_REG @"user/reg"
//修改密码
#define API_USER_UPDATE @"user/updatePwd"
//用户登录
#define API_USER_LOGIN @"user/login"
//重置密码
#define API_USER_RESETPWD @"user/resetPwd"
//退出
#define API_USER_LOGOUT @"user/logout"
//修改昵称
#define API_USER_MODIFYPERSONAL @"user/modifyPersonal"
//修改头像
#define API_USER_MODIFYIMAGE @"avatarUpload"
//用户手机号解帮
#define API_USER_UNWRAPTEL @"user/unwrapTel"
//用户评论列表
#define API_COMMENT_GETCOMMENT @"comment/getComment"
//下载图片
#define API_PIC_UPLOAD @"pic/upload"
//获取热门影视名称
#define API_MOVIE_GETMOVIENAME @"movie/getMovieName"
//获取热门影星姓名
#define API_STAR_GETSTARNAME @"star/getStarName"
//获取热门商品名称
#define API_GOOD_GETGOODNAME @"good/getGoodName"
//模糊查询(通过输入的值从电影表，影星表和商品表中查询列表)
#define API_MOVIE_FUZZY_SEARCH @"search/fuzzySearch"
//电影详情查询
//#define API_MOVIE_GETMOVIEDETAIL @"movie/getMovieDetail"
//影星详情页面查询
#define API_STAR_GETSTARDETAIL @"star/getStarDetail"
//商品详情页面查询
#define API_GOODS_GETGOODSDETAIL @"good/getGoodDetail"

//电影详情查询
#define API_MOVIE_GETMOVIEDETAIL_V2 @"movie/getMovieDetail/movieDetail"
//电影详情查询-主演信息
#define API_MOVIE_GETMOVIEDETAIL_STAR @"movie/getMovieDetail/starDetail"
//电影详情查询-剧照详情
#define API_MOVIE_GETMOVIEDETAIL_STAGE_PHOTO @"movie/getMovieDetail/stagePhoto"
//电影详情查询-商品详情
#define API_MOVIE_GETMOVIEDETAIL_GOOD_DETAIL @"movie/getMovieDetail/goodDetail"
//电影详情查询-评论详情
#define API_MOVIE_GETMOVIEDETAIL_COMMENT_DETAIL @"movie/getMovieDetail/commentDetail"
//影星详情页面查询
#define API_STAR_GETSTARDETAIL_V2 @"star/getStarDetail/starDetail"
//影星详情查询-电影详情
#define API_STAR_GETSTARDETAIL_MOVIE @"star/getStarDetail/movieDetails"
//影星详情查询-剧照详情
#define API_STAR_GETSTARDETAIL_STAGE_PHOTO @"star/getStarDetail/starPhotoDetail"
//影星详情查询-商品详情
#define API_STAR_GETSTARDETAIL_GOOD_DETAIL @"star/getStarDetail/goodDetails"
//商品详情页面查询
#define API_GOODS_GETGOODSDETAIL_V2 @"good/getGoodDetail/goodDetail"
//商品详情查询-主演信息
#define API_GOODS_GETGOODSDETAIL_STAR @"good/getGoodDetail/starDetail"
//商品详情查询-剧照详情
#define API_GOODS_GETGOODSDETAIL_STAGE_PHOTO @"good/getGoodDetail/stagePhoto"
//商品详情查询-商品照片
#define API_GOODS_GETGOODSDETAIL_GOODS_PHOTO @"good/getGoodDetail/goodPhotoDetail"
//商品详情查询-评论信息
#define API_GOODS_GETGOODSDETAIL_COMMENT_DETAIL @"good/getGoodDetail/commentDetails"

//对电影或者商品进行评论
#define API_COMMENT_ADDCOMMENT @"comment/addComment"
//对电影，单品，评论进行点赞或者吐槽操作
#define API_COMMENT_ADDPRAISEORTRAMPLE @"comment/addprAiseOrTrample"
//对电影，单品，评论取消点赞或者吐槽操作
#define API_COMMENT_CANCERPRAISEORTRAMPLE @"comment/cancelprAiseOrTrample"
//获取单品分类名称
#define API_TOPIC_GETTOPICNAME @"topic/getTopicName"
//获取电影列表 (根据汉语拼音排序)
#define API_MOVIE_GETMOVIELIST @"movie/getMovieList"
//获取影星列表
#define API_STAR_GETSTARLIST @"star/getStarList"
//分页查询影星列表
#define API_STAR_GETSTARLISTBYPAGE  @"star/getStarByPage"
//根据电影首字母大写查询电影详情
#define API_MOVIE_GETMOVIEBYCASE @"movie/getMovieByCase"
//根据影星首字母大写查询影星详情
#define API_STAR_GETSTARBYCASE @"star/getStarByCase"
//热门电影查询(最受关注)
#define API_MOVIE_GETHOT_GETMOSTCONCERNMOVIE @"movie/hot/getMostConcernMovie"
//热门电影查询(本周上映)
#define API_MOVIE_GETHOST_GETOUTTHISWEEK @"movie/hot/getOutThisWeek"
//热门影星查询(最受关注)
#define API_STAR_GETHOST_GETMOSTCONCERNSTAR @"star/hot/getMostConcernStar"
//热门影星查询(时尚达人)
#define API_STAR_GETHOST_GETFASHIONISTAS @"star/hot/getFashionistas"
//获取商品列表
#define API_GOOD_GETALLPHOTOBYTOPIC @"good/getAllPhotoByTopic"
//获取电影的所有图片
#define API_MOVIE_GETALLPHOTOBYMOVIEID @"movie/getAllPhotoByMovieId"
//获取影星的所有图片
#define API_MOVIE_GETALLPHOTOBYSTARID @"movie/getAllPhotoByStarId"
//获取商品的所有图片
#define API_MOVIE_GETALLPHOTOBYGOODID @"movie/getAllPhotoByGoodId"
// 电影列表分页查询
#define API_MOVIE_PAGE_SEARCH @"movie/getMovieByPage"
// 影星列表分页查询
#define API_STAR_PAGE_SEARCH  @"star/getStarByPage"
// 用户评论
#define API_USER_COMMENT @"comment/getCommentByUserId"
//特殊接口
#define API_GETDATA @"getData"
#define API_ADPHOTO  @"advertisement/getAdvertisementPhoto"

typedef enum {
    PYResultTypeDictionary,
    PYResultTypeArray
}PYResultType;

@interface PYResult : NSObject
@property BOOL succeed;
@property NSString* code;
@property NSMutableDictionary* result;
@end

@interface PYResultSET : NSObject
@property NSString* key;//自定义的key
@property PYResultType type;//PYResultTypeDictionary:Dictionary PYResultTypeArray:Array//

- (instancetype)initWithKey:(NSString*)key Type:(PYResultType) type;
@end

@interface PyResetValueKey : NSObject

@property NSString *mynewKey;
@property NSString *oldKey;

-(instancetype)initNewkey:(NSString*)newkey OldKey:(NSString*)oldkey;

@end

@interface CMAPI : NSObject

+(void)checkWeb:(void (^)())end;
+(BOOL)checkWeb;

+ (void)getUrl:(NSString*) url Param:(NSDictionary*) param Settings:settings completion:(void (^)(BOOL succeed,NSDictionary* detailDict,NSError *error))completion;
+ (void)postUrl:(NSString*) url Param:(NSDictionary*) param Settings:settings completion:(void (^)(BOOL succeed,NSDictionary* detailDict,NSError *error))completion;
+ (void)uploadUrl:(NSString*) url Param:(NSDictionary*) param  Image:(NSString*)imagePath  WithCompletion:(void (^)(BOOL succeed,NSDictionary* detailDict,NSError *error))completion;
+(void)postUrl:(NSString *)url Param:(NSDictionary *)param Settings:(id)settings FileData:(NSData*)filedata OpName:(NSString*)opname FileName:(NSString*)filename FileType:(NSString*)filetype completion:(void (^)(BOOL succeed,NSDictionary* detailDict,NSError *error))completion;
+(void)postUrl:(NSString*)url Param:(NSDictionary *)param ImageDatas:(NSArray*)imageDatas Settings:(id)settings completion:(void (^)(BOOL, NSDictionary *, NSError *))completion;

@end

//
//  MovieModel.h
//  NewCut
//
//  Created by py on 15-7-15.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PYBaseObject.h"

@interface MovieModel : PYBaseObject

/**@brief 电影名称*/
@property (nonatomic,strong)NSString *filmName;
/**@brief 电影竖版海报*/
@property (nonatomic,strong)NSString *filmImage;
/**@brief 导演*/
@property (nonatomic,strong)NSString *directorName;
/**@brief 参演演员*/
@property (nonatomic,strong)NSMutableArray *starsName;
/**@brief 电影类型*/
@property (nonatomic,strong)NSString *movieTopic;
/**@brief 电影年份*/
@property (nonatomic,strong)NSString *movieYear;
/**@brief 点赞数*/
@property (nonatomic,strong)NSString *praiseCount;
/**@brief 电影介绍*/
@property (nonatomic,strong)NSString *movieRelated;
/**@brief 电影横版海报*/
@property (nonatomic,strong)NSString *movieFilmH;
/**@brief 商品数量*/
@property (nonatomic,strong)NSString *goodsCounts;
/**@brief 电影制片国家*/
@property (nonatomic,strong)NSString *movieNationality;
/**@brief 管理员评论*/
@property (nonatomic,strong)NSString *systemRelated;

@end

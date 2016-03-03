//
//  FilmDetailModel.h
//  NewCut
//
//  Created by 夏雪 on 15/7/29.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
/** 
 *
 {
	movieTopic = 动作,
	movieRelated = 007,
	director = 李安,
	moviePhoto = 7d8e67bd-7481-464c-917f-b8921580edcc.jpg,
	systemRelated = aaaaaa,
	movienationality = 台湾,
	stars = 林青霞2,张国荣1,
	movieYear = 2015-07-04,
	movieId = 1,
	movieName = 警察故事1,
	praiseCount = 0
 }

 */
@interface FilmDetailModel : NSObject

@property(nonatomic,copy)NSString *director;

@property(nonatomic,copy)NSString *moviePhoto;

@property(nonatomic,copy)NSString *stars;

@property(nonatomic,strong)NSNumber *moviePraiseCount;

@property(nonatomic,copy)NSString *movieName;

@property(nonatomic,copy)NSString *movieYear;

@property(nonatomic,copy)NSString *movieId;

@property(nonatomic,copy)NSString *hanyupinyin;
@property(nonatomic,copy)NSString *commentCount;
@end

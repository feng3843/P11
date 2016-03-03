//
//  UserCommentModel.h
//  NewCut
//
//  Created by 夏雪 on 15/8/12.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *	time = ,
	id = 77,
	userName = 18626457031,
	praiseCount = 0,
	tsukkomiCount = 0,
	typeName = 电影,
	comment = 呵呵,
	name = 大话西游1
 */
@interface UserCommentModel : NSObject
@property(nonatomic ,copy)NSString *time;
@property(nonatomic ,copy)NSString *userName;
@property(nonatomic ,copy)NSString *praiseCount;
@property(nonatomic ,copy)NSString *tsukkomiCount;
@property(nonatomic ,copy)NSString *typeName;
@property(nonatomic ,copy)NSString *comment;
@property(nonatomic ,copy)NSString *name;
@property(nonatomic,copy)NSString *movieGoodId;
@end

//
//  PYComment.h
//  NewCut
//
//  Created by MingleFu on 15/8/10.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "PYBaseObject.h"

@interface CommentModel : PYBaseObject

@property (nonatomic,strong)NSString *strName;
@property (nonatomic,strong)NSString *strPhoto;
@property (nonatomic,strong)NSString *strDescription;
@property (nonatomic,strong)NSString *strPraise;
@property (nonatomic,strong)NSString *strTsuCount;
@property(nonatomic ,strong)NSString *userType ;
@end

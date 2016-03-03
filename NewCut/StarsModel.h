//
//  StarsModel.h
//  NewCut
//
//  Created by py on 15-7-15.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PYBaseObject.h"

@interface StarsModel : PYBaseObject

/**@brief 明星名字*/
@property (nonatomic,strong)NSString *starName;
/**@brief 明星海报*/
@property (nonatomic,strong)NSString *starImage;
/**@brief 国家*/
@property (nonatomic,strong)NSString *nation;
/**@brief 明星生日*/
@property (nonatomic,strong)NSString *starBirth;

/**@brief 明星性别*/
@property (nonatomic,strong)NSString *starSex;

/**@brief 明星简介*/
@property (nonatomic,strong)NSString *starRelated;

/**@brief 商品数量*/
@property (nonatomic,strong)NSString *counts;

/**@brief 参演电影*/
@property (nonatomic,strong)NSString *movieName;

@end

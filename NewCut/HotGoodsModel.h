//
//  HotGoodsModel.h
//  NewCut
//
//  Created by py on 15-7-19.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PYBaseObject.h"

@interface HotGoodsModel : PYBaseObject

@property (nonatomic,strong)NSString *goodName;
@property (nonatomic,strong)NSString *goodPhotoPath;

@property (nonatomic,strong)NSString *goodPraiseCount;

@property (nonatomic,strong)NSString *goodRelated;

@property (nonatomic,strong)NSString *commentCount;
@property(nonatomic,copy)NSString *webSite;

@end

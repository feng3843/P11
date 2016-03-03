//
//  SingleGoodModel.h
//  NewCut
//
//  Created by 夏雪 on 15/8/8.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
/**
 *	id = 21,
 *	fileName = e9bc9095-2c85-494c-835c-d66489ff4dc0.jpg,
 *	topicName = 鞋子
 */
@interface SingleGoodModel : NSObject
@property(nonatomic,copy)NSString *singleGoodId;
@property(nonatomic,copy)NSString *fileName;
@property(nonatomic,copy)NSString *topicName;

@end

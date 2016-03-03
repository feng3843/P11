//
//  SearchListInfo.h
//  NewCut
//
//  Created by uncommon on 2015/07/21.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EnumList.h"

/** @brief 查询到的信息列表 */
@interface SearchListInfo : NSObject

/** @brief 类型 */
@property ExhibitionType* searchType;

#pragma mark- 影视
@property NSString* movieId;
@property NSString* movieName;
@property NSString* moviePhoto;

#pragma mark- 商品
@property NSString* goodId;
@property NSString* goodName;
@property NSString* goodPhoto;

#pragma mark- 影星
@property NSString* starId;
@property NSString* starName;
@property NSString* starPhoto;
@end

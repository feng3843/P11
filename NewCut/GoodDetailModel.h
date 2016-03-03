//
//  GoodDetailModel.h
//  NewCut
//
//  Created by py on 15-7-19.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <Foundation/Foundation.h>

/** goodPraiseCount = 0,
	goodPhoto = 4400e44b-d9fa-487e-9f4a-57933d1ac5f8.jpg,
	goodName = 服装3,
	goodRelated = 23,
    goodId = 5
*/
@interface GoodDetailModel : NSObject
@property(nonatomic,copy)NSString *goodPhoto;
@property(nonatomic,copy)NSString *goodId;
@property(nonatomic,copy)NSString *goodRelated;
@property(nonatomic,copy)NSString *goodName;
@property(nonatomic,copy)NSString *goodPraiseCount;
@property(nonatomic,assign)int goodCommentCount;
@end

//
//  StarDetailModel.m
//  NewCut
//
//  Created by py on 15-7-18.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "StarDetailModel.h"

@implementation StarDetailModel


- (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"starPhotoPath":@"starPhoto",@"starYear":@"starBirthday"};
}

MJCodingImplementation
@end

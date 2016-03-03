//
//  PYUserData.m
//  NewCut
//
//  Created by py on 15-7-18.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "PYUserData.h"
#import "MJExtension.h"
@implementation PYUserData

- (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"userId":@"id"};
}

MJCodingImplementation

@end

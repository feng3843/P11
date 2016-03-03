//
//  GoodsCollectionCell.m
//  NewCut
//
//  Created by py on 15-7-16.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "GoodsCollectionCell.h"

@implementation GoodsCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, CGRectGetWidth(self.frame)-10, CGRectGetWidth(self.frame)-10)];
        self.imgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:self.imgView];
        
        self.text = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.imgView.frame), CGRectGetWidth(self.frame)-10, 20)];
        self.text.backgroundColor = [UIColor brownColor];
        self.text.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.text];
        
//        self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.btn.frame = CGRectMake(5, CGRectGetMaxY(self.text.frame), CGRectGetWidth(self.frame)-10,30);
//        [self.btn setTitle:@"按钮" forState:UIControlStateNormal];
//        self.btn.backgroundColor = [UIColor orangeColor];
//        [self addSubview:self.btn];
    }
    return self;
}

@end

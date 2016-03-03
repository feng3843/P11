//
//  MyCollectionPhotoCollectionViewCell.m
//  NewCut
//
//  Created by 夏雪 on 15/7/21.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "MyCollectionPhotoCollectionViewCell.h"

@interface MyCollectionPhotoCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@end

@implementation MyCollectionPhotoCollectionViewCell

 - (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
   
    }
    return self;
}

- (void)awakeFromNib
{
    self.iconImage.image = [UIImage imageNamed:@"42.jpg"];
}
@end

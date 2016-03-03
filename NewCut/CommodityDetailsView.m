//
//  CommodityDetailsView.m
//  NewCut
//
//  Created by 夏雪 on 15/8/10.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "CommodityDetailsView.h"
#import "SDImageView+SDWebCache.h"
#import "PYAllCommon.h"

@interface CommodityDetailsView()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *priseCount;
- (IBAction)btnClick:(UIButton *)sender;

@end
@implementation CommodityDetailsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)btnClick:(UIButton *)sender {
}


- (void)setGood:(GoodDetailModel *)good
{
    _good = good;
    
    NSURL *url = [NSURL URLWithString:[CMRES_BaseURL stringByAppendingPathComponent:good.goodPhoto]];
    [self.iconImage setImageWithURL:url refreshCache:NO placeholderImage:[UIImage imageNamed:DEFAULT_IMAGE_JUZHAO]];
    self.descLabel.text = good.goodName;
    self.priseCount.text = good.goodPraiseCount;
}
@end

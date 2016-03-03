//
//  MyCollectionStartTableViewCell.m
//  NewCut
//
//  Created by 夏雪 on 15/7/21.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "MyCollectionStartTableViewCell.h"
#import "UIColor+Extensions.h"
#import "CMTool.h"
#import "SDImageView+SDWebCache.h"
#import "PYAllCommon.h"

@interface MyCollectionStartTableViewCell()

/** 明星照片*/
@property(nonatomic ,weak)UIImageView *startImage;
/** 明星名字*/
@property(nonatomic ,weak)UILabel *startName;
/** 明星国籍*/
@property(nonatomic ,weak)UILabel *startNationality;
/** 代表作品*/
@property(nonatomic ,weak)UILabel *startWorks;

@end

@implementation MyCollectionStartTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{ self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    //CGRect bounds = [[UIScreen mainScreen] bounds];
    //self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, height)];
    if (self) {
        
        CGFloat w=[UIScreen mainScreen].bounds.size.width;
        CGFloat rate = w / 320;
        CGFloat leftX = 90;
        // 明星照片
        UIImageView *startImage = [[UIImageView alloc]initWithFrame:CGRectMake(16 * rate , 15 * rate, 60  * rate,80 * rate)];
        startImage.image = [UIImage imageNamed:@"bb.jpg"];
        [self.contentView addSubview:startImage];
        self.startImage = startImage;
        // 电影名
        UILabel *startName = [[UILabel alloc]initWithFrame:CGRectMake(leftX * rate , 26 * rate , (w - 110 )* rate, 15 *rate)];
        startName.font = [UIFont boldSystemFontOfSize:15 *rate];
        startName.textColor = [UIColor colorWithHexString:@"000000"];
        startName.text = @"杨颖";
        //        titleLable.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:startName];
        self.startName = startName;
        
        UILabel *startNationality = [[UILabel alloc]initWithFrame:CGRectMake(leftX * rate , 52 *rate ,  (w - 110 ) * rate, 13 *rate)];
        startNationality.font = [UIFont systemFontOfSize:13 *rate];
        startNationality.textColor = [UIColor colorWithHexString:@"666666"];
        startNationality.text = @"国籍：中国";
        //        titleLable.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:startNationality];
        self.startNationality = startNationality;
        
        UILabel *startWorks = [[UILabel alloc]initWithFrame:CGRectMake(leftX * rate , 67 * rate ,  (w - 110 )* rate, 13 *rate)];
        startWorks.font = [UIFont systemFontOfSize:13 *rate];
        startWorks.textColor = [UIColor colorWithHexString:@"666666"];
        startWorks.text = @"代表作品:《奔跑吧兄弟》";
        //        titleLable.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:startWorks];
        self.startWorks = startWorks;
        UIView *separatorView = [[UIView alloc]initWithFrame:CGRectMake(16 * rate, 109.5 * rate, w - 16 * rate, 0.5 * rate)];
        separatorView.backgroundColor = [UIColor colorWithHexString:@"bababa"];
        [self.contentView addSubview:separatorView];
        
    }
    
    return self;

    
}

- (void)setStar:(StarDetailModel *)star
{
    _star = star;

    NSString *path = [CMRES_BaseURL   stringByAppendingPathComponent:star.starPhotoPath];
    self.startName.text = star.starName;
    self.startNationality.text = [NSString stringWithFormat:@"国籍：%@",star.starNationality];
    self.startWorks.text = [NSString stringWithFormat:@"代表作品：%@",star.movies];    NSURL *url = [NSURL URLWithString:path];
    [self.startImage setImageWithURL:url refreshCache:NO placeholderImage:[UIImage imageNamed:DEFAULT_IMAGE_STAR]];
    
}
@end

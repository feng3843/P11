//
//  MyCollectionGoodsTableViewCell.m
//  NewCut
//
//  Created by 夏雪 on 15/7/21.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "MyCollectionGoodsTableViewCell.h"
#import "UIColor+Extensions.h"
#import "SDImageView+SDWebCache.h"
#import "PYAllCommon.h"

@interface MyCollectionGoodsTableViewCell()
/** 商品图片*/
@property(nonatomic ,weak)UIImageView *goodImage;
/** 商品名*/
@property(nonatomic ,weak)UILabel *goodName;
/** 商品简介*/
@property(nonatomic ,weak)UILabel *goodIntroduce;
/** 喜欢人数*/
@property(nonatomic ,weak)UILabel *likeCount;
/** 评论条数*/
@property(nonatomic ,weak)UILabel *commentCount;

@property(nonatomic ,weak)UIView *dividingLine;

@property(nonatomic ,weak)UILabel  *comment;

@end

@implementation MyCollectionGoodsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    //CGRect bounds = [[UIScreen mainScreen] bounds];
    //self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, height)];
    if (self) {
        
        CGFloat w=[UIScreen mainScreen].bounds.size.width;
        CGFloat rate = w / 320;
        CGFloat leftX = 90;
        UIImageView *goodImage = [[UIImageView alloc]initWithFrame:CGRectMake(16 * rate , 15 * rate, 60  * rate,80 * rate)];
        goodImage.image = [UIImage imageNamed:@"bb.jpg"];
        [self.contentView addSubview:goodImage];
        self.goodImage = goodImage;
        // 商品名
        UILabel *goodName = [[UILabel alloc]initWithFrame:CGRectMake(leftX * rate , 24 * rate , (w - 110 )* rate, 15)];
        goodName.font = [UIFont boldSystemFontOfSize:15];
        goodName.textColor = [UIColor colorWithHexString:@"000000"];
        goodName.text = @"小时代3: 刺...";
        //        titleLable.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:goodName];
        self.goodName = goodName;
        
        UILabel *goodIntroduce = [[UILabel alloc]initWithFrame:CGRectMake(leftX * rate , 44 *rate ,  (w - 110 )* rate, 13)];
        goodIntroduce.font = [UIFont systemFontOfSize:13];
        goodIntroduce.textColor = [UIColor colorWithHexString:@"666666"];
        goodIntroduce.text = @"暴龙高清偏光高清太阳眼镜";
        //        titleLable.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:goodIntroduce];
        self.goodIntroduce = goodIntroduce;
        
        UILabel *like = [[UILabel alloc]initWithFrame:CGRectMake(leftX * rate , 72 * rate ,  30, 12)];
        like.font = [UIFont systemFontOfSize:13];
        like.textColor = [UIColor colorWithHexString:@"666666"];
        like.text = @"喜欢";
//        like.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:like];
        
       CGFloat likeCountX = CGRectGetMaxX(like.frame);
        NSDictionary *attr = @{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:12]};
//        CGSize likeCountSize = [@"240524人" sizeWithAttributes:attr];
//         UILabel *likeCount  = [[UILabel alloc]initWithFrame:CGRectMake(likeCountX , 72 * rate ,  likeCountSize.width, 12)];
        UILabel *likeCount  = [[UILabel alloc]init];
        likeCount.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        likeCount.textColor = [UIColor colorWithHexString:@"999999"];
        likeCount.text = @"2405人";
        //        titleLable.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:likeCount];
        self.likeCount = likeCount;
        
        // 分割线
        CGFloat dividingLineX = CGRectGetMaxX(likeCount.frame) + 17 *rate;
        UIView *dividingLine = [[UIView alloc] initWithFrame:CGRectMake(dividingLineX, 73 * rate, 1 , 12)];
        dividingLine.backgroundColor = [UIColor colorWithHexString:@"bababa"];
        [self.contentView addSubview:dividingLine];
        self.dividingLine = dividingLine;
        
        CGFloat commentX = CGRectGetMaxX(dividingLine.frame) + 17 *rate;
        UILabel *comment = [[UILabel alloc]initWithFrame:CGRectMake(commentX, 72 * rate ,  30, 12)];
        comment.font = [UIFont systemFontOfSize:12];
        comment.textColor = [UIColor colorWithHexString:@"666666"];
        comment.text = @"评论";
        //        like.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:comment];
        self.comment = comment;
        
        CGFloat commentCountX = CGRectGetMaxX(comment.frame);
   
        UILabel *commentCount  = [[UILabel alloc]initWithFrame:CGRectMake(commentCountX , 72 * rate ,  w - commentCountX, 12)];
        commentCount.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        commentCount.textColor = [UIColor colorWithHexString:@"999999"];
        commentCount.text = @"2940条";
        //        titleLable.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:commentCount];
        self.commentCount = commentCount;
        
        UIView *separatorView = [[UIView alloc]initWithFrame:CGRectMake(16 * rate, 110 * rate, w - 16 * rate, 0.5 * rate)];
        separatorView.backgroundColor = [UIColor colorWithHexString:@"bababa"];
        [self.contentView addSubview:separatorView];
        
        
    }
    
    return self;
    
}

- (void)setGood:(GoodDetailModel *)good
{
    
    _good = good;
    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    CGFloat rate = w / 320;
    NSString *path = [CMRES_BaseURL     stringByAppendingPathComponent:good.goodPhoto];
    NSURL *url = [NSURL URLWithString:path];
    [self.goodImage setImageWithURL:url refreshCache:NO placeholderImage:[UIImage imageNamed:DEFAULT_IMAGE_STAR]];
    self.goodName.text = good.goodName;
    self.goodIntroduce.text = good.goodRelated;
    
    NSDictionary *attr = @{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:12]};
   NSString *like = [NSString stringWithFormat:@"%@人",good.goodPraiseCount];
    CGSize likeCountSize = [like sizeWithAttributes:attr];
    
    self.likeCount.frame =
    CGRectMake(120 * rate , 72  *rate,  likeCountSize.width *rate, 12 *rate);
//    self.likeCount.backgroundColor = [UIColor redColor];
    self.likeCount.text = like;
    self.commentCount.text = [NSString stringWithFormat:@"%d条",good.goodCommentCount];
    
    CGFloat dividingLineX = CGRectGetMaxX(self.likeCount.frame) + 17 *rate;
    self.dividingLine.frame  = CGRectMake(dividingLineX, 73 * rate, 1 , 12);
    CGFloat commentX = CGRectGetMaxX(self.dividingLine.frame) + 17 *rate;
    self.comment.frame =  CGRectMake(commentX, 72 * rate ,  30, 12);
    
    CGFloat commentCountX = CGRectGetMaxX(self.comment.frame);
    self.commentCount.frame = CGRectMake(commentCountX , 72 * rate ,  w - commentCountX, 12);
}
@end

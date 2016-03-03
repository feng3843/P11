//
//  MyCommentTableViewCell.m
//  NewCut
//
//  Created by 夏雪 on 15/7/20.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "MyCommentTableViewCell.h"
#import "UIColor+Extensions.h"
@interface MyCommentTableViewCell()

/** 标题*/
@property(nonatomic ,weak)UILabel *titleLable;
/** 子标题*/
@property(nonatomic ,weak)UILabel *subTitleLable;
/** 时间*/
@property(nonatomic ,weak)UILabel *timeLable;
/** 不赞的数量*/
@property(nonatomic ,weak)UILabel *noPraiseCount;
/** 赞的数量*/
@property(nonatomic ,weak)UILabel *praiseCount;
/** 分割线*/
@property(nonatomic ,weak)UIView *dividingLine;
@end
@implementation MyCommentTableViewCell


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    CGFloat rate = w / 320;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    //CGRect bounds = [[UIScreen mainScreen] bounds];
    //self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, height)];
   if (self) {
       UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(16 * rate, (30 - 14 ) * rate, 240 * rate , 14 * rate )];
//       titleLable.backgroundColor = [UIColor redColor];
       titleLable.text = @"10岁以上不推荐观看上不推荐观看......";
       titleLable.font = [UIFont boldSystemFontOfSize:14];
       titleLable.textColor = [UIColor colorWithHexString:@"333333"];
       [self.contentView addSubview:titleLable];
       self.titleLable = titleLable;
       
       UILabel *subTitleLable = [[UILabel alloc]initWithFrame:CGRectMake(16 * rate, 43 * rate, 200 * rate  , 12 *rate )];
       subTitleLable.text = @"捉妖记捉妖记捉";
       subTitleLable.font = [UIFont boldSystemFontOfSize:12];
       subTitleLable.textColor = [UIColor colorWithHexString:@"999999"];
       [self.contentView addSubview:subTitleLable];
       self.subTitleLable = subTitleLable;
       
       CGFloat timeLableX = CGRectGetMaxX(titleLable.frame);
       CGFloat timeLableY = (30 - 11) * rate;
       CGFloat timeLableW = w - timeLableX - 16 *rate;
       CGFloat timeLableH = 11 * rate;
       UILabel *timeLable =  [[UILabel alloc]initWithFrame:CGRectMake(timeLableX, timeLableY, timeLableW  , timeLableH)];
       timeLable.text = @"2小时前";
       timeLable.font = [UIFont systemFontOfSize:11];
       timeLable.textColor = [UIColor colorWithHexString:@"666666"];
//       timeLable.backgroundColor = [UIColor blueColor];
       timeLable.textAlignment = NSTextAlignmentRight;
       [self.contentView addSubview:timeLable];
       self.timeLable = timeLable;
       
       NSDictionary *attrs = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:15]};
       CGSize timeLableSize = [@"30" sizeWithAttributes:attrs];
       CGFloat noPraiseX = w - 16 * rate - timeLableSize.width ;
       UILabel *noPraise = [[UILabel alloc]initWithFrame:CGRectMake(noPraiseX , 41 * rate ,timeLableSize.width , 15 * rate)];
       noPraise.text = @"30";
       noPraise.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
       noPraise.textColor = [UIColor colorWithHexString:@"999999"];
       [self.contentView addSubview:noPraise];
       self.noPraiseCount = noPraise;
       
       UIImageView *noPraiseImage = [[UIImageView alloc]initWithImage:[UIImage  imageNamed:@"bt_chat_bad_normal.png"]];
       CGFloat noPraiseImageX = CGRectGetMinX(noPraise.frame) - 5 *rate - 15 *rate;
       noPraiseImage.frame = CGRectMake(noPraiseImageX, 41 * rate, 15 *rate , 15 *rate);
       [self.contentView addSubview:noPraiseImage];
       
       CGSize praiseSize = [@"130" sizeWithAttributes:attrs];
       CGFloat praiseX = CGRectGetMinX(noPraiseImage.frame) - 18 *rate - praiseSize.width ;
       UILabel *praise = [[UILabel alloc]initWithFrame:CGRectMake(praiseX , 41 * rate ,praiseSize.width , 15 * rate)];
       praise.text = @"130";
       praise.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
       praise.textColor = [UIColor colorWithHexString:@"999999"];
       [self.contentView addSubview:praise];
       self.praiseCount = praise;
       
       UIImageView *praiseImage = [[UIImageView alloc]initWithImage:[UIImage  imageNamed:@"bt_chat_good_normal.png"]];
       CGFloat praiseImageX = CGRectGetMinX(praise.frame) - 5 *rate - 15 *rate;
       praiseImage.frame = CGRectMake(praiseImageX, 41 * rate, 15 *rate , 15 *rate);
       [self.contentView addSubview:praiseImage];
       
       UIView *dividingLine = [[UIView alloc]initWithFrame:CGRectMake(0, 69.5 *rate  , w, 0.5)];
       dividingLine.backgroundColor = [UIColor colorWithHexString:@"bababa"];
       [self.contentView addSubview:dividingLine];
       self.dividingLine = dividingLine;
    }
    
    return self;
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
//    self.dividingLine.frame = CGRectMake(0, self.frame.size.height  , self.frame.size.width, 1);
}
- (void)setComment:(UserCommentModel *)comment
{
    _comment = comment;
    self.titleLable.text = comment.comment;
    self.subTitleLable.text = comment.name;
    self.noPraiseCount.text = comment.tsukkomiCount;
    self.praiseCount.text = comment.praiseCount;
    
    // 设置剩余时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd 24HH:mm:ss";
    NSDate *dead = [fmt dateFromString:comment.time];
//    // 追加1天
//    dead = [dead dateByAddingTimeInterval:24 * 60 * 60];
    NSDate *now = [NSDate date];
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute|NSCalendarUnitSecond;
    NSDateComponents *cmps = [[NSCalendar currentCalendar] components:unit fromDate:dead toDate:now options:0];
    if (cmps.year) {
             self.timeLable.text = [NSString stringWithFormat:@"%ld年前",cmps.year];
        return;
    }else if (cmps.month)
    {
        self.timeLable.text = [NSString stringWithFormat:@"%ld月前",cmps.month];
        return;
    }
    else if (cmps.day) {
        
        self.timeLable.text = [NSString stringWithFormat:@"%ld天前",cmps.day];
        return;
    }else if (cmps.hour)
    {
        self.timeLable.text = [NSString stringWithFormat:@"%ld小时前",cmps.hour];
        return;
    }else if (cmps.minute)
    {
        self.timeLable.text = [NSString stringWithFormat:@"%ld分钟前",cmps.minute];
        return;
    }else if (cmps.second)
    {
        self.timeLable.text = [NSString stringWithFormat:@"%ld秒前",cmps.second];
        return;
    }
    
}
@end

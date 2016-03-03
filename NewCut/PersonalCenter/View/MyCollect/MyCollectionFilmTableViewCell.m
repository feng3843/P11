//
//  MyCollectionFilmTableViewCell.m
//  NewCut
//
//  Created by 夏雪 on 15/7/20.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "MyCollectionFilmTableViewCell.h"
#import "UIColor+Extensions.h"
#import "SDImageView+SDWebCache.h"
#import "PYAllCommon.h"

@interface MyCollectionFilmTableViewCell()
/** 电影照片*/
@property(nonatomic ,weak)UIImageView *filmImage;
/** 电影名*/
@property(nonatomic ,weak)UILabel *filmName;
/** 导演*/
@property(nonatomic ,weak)UILabel *directName;
/** 主演*/
@property(nonatomic ,weak)UILabel *leadName;
/** 上映时间*/
@property(nonatomic ,weak)UILabel *screenTime;

@property(nonatomic ,weak)UILabel *praiseCount;

@property(nonatomic ,weak)UIView *separatorView;

@end

@implementation MyCollectionFilmTableViewCell

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

        CGFloat w =[UIScreen mainScreen].bounds.size.width;
        CGFloat rate = w / 320;
        CGFloat leftX = 90;
        UIImageView *filmImage = [[UIImageView alloc]initWithFrame:CGRectMake(16 * rate , 15 * rate, 60  * rate,80 * rate)];
        filmImage.image = [UIImage imageNamed:@"bb.jpg"];
       [self.contentView addSubview:filmImage];
        self.filmImage = filmImage;
        // 电影名
        UILabel *filmName = [[UILabel alloc]initWithFrame:CGRectMake(leftX * rate , 17 * rate , 100, 21)];
        filmName.font = [UIFont boldSystemFontOfSize:15];
        filmName.textColor = [UIColor colorWithHexString:@"000000"];
        filmName.text = @"小时代3: 刺...";
//        titleLable.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:filmName];
        self.filmName = filmName;
        
        UILabel *directName = [[UILabel alloc]initWithFrame:CGRectMake(leftX * rate , 39 *rate ,  (w - 110 )* rate, 21)];
        directName.font = [UIFont systemFontOfSize:13];
        directName.textColor = [UIColor colorWithHexString:@"666666"];
        directName.text = @"导演: 郭敬明";
        //        titleLable.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:directName];
        self.directName = directName;
        
        UILabel *leadName = [[UILabel alloc]initWithFrame:CGRectMake(leftX * rate , 55 * rate ,  (w - 110 )* rate, 21)];
        leadName.font = [UIFont systemFontOfSize:13];
        leadName.textColor = [UIColor colorWithHexString:@"666666"];
        leadName.text = @"主演：杨幂 郭采洁 陈学东 郭碧婷";
        //        titleLable.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:leadName];
        self.leadName = leadName;
        
        UILabel *screenTime  = [[UILabel alloc]initWithFrame:CGRectMake(leftX * rate , 78 * rate ,  (w - 110 )* rate, 21)];
        screenTime.font = [UIFont systemFontOfSize:12];
        screenTime.textColor = [UIColor colorWithHexString:@"777777"];
        screenTime.text = @"还有2天上映";
        //        titleLable.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:screenTime];
        self.screenTime = screenTime;

        NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:10 * rate ]};
        CGSize showLableSize = [@"人评论" sizeWithAttributes:attr];
        CGFloat showLableW = showLableSize.width * rate;
        CGFloat showLableY = (15 + 20 - 10) *rate;
        CGFloat showLableX = (w - 16 )*rate - showLableW;
        UILabel *showLable = [[UILabel alloc]initWithFrame:CGRectMake(showLableX, showLableY, showLableW, 10*rate )];
        showLable.text = @"人评论";
        showLable.font = [UIFont systemFontOfSize:10 *rate];
        showLable.textColor = [UIColor colorWithHexString:@"999999"];
        
        [self.contentView addSubview:showLable];
        CGFloat praiseCountW = CGRectGetMaxX(filmName.frame);
        CGFloat praiseCountX = CGRectGetMinX(showLable.frame) - praiseCountW;
        CGFloat praiseCountY = 15 * rate;
        
        UILabel *praiseCount = [[UILabel alloc]initWithFrame:CGRectMake(praiseCountX, praiseCountY, praiseCountW, 22*rate)];
        praiseCount.text = @"11111";
        praiseCount.font = [UIFont fontWithName:@"HelveticaNeue" size:22*rate];
        praiseCount.textColor = [UIColor colorWithHexString:@"666666"];
        praiseCount.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:praiseCount];
        self.praiseCount = praiseCount;
//        praiseCount.backgroundColor = [UIColor redColor];
        
        UIView *separatorView = [[UIView alloc]initWithFrame:CGRectMake(16 * rate, 109.5 * rate, w - 16 * rate, 0.5 * rate)];
        separatorView.backgroundColor = [UIColor colorWithHexString:@"bababa"];
        self.separatorView = separatorView;
        [self.contentView addSubview:separatorView];
  
        
        
    }
    
    return self;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    CGFloat w =[UIScreen mainScreen].bounds.size.width;
//    CGFloat rate = w / 320;
//    self.separatorView.frame  = CGRectMake(16 * rate, 109.5 * rate, w - 16 * rate, 0.5 * rate);
    
}

- (void)setFilm:(FilmDetailModel *)film
{
    _film = film;
    NSString *path = [CMRES_BaseURL     stringByAppendingPathComponent:film.moviePhoto];
    NSURL *url = [NSURL URLWithString:path];
    [self.filmImage setImageWithURL:url refreshCache:NO placeholderImage:[UIImage imageNamed:DEFAULT_IMAGE_STAR]];
    self.filmName.text = film.movieName;
    self.directName.text = [NSString stringWithFormat:@"导演：%@",film.director];
    self.leadName.text = [NSString stringWithFormat:@"主演：%@",film.stars];
    // 上映时间
    // 设置剩余时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *dead = [fmt dateFromString:self.film.movieYear];
    NSDate *now = [NSDate date];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *cmps = [[NSCalendar currentCalendar] components:unit fromDate:now toDate:dead options:0];
    if (cmps.day > 0) {
        self.screenTime.text = [NSString stringWithFormat:@"还有%ld天上映",cmps.day + 1];
    }else if (cmps.day >= -7)
    {
         self.screenTime.text = @"正在热映";
    }else
    {
        self.screenTime.text = [NSString stringWithFormat:@"上映时间：%@",self.film.movieYear ];

    }
    if (![self.film.commentCount isEqualToString:@""]) {
           self.praiseCount.text = self.film.commentCount ;
    }else
    {
        self.praiseCount.text = @"0" ;
    }
 
    
//    self.separatorView.hidden = NO;
    
}
@end

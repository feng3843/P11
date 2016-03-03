//
//  FilmDetailCell.m
//  NewCut
//
//  Created by py on 15-7-12.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "FilmDetailCell.h"
#import "PYAllCommon.h"
#import "MovieModel.h"

@interface FilmDetailCell()

@property(nonatomic ,weak)UIView *line;

@end
@implementation FilmDetailCell
@synthesize movieName,movieType,time;

- (void)awakeFromNib {
    // Initialization code
}
/*王朋*/
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        
        movieName = [[UILabel alloc]initWithFrame:CGRectMake(11, 13, SCREEN_WIDTH, 18)];
        movieName.textColor = [UIColor colorWithHexString:@"000000"];
        movieName.font = [UIFont boldSystemFontOfSize:18];
        [self addSubview:movieName];
        
        movieType = [[UILabel alloc]initWithFrame:CGRectMake(11, 38, 90, 11)];
        movieType.textColor = [UIColor colorWithHexString:@"666666"];
        movieType.font = [UIFont systemFontOfSize:11];
        [self addSubview:movieType];
        /**王朋**/
      
        
        time = [[UILabel alloc]initWithFrame:CGRectMake(164, 38, 130, 20)];
        time.textColor = [UIColor colorWithHexString:@"666666"];
        time.font = [UIFont systemFontOfSize:10];
        [self addSubview:time];
        
//        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(120, 38, 44, 20)];
//        title.textColor = [UIColor colorWithHexString:@"666666"];
//        title.font = [UIFont systemFontOfSize:10];
//        title.text = @"上映时间:";
//        [self addSubview:title];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(112, 43, 1, 11)];
        line.backgroundColor = [UIColor colorWithHexString:@"bababa"];
        self.line = line;
        [self addSubview:line];
        
    
        UILabel *hline = [[UILabel alloc]initWithFrame:CGRectMake(0, 60.5, SCREEN_WIDTH, 0.5)];
        hline.backgroundColor = [UIColor colorWithHexString:@"bababa"];
        [self addSubview:hline];
        UILabel *hline1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        hline1.backgroundColor = [UIColor colorWithHexString:@"bababa"];
        [self addSubview:hline1];
    }
    
    return self;
}

-(void)setModel:(MovieModel *)model
{
    _model = model;
    NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:11]};
    CGSize size = [_model.movieTopic sizeWithAttributes:attr];
    movieType.frame = CGRectMake(11, 38, size.width, 11);
    self.line.frame = CGRectMake(CGRectGetMaxX(movieType.frame) + 4, 38, 1, 11);
    time.frame =CGRectMake(CGRectGetMaxX(  self.line.frame) + 4, 38, fDeviceWidth, 10);
    movieName.text = _model.filmName;
    movieType.text = _model.movieTopic;


    time.text = [NSString stringWithFormat:@"上映时间:%@",_model.movieYear];
//    time.text = _model.movieYear;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

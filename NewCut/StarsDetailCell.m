//
//  StarsDetailCell.m
//  NewCut
//
//  Created by py on 15-7-14.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "StarsDetailCell.h"
#import "PYAllCommon.h"
#import "StarsModel.h"
@interface StarsDetailCell()

@property(nonatomic ,weak)UIView *line;
@end
@implementation StarsDetailCell
@synthesize starName,starLocation,time;

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    
    if (self) {
        
        starName = [[UILabel alloc]initWithFrame:CGRectMake(11, 13, w, 30)];
        starName.textColor = [UIColor colorWithHexString:@"000000"];
        starName.font = [UIFont boldSystemFontOfSize:18];
        //starName.text = @"刘德华";
        [self addSubview:starName];
        
        starLocation = [[UILabel alloc]initWithFrame:CGRectMake(11, 38, 90, 20)];
        starLocation.textColor = [UIColor colorWithHexString:@"666666"];
        starLocation.font = [UIFont systemFontOfSize:11];
        //starLocation.text = @"中国 香港";
        [self addSubview:starLocation];
        
//        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(80, 43, 55, 11)];
//        title.textColor = [UIColor colorWithHexString:@"666666"];
//        title.font = [UIFont systemFontOfSize:10];
//        title.text = @"出生日前:";
//        [self addSubview:title];
        
        time = [[UILabel alloc]initWithFrame:CGRectMake(130, 38, 130, 20)];
        time.textColor = [UIColor colorWithHexString:@"666666"];
        time.font = [UIFont systemFontOfSize:10];
        //time.text = @"出生日前：1961-09-27";
        [self addSubview:time];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(70, 43, 1, 11)];
        line.backgroundColor = [UIColor colorWithHexString:@"bababa"];
        [self addSubview:line];
        self.line = line;
//
//        UILabel *hline = [[UILabel alloc]initWithFrame:CGRectMake(0, 61, w, 1)];
//        hline.backgroundColor = [UIColor colorWithHexString:@"ededed"];
//        [self addSubview:hline];
//        
        UILabel *hline = [[UILabel alloc]initWithFrame:CGRectMake(0, 60.5, SCREEN_WIDTH, 0.5)];
        hline.backgroundColor = [UIColor colorWithHexString:@"bababa"];
        [self addSubview:hline];
    
        UILabel *hline1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        hline1.backgroundColor = [UIColor colorWithHexString:@"bababa"];
        [self addSubview:hline1];
        // hortable = [[UITableView alloc]initWithFrame:CGRectMake(100, -90, 225, 320) style:UITableViewStylePlain];
        //        hortable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 225, 320) style:UITableViewStylePlain];
        //        hortable.delegate = self;
        //        hortable.dataSource = self;
        //        hortable.transform = CGAffineTransformMakeRotation(M_PI / 2 *3);
        //        hortable.showsVerticalScrollIndicator = NO;
        //        [self addSubview:hortable];
        
        //        filmImages = @[[UIImage imageNamed:@"1.jpg"],
        //                       [UIImage imageNamed:@"2.jpg"],
        //                       [UIImage imageNamed:@"3.jpg"],
        //                       [UIImage imageNamed:@"4.jpg"],
        //                       [UIImage imageNamed:@"5.jpg"]];
        
        
    }
    
    return self;
    
}

-(void)setModel:(StarsModel *)model
{
    _model = model;
    
    starName.text = _model.starName;
    starLocation.text = _model.nation;
    time.text = [NSString stringWithFormat:@"出生日前:%@",_model.starBirth];
    
    NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:11]};
    CGSize size = [_model.nation sizeWithAttributes:attr];
    starLocation.frame = CGRectMake(11, 38, size.width, 11);

    self.line.frame = CGRectMake(CGRectGetMaxX(starLocation.frame) + 4, 38, 1, 11);
    time.frame =CGRectMake(CGRectGetMaxX(  self.line.frame) + 4, 38, fDeviceWidth - CGRectGetMaxX(  self.line.frame) + 4, 10);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  DressInstructionCell.m
//  NewCut
//
//  Created by py on 15-7-16.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "DressInstructionCell.h"
#import "PYAllCommon.h"
#import "SDImageView+SDWebCache.h"
#import "HotGoodsModel.h"
@interface DressInstructionCell()

@property(nonatomic ,weak)UIButton *webBtn;
@end
@implementation DressInstructionCell
@synthesize url,goodsBrand,likeCount,commentCount,goodsImage;

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    //UIImage *image;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    
    if (self) {
        
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, w, 1)];
        line.backgroundColor = [UIColor colorWithHexString:@"bababa"];
        [self addSubview:line];
        
        UILabel *bline = [[UILabel alloc]initWithFrame:CGRectMake(0, 136, w, 1)];
        bline.backgroundColor = [UIColor colorWithHexString:@"bababa"];
        [self addSubview:bline];
        
        goodsImage = [[UIImageView alloc]initWithFrame:CGRectMake(11, 7, 81, 120)];
        //image = [UIImage imageNamed:@"16.jpg"];
        //[goodsImage setImage:image];
        
        NSURL *goodUrl=[NSURL URLWithString:url];
        [goodsImage setImageWithURL:goodUrl refreshCache:NO placeholderImage:[UIImage imageNamed:DEFAULT_IMAGE_STAR]];

        [self addSubview:goodsImage];
        
        UIButton *webBtn = [[UIButton alloc]initWithFrame:CGRectMake(w - 16 -39, 16, 39, 39)];
        [webBtn setBackgroundImage:[UIImage imageNamed:@"btn_bu.png"] forState:UIControlStateNormal];
        self.webBtn = webBtn;
        [webBtn addTarget:self action:@selector(webBtnClick) forControlEvents:UIControlEventTouchDown];
        [self addSubview:webBtn];
       
        
        
        
        UILabel *likeLab = [[UILabel alloc]initWithFrame:CGRectMake(113, 102, 25, 12)];
        likeLab.textColor = [UIColor colorWithHexString:@"000000"];
        likeLab.font = [UIFont systemFontOfSize:11];
        likeLab.text = @"喜欢";
        [self addSubview:likeLab];
        
        UILabel *line3 = [[UILabel alloc]initWithFrame:CGRectMake(195, 103, 1, 11)];
        line3.backgroundColor = [UIColor colorWithHexString:@"bababa"];
        [self addSubview:line3];
        
        likeCount = [[UILabel alloc]initWithFrame:CGRectMake(144, 102, 50, 13)];
        likeCount.textColor = [UIColor colorWithHexString:@"000000"];
        likeCount.font = [UIFont systemFontOfSize:12];
        //likeCount.text = self.praiseCount;
        [self addSubview:likeCount];
        
        UILabel *commentLab = [[UILabel alloc]initWithFrame:CGRectMake(232, 102, 25, 12)];
        commentLab.textColor = [UIColor colorWithHexString:@"000000"];
        commentLab.font = [UIFont systemFontOfSize:11];
        commentLab.text = @"评论";
        [self addSubview:commentLab];
        
        commentCount = [[UILabel alloc]initWithFrame:CGRectMake(262, 102, 50, 13)];
        commentCount.textColor = [UIColor colorWithHexString:@"000000"];
        commentCount.font = [UIFont systemFontOfSize:12];
        //commentCount.text = self.relatedCount;
        [self addSubview:commentCount];
        
        //         UILabel *hline = [[UILabel alloc]initWithFrame:CGRectMake(0, 18, w, 1)];
        //         hline.backgroundColor = [UIColor colorWithHexString:@"bababa"];
        //         [self addSubview:hline];
        
        //self.backgroundColor = [UIColor colorWithHexString:@"ededed"];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelAgree) name:@"CANCENAGREE" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(agree) name:@"AGREE" object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setcomment) name:@"GOODCOMMENT" object:nil];
    }
    return self;
    
}
//
//- (void)setcomment
//{
//    int a = [self.commentCount.text intValue] + 1;
//    self.commentCount.text = [NSString stringWithFormat:@"%d条",a];
//}
- (void)agree
{
    int a = [self.likeCount.text intValue] + 1;
    self.likeCount.text = [NSString stringWithFormat:@"%d人",a];
}
- (void)cancelAgree
{

    int a = [self.likeCount.text intValue]- 1;
    self.likeCount.text = [NSString stringWithFormat:@"%d人",a];
//    self.model.goodPraiseCount =  self.likeCount.text;
}
-(void)setModel:(HotGoodsModel *)model
{
    _model = model;
    
    NSURL *url = [NSURL URLWithString:_model.goodPhotoPath];
    [self.goodsImage setImageWithURL:url refreshCache:NO placeholderImage:[UIImage imageNamed:DEFAULT_IMAGE_STAR]];
    
//    UILabel *nameDetail = [[UILabel alloc]initWithFrame:CGRectMake(113, 60, 125, 5)];
//    nameDetail.text = self.model.goodName;
//    nameDetail.textColor = [UIColor colorWithHexString:@"000000"];
//    nameDetail.font = [UIFont systemFontOfSize:13];
//    [self addSubview:nameDetail];
    
    goodsBrand = [[UILabel alloc]initWithFrame:CGRectMake(113, 26, 100, 23)];
    goodsBrand.textColor = [UIColor colorWithHexString:@"3e3e3e"];
    goodsBrand.font = [UIFont boldSystemFontOfSize:12];
    goodsBrand.text = self.model.goodName;
    
    //NSLog(@"%@",goodName);
    [self addSubview:goodsBrand];
    
    likeCount.text = _model.goodPraiseCount;
    commentCount.text = [NSString stringWithFormat:@"%@条",_model.commentCount];
    
        self.webBtn.hidden = !model.webSite;
  
}


- (void)webBtnClick
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.model.webSite]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

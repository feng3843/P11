//
//  FilmCommentCell.m
//  NewCut
//
//  Created by py on 15-7-13.
//  Copyright (c) 2015年 py. All rights reserved.
//



#import "FilmCommentCell.h"
#import "PYAllCommon.h"
#import "CMData.h"
#import "CMAPI.h"
#import "CMTool.h"
#import "SVProgressHUD.h"
#import "DataBaseTool.h"
#import "CommentModel.h"
#import "SDImageView+SDWebCache.h"
@interface FilmCommentCell()

@property(nonatomic ,weak)UIButton *agreenViewBtn;
@end
@implementation FilmCommentCell

@synthesize commentArray,commentLab,badBtn,badCount,agreeBtn,agreeCount,userImage,username,line;

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    CGFloat h=[UIScreen mainScreen].bounds.size.height;
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
            commentLab = [[UILabel alloc] initWithFrame:CGRectMake(11, 0, fDeviceWidth, 15)];
            commentLab.textColor = [UIColor colorWithHexString:@"666666"];
            commentLab.font = [UIFont systemFontOfSize:15];
            commentLab.numberOfLines = 0;
            commentLab.lineBreakMode = NSLineBreakByCharWrapping;
            commentLab.textAlignment = NSTextAlignmentLeft;
        
            username = [[UILabel alloc]init];
            username.textColor = [UIColor colorWithHexString:@"666666"];
            username.font = [UIFont systemFontOfSize:12];
            //username.text = @"ssss";
        
            userImage = [[UIImageView alloc]init];
            UIImage *image = [[UIImage alloc]init];
            image = [UIImage imageNamed:@"agreeBtn"];
            [userImage setImage:image];
            
            [self addSubview:commentLab];
        
//        
//        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(12*h/568, 110*h/568, 296*h/569, 0.5)];
//        line.backgroundColor = [UIColor colorWithHexString:@"bababa"];
//        [self addSubview:line];
    }
    
    return self;
}


-(void) setType:(CommentCellType)type
{
    _type = type;
    
    switch (self.type) {
        case CommentCellTypeOthers:
        {
            
            CommentModel* commentModel = _model;
            CGSize constraint = CGSizeMake(fDeviceWidth - (10 * 2), 2000.0f);
            CGSize size = [commentModel.strDescription sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:constraint lineBreakMode:NSLineBreakByCharWrapping];
    
            [commentLab setFrame:CGRectMake(11, 15, size.width, size.height)];
            
            CGFloat height = CGRectGetMaxY(commentLab.frame);
            userImage = [[UIImageView alloc]initWithFrame:CGRectMake(12, height + 12, 25, 25)];
            userImage.layer.cornerRadius = 13;
            userImage.layer.masksToBounds = YES;
            userImage.backgroundColor = [UIColor redColor];
            if (self.model.strPhoto) {
                NSString *newUrl = [CMRES_BaseURL stringByAppendingString:commentModel.strPhoto];
                NSURL *filmurl=[NSURL URLWithString:newUrl];
                
                [userImage setImageWithURL:filmurl refreshCache:YES placeholderImage:[UIImage imageNamed:DEFAULT_IMAGE_JUZHAO]];
            }else
            {
                userImage.image = [UIImage imageNamed:DEFAULT_IMAGE_JUZHAO];
            }
            [self addSubview:userImage];
       
            username = [[UILabel alloc]initWithFrame:CGRectMake(42, height + 16, 80, 13)];
            username.textColor = [UIColor colorWithHexString:@"666666"];
            username.font = [UIFont systemFontOfSize:12];
//            username.backgroundColor = [UIColor redColor];
            username.text = self.model.strName;
            
            [self addSubview:username];
            
                   line = [[UIView alloc]initWithFrame:CGRectMake(11, height + 49.5, fDeviceWidth - 11, 0.5)];
                    line.backgroundColor = [UIColor colorWithHexString:@"bababa"];
                    [self addSubview:line];
        }
            break;
        case CommentCellTypeAdminGood:
        case CommentCellTypeAdmin:
        {
            CGSize constraint = CGSizeMake(fDeviceWidth - (10 * 2), 2000.0f);
            CGSize size = [_model.strDescription sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:constraint lineBreakMode:NSLineBreakByCharWrapping];
            
            CGFloat height = size.height;
            commentLab.text = _model.strDescription;
           [commentLab setFrame:CGRectMake(11, 0, size.width, height)];
            
        }
        default:
            
            break;
    }
    
    CGFloat height = CGRectGetMaxY(commentLab.frame);
    /**王朋*间距*/
    agreeBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, height+16, 15, 15)];
    [agreeBtn setBackgroundImage:[UIImage imageNamed:@"thumb up"] forState:UIControlStateNormal];
    [agreeBtn setBackgroundImage:[UIImage imageNamed:@"thumb up_1"] forState:UIControlStateSelected];
    [agreeBtn addTarget:self action:@selector(agreeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIButton *agree = [[UIButton alloc] initWithFrame:CGRectMake(180, height, 60, 46)];
//    agree.backgroundColor = [UIColor redColor];
    [agree addTarget:self action:@selector(agreeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:agree];
    badBtn = [[UIButton alloc] initWithFrame:CGRectMake(265, height+16, 15, 15)];
    [badBtn setBackgroundImage:[UIImage imageNamed:@"thumb down"] forState:UIControlStateNormal];
    [badBtn setBackgroundImage:[UIImage imageNamed:@"thumb down_1"] forState:UIControlStateSelected];
    [badBtn addTarget:self action:@selector(badBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIButton *bad = [[UIButton alloc]initWithFrame:CGRectMake(250, height, 60, 46)];
//    bad.backgroundColor = [UIColor redColor];
    [bad addTarget:self action:@selector(badBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bad];
    
    agreeCount = [[UILabel alloc] initWithFrame:CGRectMake(223, height+16, 50, 16)];
    agreeCount.textColor = [UIColor colorWithHexString:@"999999"];
    agreeCount.font = [UIFont systemFontOfSize:15];
    agreeCount.text = self.model.strPraise;
    
    badCount = [[UILabel alloc] initWithFrame:CGRectMake(288, height+16, 20, 16)];
    badCount.textColor = [UIColor colorWithHexString:@"999999"];
    badCount.font = [UIFont systemFontOfSize:15];
    badCount.text = _model.strTsuCount;
    
    [self addSubview:agreeCount];
    [self addSubview:badCount];
    [self addSubview:agreeBtn];
    [self addSubview:badBtn];
}

-(void)setModel:(CommentModel *)model
{
    _model = model;
    

    CommentModel* commentModel = _model;
//    CGSize constraint = CGSizeMake(fDeviceWidth - (11 * 2), 2000.0f);
//    CGSize size = [commentModel.strDescription sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:constraint lineBreakMode:NSLineBreakByCharWrapping];
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



/** 点赞功能*/
- (void)agreeBtnClick
{
    if (![[CMData getToken] isEqualToString:@""]) {
        if(![CMTool isConnectionAvailable]){
            [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
        }else{
       
            if(![CMTool isConnectionAvailable]){
                [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
        }else{
            
            if (agreeBtn.isSelected) return;
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"token"] = [CMData getToken];
            params[@"movieGoodId"] = [self.commentId copy];
            params[@"IdType"] = @(3);
            params[@"type"] = @(1);
   
            [CMAPI postUrl:API_COMMENT_ADDPRAISEORTRAMPLE Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
                
                id result = [detailDict objectForKey:@"code"];
                if(succeed){
                
                    NSString *title = agreeCount.text;
                    int a =  [title intValue] + 1;
                    agreeCount.text = [NSString stringWithFormat:@"%d",a];
                    [DataBaseTool addCollectAgree:self.commentId :@"3"];
                    agreeBtn.selected = YES;
                    if (badBtn.isSelected) {
                        NSString *badTitle = badCount.text;
                        int bad =  [badTitle intValue] - 1;
                        badCount.text = [NSString stringWithFormat:@"%d",bad];
                        badBtn.selected = NO;
                        [DataBaseTool removeCollectStep:self.commentId];
                    }
                 

                }else{
                    NSDictionary *dic=[detailDict valueForKey:@"result"];
                    if(!!dic&&dic.count>0)
                        result=[dic valueForKey:@"reason"];
                    
                    result=[NSString stringWithFormat:@"\n\n\t%@\t\n\n",result];
                    
                    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
                    [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"676767"]];
                    [SVProgressHUD setInfoImage:nil];
                    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
                    [SVProgressHUD showInfoWithStatus:result];
                    
                    
                }
            }];
            
            
        } }
    }else
    {
        if ([self.delegate respondsToSelector:@selector(noLogin)]) {
            [self.delegate noLogin];
        }
          
    }
    
    
    
}

/** 踩的功能*/
- (void)badBtnClick
{
    if (![[CMData getToken] isEqualToString:@""]) {
        if(![CMTool isConnectionAvailable]){
            [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
        }else{
            
            if(![CMTool isConnectionAvailable]){
                [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
            }else{
                
                if (badBtn.isSelected) return;
                NSMutableDictionary *params = [NSMutableDictionary dictionary];
                params[@"token"] = [CMData getToken];
                params[@"movieGoodId"] = [self.commentId copy];
                params[@"IdType"] = @(3);
                params[@"type"] = @(2);
                
                [CMAPI postUrl:API_COMMENT_ADDPRAISEORTRAMPLE Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
                    
                    id result = [detailDict objectForKey:@"code"];
                    if(succeed){
                        
                        NSString *title = badCount.text;
                        int a =  [title intValue] + 1;
                        badCount.text = [NSString stringWithFormat:@"%d",a];
                        [DataBaseTool addCollectStep:self.commentId ];
                        badBtn.selected = YES;
                        if (agreeBtn.isSelected) {
                            NSString *agreeTitle = agreeCount.text;
                            int agree =  [agreeTitle intValue] - 1;
                            agreeCount.text = [NSString stringWithFormat:@"%d",agree];
                            
                            agreeBtn.selected = NO;
                            [DataBaseTool removeCollectAgree:self.commentId :@"3"];
                        }
                      
                        
                    }else{
                        NSDictionary *dic=[detailDict valueForKey:@"result"];
                        if(!!dic&&dic.count>0)
                            result=[dic valueForKey:@"reason"];
                        
                        result=[NSString stringWithFormat:@"\n\n\t%@\t\n\n",result];
                        
                        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
                        [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"676767"]];
                        [SVProgressHUD setInfoImage:nil];
                        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
                        [SVProgressHUD showInfoWithStatus:result];
                        
                        
                    }
                }];
                
                
            } }
    }else
    {
        if ([self.delegate respondsToSelector:@selector(noLogin)]) {
            [self.delegate noLogin];
        }
        
    }

}
@end

//
//  GoodsCommentCell.m
//  NewCut
//
//  Created by py on 15-7-16.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "GoodsCommentCell.h"
#import "PYAllCommon.h"
#import "CMTool.h"
#import "CMAPI.h"
#import "CMData.h"
#import "DataBaseTool.h"
@implementation GoodsCommentCell
@synthesize userImage,badCount,username,commentLab,agreeBtn,badBtn,agreeCount;

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    CGFloat h=[UIScreen mainScreen].bounds.size.height;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // hortable = [[UITableView alloc]initWithFrame:CGRectMake(100, -90, 225, 320) style:UITableViewStylePlain];
        
//        UILabel *hline = [[UILabel alloc]initWithFrame:CGRectMake(0, 260, w, 1)];
//        hline.backgroundColor = [UIColor colorWithHexString:@"bababa"];
//        [self addSubview:hline];
//        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, w, 1)];
//        line.backgroundColor = [UIColor colorWithHexString:@"bababa"];
//        [self addSubview:line];
        
        
        commentLab = [[UILabel alloc] initWithFrame:CGRectMake(11, 15, 320, 16)];
        
        commentLab.textColor = [UIColor colorWithHexString:@"666666"];
        commentLab.font = [UIFont systemFontOfSize:15];
        //NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld",(long)indexPath.row];
        agreeBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, 80, 15, 15)];
        [agreeBtn setBackgroundImage:[UIImage imageNamed:@"thumb up"] forState:UIControlStateNormal];
        [agreeBtn setBackgroundImage:[UIImage imageNamed:@"thumb up_1"] forState:UIControlStateSelected];
        [agreeBtn addTarget:self action:@selector(agreeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        badBtn = [[UIButton alloc] initWithFrame:CGRectMake(265, 80, 15, 15)];
        [badBtn setBackgroundImage:[UIImage imageNamed:@"thumb down"] forState:UIControlStateNormal];
        [badBtn setBackgroundImage:[UIImage imageNamed:@"thumb down_1"] forState:UIControlStateSelected];
        [badBtn addTarget:self action:@selector(badBtnClick) forControlEvents:UIControlEventTouchUpInside];
        agreeCount = [[UILabel alloc] initWithFrame:CGRectMake(227, 82, 50, 16)];
        agreeCount.textColor = [UIColor colorWithHexString:@"999999"];
        agreeCount.font = [UIFont systemFontOfSize:15];
        // agreeCount.text = @"130";
        
        badCount = [[UILabel alloc] initWithFrame:CGRectMake(295, 82, 20, 16)];
        badCount.textColor = [UIColor colorWithHexString:@"999999"];
        badCount.font = [UIFont systemFontOfSize:15];
        badCount.text = @"30";
        
        username = [[UILabel alloc]initWithFrame:CGRectMake(39, 85, 80, 13)];
        username.textColor = [UIColor colorWithHexString:@"666666"];
        username.font = [UIFont systemFontOfSize:12];
        //username.text = @"ssss";
        
        userImage = [[UIImageView alloc]initWithFrame:CGRectMake(12, 78, 25, 25)];
        UIImage *image = [[UIImage alloc]init];
        image = [UIImage imageNamed:@"agreeBtn"];
        [userImage setImage:image];
        
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(12*h/568, 110*h/568, 296*h/568, 0.5)];
        line.backgroundColor = [UIColor colorWithHexString:@"bababa"];
        [self addSubview:line];
        
        [self addSubview:commentLab];
        [self addSubview:agreeBtn];
        [self addSubview:badBtn];
        [self addSubview:agreeCount];
        [self addSubview:badCount];
        [self addSubview:username];
        [self addSubview:userImage];

        
    }
    
    return self;
    
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
                
                if (agreeBtn.isSelected ) return;
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
                params[@"Type"] = @(2);
                
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

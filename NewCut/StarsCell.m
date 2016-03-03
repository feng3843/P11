//
//  StarsCell.m
//  NewCut
//
//  Created by py on 15-7-11.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "StarsCell.h"
#import "PYAllCommon.h"
#import "CMTool.h"
#import "CMAPI.h"
#import "CMDefault.h"

@implementation StarsCell
@synthesize images2,images1,name,starId,starInfo,starName,starPhoto,content,starImageView,starNameLab;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
//    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    CGFloat h=[UIScreen mainScreen].bounds.size.height;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        starImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8*h/568 , 3, 95 , 138*h/568 )];
        starNameLab = [[UILabel alloc] initWithFrame:CGRectMake(8*h/568, 146*h/568, 95*h/568 , 13*h/568 )];
        starNameLab.font = [UIFont systemFontOfSize:13*h/568];
        starNameLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:starNameLab];
        [self addSubview:starImageView];
        
//        hortable = [[UITableView alloc]initWithFrame:CGRectMake(70  , -60 , 170 , w) style:UITableViewStylePlain];
//        
//        hortable.showsVerticalScrollIndicator = NO;
//        hortable.delegate = self;
//        hortable.dataSource = self;
//        hortable.transform = CGAffineTransformMakeRotation(M_PI / 2 *3);
//        [self addSubview:hortable];
        
        
//        name = [NSArray arrayWithObjects:@"娄艺潇",@"钟汉良",@"杨幂",@"杨颖",@"孙红雷",nil];
//        images1 = @[[UIImage imageNamed:@"aa.jpg"],
//                    [UIImage imageNamed:@"bb.jpg"],
//                    [UIImage imageNamed:@"cc.jpg"],
//                    [UIImage imageNamed:@"dd.jpg"],
//                    [UIImage imageNamed:@"g.jpg"]];
//        // [self.filmView setImages:images1];
//        
//        images2 = @[[UIImage imageNamed:@"lou.jpg"],
//                    [UIImage imageNamed:@"zhong.jpg"],
//                    [UIImage imageNamed:@"yang.jpg"],
//                    [UIImage imageNamed:@"yangy.jpg"],
//                    [UIImage imageNamed:@"sun.jpg"]];
//        
//        starInfo = [[NSDictionary alloc] init];
//        starPhoto = [[NSMutableArray alloc] init];
//        starName = [[NSMutableArray alloc] init];
//        starId = [[NSMutableArray alloc] init];
//        content = [[NSMutableArray alloc] init];
        
        
         }
    return self;
}

//-(void)getStarPhoto{
//
//    if(![CMTool isConnectionAvailable]){
//        
//        [SVProgressHUD showInfoWithStatus:@"网络没有连接！"];
//    }else{
//        
//        [CMAPI postUrl:API_STAR_GETSTARNAME Param:nil Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
//            
//            id result = [detailDict objectForKey:@"code"];
//            if(succeed){
//                
//                starInfo = [detailDict objectForKey:@"result"];
//                content = [starInfo objectForKey:@"star"];
//                for(int i=0; i<content.count; i++){
//                    
//                    NSString *Id = [content[i] objectForKey:@"starId"];
//                    NSString *Name = [content[i] objectForKey:@"starName"];
//                    NSString *Path = [content[i] objectForKey:@"starPhoto"];
//                    
//                    [starId addObject:Id];
//                    [starName addObject:Name];
//                    [starPhoto addObject:Path];
//                    //[SVProgressHUD showInfoWithStatus:Name];
//                    
//                   // NSLog(@"%@",Id);
//                    //NSLog(@"%@",Name);
//                   // NSLog(@"%@",Path);
//                    
//                }
//                
//            }else{
//                
//                NSDictionary *dic=[detailDict valueForKey:@"result"];
//                if(!!dic&&dic.count>0)
//                    result=[dic valueForKey:@"reason"];
//                
//                result=[NSString stringWithFormat:@"\n\n\t%@\t\n\n",result];
//                
//                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
//                [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"676767"]];
//                [SVProgressHUD setInfoImage:nil];
//                [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
//                [SVProgressHUD showInfoWithStatus:result];
//                
//                
//            }
//        }];
//        
//        
//    }
//
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    CGFloat h=[UIScreen mainScreen].bounds.size.height;
//    return 110;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    
//    return  [images2 count];
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    CGFloat w=[UIScreen mainScreen].bounds.size.width;
//    CGFloat h=[UIScreen mainScreen].bounds.size.height;
//    UIImageView *filmImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15*h/568 , 0, 95 , 120*h/568 )];
//    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(40*h/568, 125*h/568, 100*h/568 , 20*h/568 )];
//    
//    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld",(long)indexPath.row];
//    //NSLog(@"porsection---->%ld",(long)porsection);
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil){
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        cell.transform = CGAffineTransformMakeRotation(M_PI/2);
//        
//        [filmImageView setImage:[images2 objectAtIndex:indexPath.row]];
//        nameLab.text = [name objectAtIndex:indexPath.row];
//        nameLab.textColor = [UIColor colorWithHexString:@"000000"];
//        nameLab.font = [UIFont systemFontOfSize:15 *h/568];
//        [cell addSubview:filmImageView];
//        [cell addSubview:nameLab];
//        //[[cell textLabel] setText:[_dataArray1 objectAtIndex:indexPath.row]];
//        //cell.textLabel.numberOfLines = 0;
//        //cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
//        
//    }
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"点击%ld",(long)[indexPath row]);
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"transStars" object:nil];
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


//-(void)setUpCellWithArray:(NSArray *)array
//{
//    CGFloat xbase = 95;
//    CGFloat width = 95;
//    
//    [self.StarsScrollView setScrollEnabled:YES];
//    [self.StarsScrollView setShowsHorizontalScrollIndicator:NO];
//    
//    // UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.filmScroll.frame.size.width, filmScroll.frame.size.height)];
//    
//    //[self.filmScroll addSubview:imageView];
//    for(int i = 0; i < [array count]; i++)
//    {
//        UIImage *image = [array objectAtIndex:i];
//        //[imageView setImage:image];
//        UIView *custom = [self createCustomViewWithImage: image];
//        [custom setBackgroundColor:[UIColor blueColor]];
//        [self.StarsScrollView addSubview:custom];
//        [custom setFrame:CGRectMake(xbase,StarsScrollView.frame.origin.y,self.StarsScrollView.frame.size.width, 100)];
//        xbase += 8 + width;
//        
//        
//    }
//    
//    [self.StarsScrollView setContentSize:CGSizeMake(xbase,self.StarsScrollView.frame.size.height)];
//    self.StarsScrollView.delegate = self;
//    
//}
//
//-(UIView *)createCustomViewWithImage:(UIImage *)image
//{
//    
//    UIView *custom = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 170, 140)];
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 95, 140)];
//    [imageView setImage:image];
//    [imageView setBackgroundColor:[UIColor blueColor]];
//    [custom addSubview:imageView];
//    [custom setBackgroundColor:[UIColor blueColor]];
//    
//    //    UITapGestureRecognizer *singleFingerTap =
//    //    [[UITapGestureRecognizer alloc] initWithTarget:self
//    //                                            action:@selector(handleSingleTap:)];
//    //    [custom addGestureRecognizer:singleFingerTap];
//    
//    return custom;
//}
//

@end

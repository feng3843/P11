//
//  DressImageCell.m
//  NewCut
//
//  Created by py on 15-7-16.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "DressImageCell.h"
#import "PYAllCommon.h"
#import "myCollectionViewController.h"

@implementation DressImageCell
@synthesize DressImages,DressImageView;


- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    //CGRect bounds = [[UIScreen mainScreen] bounds];
    //self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, height)];
    if (self) {
        // hortable = [[UITableView alloc]initWithFrame:CGRectMake(100, -90, 225, 320) style:UITableViewStylePlain];
        hortable = [[UITableView alloc]initWithFrame:CGRectMake(15, -15, 290, w) style:UITableViewStylePlain];
        hortable.delegate = self;
        hortable.dataSource = self;
        hortable.separatorStyle = UITableViewCellSelectionStyleNone;
        hortable.transform = CGAffineTransformMakeRotation(M_PI / 2 *3);
        hortable.showsVerticalScrollIndicator = NO;
        hortable.pagingEnabled = YES;
        [self addSubview:hortable];
        
        //“全部”按钮
        UIImage* imageGoAll = [UIImage imageNamed:@"bt_all.png"];
        UIButton *btnGoAll = [UIButton buttonWithType:UIButtonTypeCustom];
        btnGoAll.frame = CGRectMake(281, 90, 39, 101);
        [btnGoAll setBackgroundImage:imageGoAll forState:UIControlStateNormal];
        [btnGoAll addTarget:self action: @selector(notificationJump) forControlEvents: UIControlEventTouchUpInside];
        [self addSubview:btnGoAll];
        
        UILabel *hline = [[UILabel alloc]initWithFrame:CGRectMake(0, 290, w, 1)];
        hline.backgroundColor = [UIColor colorWithHexString:@"bababa"];
        [self addSubview:hline];
        
        
//        DressImages = @[[UIImage imageNamed:@"11.jpg"],
//                        [UIImage imageNamed:@"12.jpg"],
//                        [UIImage imageNamed:@"13.jpg"],
//                        [UIImage imageNamed:@"14.jpg"],[UIImage imageNamed:@"15.jpg"],[UIImage imageNamed:@"16.jpg"]
//                        ];
        
    }
    
    return self;

}


//跳转到全部
-(void)notificationJump
{
    
    
    
    if ([self.delegate respondsToSelector:@selector(jump2BrowseImageViewController:)]) {
        [self.delegate jump2BrowseImageViewController:GoodType];
    }
}


//跳转到全部
-(IBAction)btnGoAll_Click:(id)sender{
//    NSLog(@"跳转到全部 good");
//    [_delegate jump2BrowseImageViewController:GoodType];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  [DressImages count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIImageView *dressImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 290)];
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%d",indexPath.row];
    
    //NSLog(@"porsection---->%d",porsection);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.transform = CGAffineTransformMakeRotation(M_PI/2);
        
        //[dressImageView setImage:[DressImages objectAtIndex:indexPath.row]];
        NSURL* url = [NSURL URLWithString:[DressImages objectAtIndex:indexPath.row]];
        [dressImageView setImageWithURL:url refreshCache:NO placeholderImage:[UIImage imageNamed:DEFAULT_IMAGE_FILM]];
        [cell addSubview:dressImageView];
        
        
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 320;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"点击%d",[indexPath row]);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

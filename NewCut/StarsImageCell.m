//
//  StarsImageCell.m
//  NewCut
//
//  Created by py on 15-7-14.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "StarsImageCell.h"
#import "PYAllCommon.h"
#import "SDImageView+SDWebCache.h"
#import "EnumList.h"

@implementation StarsImageCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    //CGRect bounds = [[UIScreen mainScreen] bounds];
    //self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, height)];
    if (self) {
        // hortable = [[UITableView alloc]initWithFrame:CGRectMake(100, -90, 225, 320) style:UITableViewStylePlain];
        hortable = [[UITableView alloc]initWithFrame:CGRectMake(25, -25, 270, 320) style:UITableViewStylePlain];
        hortable.delegate = self;
        hortable.dataSource = self;
        hortable.transform = CGAffineTransformMakeRotation(M_PI / 2 *3);
        hortable.showsVerticalScrollIndicator = NO;
        hortable.pagingEnabled = YES;
        [self addSubview:hortable];
        
        //“全部”按钮
        UIImage* imageGoAll = [UIImage imageNamed:@"bt_all.png"];
        UIButton *btnGoAll = [UIButton buttonWithType:UIButtonTypeCustom];
        btnGoAll.frame = CGRectMake(SCREEN_WIDTH - 39, 90, 39, 101);
        [btnGoAll setBackgroundImage:imageGoAll forState:UIControlStateNormal];
        [btnGoAll addTarget:self action: @selector(notificationJump) forControlEvents: UIControlEventTouchUpInside];
        [self addSubview:btnGoAll];
        
        UILabel *hline = [[UILabel alloc]initWithFrame:CGRectMake(0, 270, SCREEN_WIDTH, 1)];
        hline.backgroundColor = [UIColor colorWithHexString:@"bababa"];
        [self addSubview:hline];
    }

    return self;

}

//-(void)setStarsImages:(NSMutableArray *)starsImages
//{
//    _starsImages = starsImages;
//    
//    if (self.starsImages.count == 0) {
//        [self.starsImages addObject:@""];
//    }
//}

- (NSMutableArray *)starsImages
{
    if (_starsImages == nil) {
        _starsImages = [NSMutableArray array];
    }
    return _starsImages;
}

//跳转到全部
-(void)notificationJump
{
    if ([self.delegate respondsToSelector:@selector(jump2BrowseImageViewController:)]) {
        [self.delegate jump2BrowseImageViewController:StarsType];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [self.starsImages count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIImageView *starsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 270)];
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld",indexPath.row];
    
    NSString *url = [self.starsImages objectAtIndex:indexPath.row];
    NSString *newUrl = [CMRES_ImageURL stringByAppendingString:url];
    NSURL *starurl = [NSURL URLWithString:newUrl];
    //NSLog(@"porsection---->%d",porsection);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.transform = CGAffineTransformMakeRotation(M_PI/2);
        
        [starsImageView setImageWithURL:starurl refreshCache:NO placeholderImage:[UIImage imageNamed:DEFAULT_IMAGE_FILM]];
        [cell addSubview:starsImageView];
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

//
//  DressHeadImageCell.m
//  NewCut
//
//  Created by py on 15-7-15.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "DressHeadImageCell.h"
#import "PYAllCommon.h"

@implementation DressHeadImageCell
@synthesize DressImages;

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
        hortable = [[UITableView alloc]initWithFrame:CGRectMake(95, -80, 130, 320) style:UITableViewStylePlain];
        hortable.delegate = self;
        hortable.dataSource = self;
        hortable.transform = CGAffineTransformMakeRotation(M_PI / 2 *3);
        hortable.showsVerticalScrollIndicator = NO;
        [self addSubview:hortable];
        
        UILabel *hline = [[UILabel alloc]initWithFrame:CGRectMake(0, 270, w, 1)];
        hline.backgroundColor = [UIColor colorWithHexString:@"bababa"];
        [self addSubview:hline];
        
//        
//        DressImages = @[[UIImage imageNamed:@"aa.jpg"],
//                        [UIImage imageNamed:@"bb.jpg"],
//                        [UIImage imageNamed:@"cc.jpg"],
//                        [UIImage imageNamed:@"dd.jpg"]
//                        ];
        
    }
    
    return self;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [DressImages count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIImageView *dressImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 270)];
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld",(long)indexPath.row];
    
   // NSLog(@"porsection---->%ld",(long)porsection);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.transform = CGAffineTransformMakeRotation(M_PI/2);
        
        [dressImageView setImage:[DressImages objectAtIndex:indexPath.row]];
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
    NSLog(@"点击%ld",(long)[indexPath row]);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

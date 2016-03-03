//
//  JoinFilmCell.m
//  NewCut
//
//  Created by py on 15-7-14.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "JoinFilmCell.h"
#import "PYAllCommon.h"
#import "SDImageView+SDWebCache.h"

@implementation JoinFilmCell
@synthesize filmImages,filmName,time,filmId;

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(11, 12, 70, 16)];
        title.textColor = [UIColor colorWithHexString:@"000000"];
        title.font = [UIFont boldSystemFontOfSize:15];
        title.text = @"参演电影";
        [self addSubview:title];
        
        hortable = [[UITableView alloc]initWithFrame:CGRectMake(101, -50, 140, w) style:UITableViewStylePlain];
        hortable.delegate = self;
        hortable.dataSource = self;
        hortable.transform = CGAffineTransformMakeRotation(M_PI / 2 *3);
        hortable.showsVerticalScrollIndicator = NO;
        hortable.separatorStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:hortable];
        
        UILabel *hline = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, w, 0.5)];
        hline.backgroundColor = [UIColor colorWithHexString:@"ededed"];
        [self addSubview:hline];
        
        self.type = PYHTableCellMovie;
    }
    return self;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.arrayModel count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIImageView *filmImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 95)];
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 70, 12)];
    name.textColor = [UIColor colorWithHexString:@"333333"];
    name.textAlignment = NSTextAlignmentCenter;
    name.font = [UIFont systemFontOfSize:11];
    
    UILabel *birthYear = [[UILabel alloc]initWithFrame:CGRectMake(0, 114, 70, 11)];
    birthYear.textColor = [UIColor colorWithHexString:@"666666"];
    birthYear.textAlignment = NSTextAlignmentCenter;
    birthYear.font = [UIFont systemFontOfSize:10];
    MovieModel* model = [self.arrayModel objectAtIndex:indexPath.row];
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld",(long)indexPath.row];
    NSString *url = model.filmImage;
    NSURL *filmurl=[NSURL URLWithString:url];
    
   // NSLog(@"porsection---->%d",porsection);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.transform = CGAffineTransformMakeRotation(M_PI/2);
        [filmImageView setImageWithURL:filmurl refreshCache:NO placeholderImage:[UIImage imageNamed:DEFAULT_IMAGE_STAR]];
        
        name.text = model.filmName;
        birthYear.text = model.movieYear;
        [cell addSubview:filmImageView];
        [cell addSubview:name];
        [cell addSubview:birthYear];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(jump2Detail:Type:)])
    {
        PYBaseObject* object = [self.arrayModel objectAtIndex:indexPath.row];
        [self.delegate jump2Detail:object.strID Type:self.type];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

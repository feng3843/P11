//
//  JoinStarsCell.m
//  NewCut
//
//  Created by py on 15-7-13.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "JoinStarsCell.h"
#import "PYAllCommon.h"
#import "SDImageView+SDWebCache.h"
#import "StarsModel.h"

#define HEIGHT 180
#define LEFT DEFAULT_LEFT
#define TOP 38
#define BOTTOM 14

#define TABLE_HEIGHT (HEIGHT - TOP - BOTTOM)
#define TABLE_WIDTH (SCREEN_WIDTH - LEFT)

#define IMAGE_HEIGHT 95
#define IMAGE_WIDTH 70
/**王朋**/
#define BLANK 4


#define NAME @"明星阵容"
#define NOTICATION @"star"

@implementation JoinStarsCell

- (void)awakeFromNib {
    
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(DEFAULT_LEFT, 0, SCREEN_WIDTH, TOP)];
        title.textColor = [UIColor colorWithHexString:@"000000"];
        title.font = [UIFont boldSystemFontOfSize:15];
        title.textAlignment = NSTextAlignmentLeft;
        title.text = NAME;
        [self addSubview:title];
        
        if(!hortable)
        {
            hortable = [[UITableView alloc]initWithFrame:CGRectMake(LEFT + (TABLE_WIDTH - TABLE_HEIGHT)/2,
                                                                    TOP + (TABLE_HEIGHT - TABLE_WIDTH)/2,
                                                                    TABLE_HEIGHT,
                                                                    TABLE_WIDTH) style:UITableViewStylePlain];
            hortable.delegate = self;
            hortable.dataSource = self;
            hortable.transform = CGAffineTransformMakeRotation(M_PI / 2 *3);
            hortable.showsVerticalScrollIndicator = NO;
            hortable.separatorStyle = UITableViewCellSelectionStyleNone;
            [self addSubview:hortable];
        }
        
        
//        UILabel *hline = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT - 1, WIDTH, 1)];
//        hline.backgroundColor = [UIColor colorWithHexString:@"bababa"];
//        [self addSubview:hline];
        self.type = PYHTableCellStar;
    }
    
    return self;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayModel count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StarsModel* model = [self.arrayModel objectAtIndex:indexPath.row];
   /**王朋**/
    UIImageView *filmImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 95)];
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 70, 12)];
    name.textColor = [UIColor colorWithHexString:@"333333"];
    name.textAlignment = NSTextAlignmentCenter;
    name.font = [UIFont systemFontOfSize:11];
    
    UILabel *birthYear = [[UILabel alloc]initWithFrame:CGRectMake(0, 114, 70, 11)];
    birthYear.textColor = [UIColor colorWithHexString:@"666666"];
    birthYear.textAlignment = NSTextAlignmentCenter;
    birthYear.font = [UIFont systemFontOfSize:10];
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld",(long)indexPath.row];
    
   // NSLog(@"porsection---->%d",porsection);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *url = model.starImage;
    NSURL *filmurl=[NSURL URLWithString:url];

    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.transform = CGAffineTransformMakeRotation(M_PI/2);
        
        [filmImageView setImageWithURL:filmurl refreshCache:NO placeholderImage:[UIImage imageNamed:DEFAULT_IMAGE_STAR]];
        
        name.text = model.starName;
        birthYear.text = model.starBirth;
        [cell addSubview:filmImageView];
        [cell addSubview:name];
        [cell addSubview:birthYear];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return IMAGE_WIDTH + BLANK;
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

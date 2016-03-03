//
//  PopularGoodsCell.m
//  NewCut
//
//  Created by py on 15-7-12.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "PYHTableCell.h"
#import "PYAllCommon.h"
#import "SDImageView+SDWebCache.h"
#import "UIScrollView+MJRefresh.h"
/****王朋****/
#define HEIGHT 194
#define LEFT DEFAULT_LEFT
#define TOP 38
#define BOTTOM 19

#define TABLE_HEIGHT (HEIGHT - TOP - BOTTOM)
#define TABLE_WIDTH (SCREEN_WIDTH - LEFT)

#define IMAGE_HEIGHT TABLE_HEIGHT
#define IMAGE_WIDTH TABLE_HEIGHT
/**王朋****/
#define BLANK 4

#define NAME @""
#define NOTICATION @""

@implementation PYHTableCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        _arrayModel = [[NSMutableArray alloc] init];
        
    }
    return self;
}


/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //    [hortable addHeaderWithTarget:self action:@selector(headerRereshing)];
    //#warning 自动刷新(一进入程序就下拉刷新)
    //    [hortable headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
//    [hortable addFooterWithTarget:self action:@selector(footerRereshing)];
    
    //    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    //    hortable.headerPullToRefreshText = NSLocalizedString(@"", @"");
    //    hortable.headerReleaseToRefreshText = NSLocalizedString(@"", @"");
    //    hortable.headerRefreshingText = NSLocalizedString(@"", @"");
    
//    hortable.footerPullToRefreshText = NSLocalizedString(@"", @"");
//    hortable.footerReleaseToRefreshText = NSLocalizedString(@"", @"");
//    hortable.footerRefreshingText = NSLocalizedString(@"", @"");
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if([self.delegate respondsToSelector:@selector(loadOldData:Type:)])
        {
            [self.delegate loadNewData:self.page Type:self.type];
        }
    });
}

- (void)footerRereshing
{
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.page++;
        if([self.delegate respondsToSelector:@selector(loadOldData:Type:)])
        {
            [self.delegate loadOldData:self.page Type:self.type];
        }
    });
}

-(void)reloadData
{
    [hortable reloadData];
    
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [hortable headerEndRefreshing];
    [hortable footerEndRefreshing];
}

-(void)setArrayModel:(NSMutableArray *)arrayModel
{
    _arrayModel = arrayModel;
    
    if(!hortable)
    {
        hortable = [[UITableView alloc]initWithFrame:CGRectMake(LEFT + (TABLE_WIDTH - TABLE_HEIGHT)/2,
                                                                TOP + (TABLE_HEIGHT - TABLE_WIDTH)/2,
                                                                TABLE_HEIGHT,
                                                                TABLE_WIDTH) style:UITableViewStylePlain];
        hortable.delegate = self;
        hortable.dataSource = self;
        
        hortable.transform = CGAffineTransformMakeRotation(M_PI * 1.5);
        hortable.showsVerticalScrollIndicator = NO;
        //    hortable.backgroundColor = [UIColor colorWithHexString:@"ededed"];
        //    hortable.rowHeight = TABLE_WIDTH;
        //    hortable.estimatedRowHeight = TABLE_WIDTH;
        hortable.backgroundColor = [UIColor clearColor];
        hortable.separatorStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:hortable];
    }
    
    [self setupRefresh];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(DEFAULT_LEFT, 0, SCREEN_WIDTH * 0.5, TOP)];
    title.textColor = [UIColor colorWithHexString:@"000000"];
    title.font = [UIFont boldSystemFontOfSize:15];
    title.textAlignment = NSTextAlignmentLeft;
    title.text = self.strName;
    [self addSubview:title];
    
    
}

-(void)setCount:(NSString *)count
{
    _count = count;
    if (_count) {
        UILabel *count2 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - DEFAULT_RIGHT - SINGLE_WORD_WIDTH, 0 , SINGLE_WORD_WIDTH, TOP)];
        count2.textColor = [UIColor colorWithHexString:@"666666"];
        count2.font = [UIFont systemFontOfSize:14];
        count2.text = @"张";
//        count2.backgroundColor = [UIColor yellowColor];
        [self addSubview:count2];
        
        UILabel* counLab = [[UILabel alloc]initWithFrame:CGRectMake(1, 0, 1, TOP)];
        counLab.textColor = [UIColor colorWithHexString:@"666666"];
        counLab.font = [UIFont fontWithName:@"Helvetica Neue " size:15];
        counLab.text = [NSString stringWithFormat:@"%@",count];
//        counLab.backgroundColor = [UIColor yellowColor];
        UILabel* __label = counLab;
        __label.numberOfLines = 1;
        __label.lineBreakMode = NSLineBreakByWordWrapping;
        //设置一个行高上限
        CGSize size = SCREEN_SIZE;
        CGSize labelsize = [__label.text sizeWithFont:__label.font constrainedToSize:size lineBreakMode:__label.lineBreakMode];
        __label.frame = CGRectMake(0, 0, labelsize.width, TOP);
        counLab = __label;
        
        CGRect frame = counLab.frame;
        frame.origin.x = CGRectGetMinX(count2.frame) - frame.size.width;
        frame.origin.y = 0;
        counLab.frame = frame;
        [self addSubview:counLab];
        
        UILabel *count1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(counLab.frame) - SINGLE_WORD_WIDTH, 0, SINGLE_WORD_WIDTH, TOP)];
        count1.textColor = [UIColor colorWithHexString:@"666666"];
        count1.font = [UIFont boldSystemFontOfSize:14];
        count1.text = @"共";
        [self addSubview:count1];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [self.arrayModel count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIImageView *filmImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, IMAGE_WIDTH, IMAGE_HEIGHT)];
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld",(long)indexPath.row];
    
    HotGoodsModel* model = [self.arrayModel objectAtIndex:indexPath.row];
    NSString *url = model.goodPhotoPath;
    NSURL *goodurl=[NSURL URLWithString:url];
    // NSLog(@"porsection---->%d",porsection);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.transform = CGAffineTransformMakeRotation(M_PI/2);
        
        [filmImageView setImageWithURL:goodurl refreshCache:NO placeholderImage:[UIImage imageNamed:DEFAULT_IMAGE_JUZHAO]];
        [cell addSubview:filmImageView];
        
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
    if ([self.delegate respondsToSelector:@selector(jump2Detail:Type:)]) {
        
        PYBaseObject* object = [self.arrayModel objectAtIndex:indexPath.row];
        [self.delegate jump2Detail:object.strID Type:self.type];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

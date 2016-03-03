//
//  StarsIntructionCell.m
//  NewCut
//
//  Created by py on 15-7-14.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "StarsIntructionCell.h"
#import "PYAllCommon.h"
#import "SDImageView+SDWebCache.h"
#import "StarsModel.h"

@implementation StarsIntructionCell
@synthesize instructImage,starImage,starsIntruction;

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // hortable = [[UITableView alloc]initWithFrame:CGRectMake(100, -90, 225, 320) style:UITableViewStylePlain];
//        hortable = [[UITableView alloc]initWithFrame:CGRectMake(100, 0, 220, 138) style:UITableViewStylePlain];
//        hortable.delegate = self;
//        hortable.dataSource = self;
//        hortable.separatorStyle = UITableViewCellAccessoryNone;
//        // hortable.transform = CGAffineTransformMakeRotation(M_PI / 2 *3);
//        hortable.showsVerticalScrollIndicator = NO;
//        [self addSubview:hortable];
        
        fileText = [[UITextView alloc]initWithFrame:CGRectMake(100, 4, 209, 123)];
        //        fileText.backgroundColor = [UIColor redColor];
        fileText.font = [UIFont systemFontOfSize:13];
        [fileText setTextColor:[UIColor colorWithHexString:@"3e3e3e"]];
        [self addSubview:fileText];
        fileText.editable = NO;
        fileText.selectable = NO;
       // NSString *
        starImage = [[UIImageView alloc]initWithFrame:CGRectMake(11, 9, 80, 120)];
        starImage.backgroundColor = [UIColor clearColor];
        //NSString *url = [CMRES_BaseURL stringByAppendingString:instructImage];
        //UIImage* image=[[UIImage alloc]init];
        //image = [UIImage imageNamed:@"aa.jpg"];
        //[starImage setImageWithURL:url];
        [self addSubview:starImage];
        
        UILabel *hline = [[UILabel alloc]initWithFrame:CGRectMake(0, 139, w, 0.5)];
        hline.backgroundColor = [UIColor colorWithHexString:@"bababa"];
        [self addSubview:hline];
        
//        filmIntruction = @"dddddddddddddffdsdsdsgdsggtgrthkrhkhlthkrhkrtkhkrthkrthkrthkrthkrthkrthkrthkrthkrthkrthhjjrkthrthrtklglrtkglrtklrtkrtktlrgklrtgklrtgklrtgklrtgklrtkglrtgklrtkglrtkglrtgklrtkglrtkhltrkglrtkhlrthklrthktrlhlrthjlrthkrthlrtkhlrtkgtrkgltrhkglrtkhlrthlrtkhlrthklrtkhltrkghlrtkghlrthkkhhhhhhhhhhhhhhhhhhhhhhhhhhhrreeterteyrtyythhythtyhfskdfkkfwkfwpqwerpqoeqfjgjrgvnskdekrehfnvnmsdvowqflkmcs,mjhgfjewvvmdsdm,svmvdsmvdsmvmmmvm,svdsmmsvdmdsvmvsdm,sv,msvm,vsvvvs,mvsm,svm,svmsvmvsmvv,msdm,vdsv,ds,mvsdm,vsdm,vdsmvdsm,mvds,mvds,,mvsdaaaaaaaaaawwwwwww222222222";

        
        
        //        filmImages = @[[UIImage imageNamed:@"aa.jpg"],
        //                       [UIImage imageNamed:@"bb.jpg"],
        //                       [UIImage imageNamed:@"cc.jpg"],
        //                       [UIImage imageNamed:@"dd.jpg"]
        //                       ];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;

}

-(void)setModel:(StarsModel *)model
{
    _model = model;
    
    //NSString *url = [CMRES_BaseURL stringByAppendingString:imageUrl];
    NSURL *url = [NSURL URLWithString:_model.starImage];
    
    [starImage setImageWithURL:url refreshCache:NO placeholderImage:[UIImage imageNamed:DEFAULT_IMAGE_STAR]];
    
    starsIntruction = _model.starRelated;
    fileText.text = starsIntruction;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    CGFloat contentWidth = hortable.frame.size.width;
    CGSize constraint = CGSizeMake(contentWidth, 2000.0f);
    CGSize size = [starsIntruction sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:constraint lineBreakMode:NSLineBreakByCharWrapping];
    
    // CGFloat height = MAX(size.height, 44.0f);
    CGFloat height = size.height;
    
    UILabel *indructionLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 16, 200, w *height/414)];
    indructionLab.textColor = [UIColor colorWithHexString:@"3e3e3e"];
    indructionLab.font = [UIFont systemFontOfSize:12];
    indructionLab.numberOfLines = 0;
    indructionLab.lineBreakMode = NSLineBreakByCharWrapping;
    
    indructionLab.text = starsIntruction;
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld",(long)indexPath.row];
    
   // NSLog(@"porsection---->%d",porsection);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //cell.transform = CGAffineTransformMakeRotation(M_PI/2);
        
        // [filmImageView setImage:[filmImages objectAtIndex:indexPath.row]];
        [cell addSubview:indructionLab];
        
        
    }
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    CGSize size = [hortable systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    CGFloat contentWidth = hortable.frame.size.width;
    
    CGSize constraint = CGSizeMake(contentWidth, 2000.0f);
    CGSize size = [starsIntruction sizeWithFont:[UIFont systemFontOfSize:w * 12/414] constrainedToSize:constraint lineBreakMode:NSLineBreakByCharWrapping];
    
    CGFloat height = size.height;
    return height +1;
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

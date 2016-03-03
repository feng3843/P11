//
//  FilmIntructionCell.m
//  NewCut
//
//  Created by py on 15-7-12.
//  Copyright (c) 2015年 py. All rights reserved.
//
#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f

#import "FilmIntructionCell.h"
#import "PYAllCommon.h"
#import "SDImageView+SDWebCache.h"
#import "MovieModel.h"

@implementation FilmIntructionCell
@synthesize movieImagePath,filmImage,filmIntruction;

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
//        
//        UIScrollView *scrollview = [[UIScrollView alloc]init];
        
        fileText = [[UITextView alloc]initWithFrame:CGRectMake(100, 4, 209, 123)];
//        fileText.backgroundColor = [UIColor redColor];
        fileText.font = [UIFont systemFontOfSize:13];
        [fileText setTextColor:[UIColor colorWithHexString:@"3e3e3e"]];
        [self addSubview:fileText];
        fileText.editable = NO;
        fileText.selectable = NO;


        filmImage = [[UIImageView alloc]initWithFrame:CGRectMake(11, 9, 80, 120)];
        [self addSubview:filmImage];
        
//        UILabel *hline = [[UILabel alloc]initWithFrame:CGRectMake(0, 138, w, 0.5)];
//        hline.backgroundColor = [UIColor colorWithHexString:@"bababa"];
//        [self addSubview:hline];

        
        
    }
    
    return self;

}

-(void)setModel:(MovieModel *)model
{
    _model = model;
    
    NSURL *url = [NSURL URLWithString:_model.filmImage];
    
    filmIntruction = model.movieRelated;
    [filmImage setImageWithURL:url refreshCache:NO placeholderImage:[UIImage imageNamed:DEFAULT_IMAGE_STAR]];
    fileText.text = filmIntruction;

}

@end

//
//  FilmIntructionCell.h
//  NewCut
//
//  Created by py on 15-7-12.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MovieModel;
@interface FilmIntructionCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *hortable;
    NSInteger porsection;
    UIWebView *intructionView;
    NSString *filmIntruction;
    UITextView *fileText;
    
}
@property (nonatomic,strong) MovieModel* model;

@property(nonatomic,strong) NSMutableArray *movieImagePath;
@property(nonatomic,strong) UIImageView *filmImage;
@property(nonatomic,strong) NSString *filmIntruction;;
@end

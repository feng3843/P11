//
//  zxViewController.m
//  NewCut
//
//  Created by ivy.sun on 16/2/24.
//  Copyright © 2016年 py. All rights reserved.
//

#import "zxViewController.h"

#import "PYAllCommon.h"

#import "SDImageView+SDWebCache.h"

@interface zxViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation zxViewController

static  NSString *ID =@"cell" ;
-(NSArray *)filmImages
{
    if (_filmImages==nil) {
        _filmImages = [NSMutableArray array];
    }
    return _filmImages;
}

- (void)viewDidLoad {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    collectionView.delegate=self;
    collectionView.dataSource = self;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    collectionView.backgroundColor = [UIColor grayColor];
    [self.view addSubview: collectionView];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.filmImages.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
//    NSString *url = (NSString *)self.filmImages[indexPath.row];
//    NSString *newUrl = [CMRES_BaseURL stringByAppendingString:url];
//    NSURL *filmurl=[NSURL URLWithString:newUrl];
    
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    
//    UIImageView *imgV =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
//    imgV.backgroundColor = [UIColor redColor];
//    [imgV setImageWithURL:filmurl refreshCache:NO placeholderImage:[UIImage imageNamed:DEFAULT_IMAGE_FILM]];
//    [cell addSubview:imgV];

    return cell;
}

@end

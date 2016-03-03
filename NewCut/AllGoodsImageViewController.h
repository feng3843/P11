//
//  AllGoodsImageViewController.h
//  NewCut
//
//  Created by py on 15-7-28.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllGoodsImageViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

{
    UIButton *backBtn;
    // UICollectionView *AllImageView;
    NSArray *GoodsImages;
    
    NSDictionary *goodPhotoDic;
    NSMutableArray *goodPhotoArray;
    NSMutableArray *goodImageArray;
    
    
}
@property (strong, nonatomic) IBOutlet UICollectionView *AllGoodsImageView;
@property (strong, nonatomic) NSString *goodID;

@end

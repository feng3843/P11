//
//  AllImageViewController.h
//  NewCut
//
//  Created by py on 15-7-28.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllImageViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>

{

    UIButton *backBtn;
   // UICollectionView *AllImageView;
    NSArray *DressImages;
    
    NSDictionary *filmPhotoDic;
    NSMutableArray *filmPhotoArray;
    NSMutableArray *filmImageArray;
    
    
}

@property (strong, nonatomic) IBOutlet UICollectionView *AllImageView;
@property (strong, nonatomic) NSString *filmId;

@end

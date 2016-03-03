//
//  AllStarImageViewController.h
//  NewCut
//
//  Created by py on 15-7-28.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllStarImageViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UIButton *backBtn;
    // UICollectionView *AllImageView;
    NSArray *DressImages;
    
    NSDictionary *starPhotoDic;
    NSMutableArray *starPhotoArray;
    NSMutableArray *starImageArray;
    

}

@property (strong, nonatomic) NSString *starID;

@property (strong, nonatomic) IBOutlet UICollectionView *AllStarImage;


@end

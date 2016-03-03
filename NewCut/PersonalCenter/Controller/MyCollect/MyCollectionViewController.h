//
//  MyCollectionViewController.h
//  NewCut
//
//  Created by 夏雪 on 15/7/21.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCollectionStartTableViewController.h"
#import "MyCollectionGoodsTableViewController.h"
#import "MyCollectionFilmTableViewController.h"
#import "MyCollectionPhotoCollectionViewController.h"
#import "MyCollectionImageViewController.h"
@interface MyCollectionViewController : UIViewController
@property MyCollectionStartTableViewController *myCollectionStartView;
@property MyCollectionGoodsTableViewController *myCollectionGoodsView;
@property MyCollectionFilmTableViewController *myCollectionFilmView;
//@property MyCollectionPhotoCollectionViewController *myCollectionPhotoView;
@property MyCollectionImageViewController *myCollectionPhotoView;
@end

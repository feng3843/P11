//
//  PersonalInfoTableViewController.m
//  NewCut
//
//  Created by 夏雪 on 15/7/21.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "PersonalInfoTableViewController.h"
#import "PickImageViewController.h"
#import "UIView+AutoLayout.h"
#import "UIColor+Extensions.h"
#import "URBMediaFocusViewController.h"
#import "CTAssetsPickerController.h"
#import "UIImage+Extensions.h"
#import "CMData.h"
#import "CMAPI.h"
#import "SVProgressHUD.h"
#import "DataBaseTool.h"
#import "CMTool.h"
#import "SDImageView+SDWebCache.h"
#import "PYAllCommon.h"


@interface PersonalInfoTableViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,CTAssetsPickerControllerDelegate>

@property(nonatomic ,weak)UIView *pickImageView;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation PersonalInfoTableViewController


- (void)viewWillAppear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置不可以滚动
    self.tableView.scrollEnabled = NO;
    self.title = @"个人信息";

    NSString *fileName = [DataBaseTool getuserImage];
    NSString *path = [CMRES_ImageURL stringByAppendingPathComponent:fileName];
    
    if ([fileName isEqualToString:@""]) {
        self.headImage.image = [UIImage imageNamed:@"1.png"];
  }else
  {
      [CMTool setImageUrl:path ByImageName:fileName InImageView:self.headImage ImageCate:@"1.png" completed:^(UIImage *image, NSString *strImageName) {
      }];
  }
    
    [self changeStartName];
   
    self.headImage.layer.cornerRadius = 20;
     self.headImage.layer.masksToBounds = YES;
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNickName:) name:@"CHANGE_USERNICKNAME" object:nil];
 
}

/** 昵称*/
- (void)changeStartName
{
    
  
    if (![[DataBaseTool getNickName] isEqualToString:@""]) {
        self.nameLabel.text = [DataBaseTool getNickName];
    }else
    {
        self.nameLabel.text = @"请修改昵称";
    }
    
}
/** 昵称改变*/
- (void)changeNickName:(NSNotification *)notification
{
  self.nameLabel.text = notification.userInfo[@"nickName"];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if ([CMData getLoginType]) {
            [SVProgressHUD showInfoWithStatus:@"第三方登录不能修改头像"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else
        {
        
            [UIView animateWithDuration:0.5 animations:^{
                self.pickImageView.transform = CGAffineTransformMakeTranslation(0, -self.view.frame.size.height );
            }];
        }

        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 65;
    }return 44;
}
- (UIView *)pickImageView
{
    if (_pickImageView == nil) {
        
        UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height,self.view.frame.size.width,self.view.frame.size.height )];
        //    bg.backgroundColor = [UIColor blackColor];
        //    bg.backgroundColor = [UIColor blackColor];
        //    bg.alpha = 0.2;
        [self.view addSubview:bg];
        _pickImageView = bg;
        
        UIView *bottomView = [[UIView alloc]init];
        bottomView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
        //    bottomView.alpha = 0.2;
        [bg addSubview:bottomView];
        [bottomView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0,64,0) excludingEdge:ALEdgeTop];
        [bottomView autoSetDimension:ALDimensionHeight toSize:44 * 3 + 11];
        
        UIView *cancelBgView = [[UIView alloc]init];
        cancelBgView.backgroundColor = [UIColor whiteColor];
        [bg addSubview:cancelBgView];
        [cancelBgView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 64, 0) excludingEdge:ALEdgeTop];
        [cancelBgView autoSetDimension:ALDimensionHeight toSize:44];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [cancelBgView addSubview:cancelBtn];
        [cancelBtn autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        [cancelBtn addTarget:self action:@selector(hideView) forControlEvents:UIControlEventTouchUpInside];
        UIView *albumBgView = [[UIView alloc]init];
        albumBgView.backgroundColor = [UIColor whiteColor];
        [bg addSubview:albumBgView];
        [albumBgView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:bg];
        [albumBgView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:bg];
        [albumBgView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:cancelBgView withOffset:-11];
        [albumBgView autoSetDimension:ALDimensionHeight toSize:44];
        
        UIButton *albumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [albumBtn setTitle:@"从手机相册选择" forState:UIControlStateNormal];
        [albumBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        albumBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [albumBgView addSubview:albumBtn];
        [albumBtn autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        [albumBtn addTarget:self action:@selector(albumBtnDid) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIView *divideLine = [[UIView alloc]init];
        divideLine.backgroundColor = [UIColor colorWithHexString:@"bababa"];
        [self.pickImageView addSubview:divideLine];
        [divideLine autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:bg];
        [divideLine autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:bg];
        [divideLine autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:albumBgView];
        [divideLine autoSetDimension:ALDimensionHeight toSize:0.5];
        
        
        UIView *pictureBgView = [[UIView alloc]init];
        pictureBgView.backgroundColor = [UIColor whiteColor];
        [bg addSubview:pictureBgView];
        [pictureBgView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:bg];
        [pictureBgView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:bg];
        [pictureBgView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:divideLine ];
        [pictureBgView autoSetDimension:ALDimensionHeight toSize:44];
        
        UIButton *pictureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [pictureBtn setTitle:@"拍照" forState:UIControlStateNormal];
        [pictureBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        pictureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [pictureBgView addSubview:pictureBtn];
        [pictureBtn autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        [pictureBtn addTarget:self action:@selector(pictureBtnDid) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *topView = [[UIView alloc]init];
        topView.backgroundColor = [UIColor blackColor];
        topView.alpha = 0.4;
        [bg addSubview:topView];
        [topView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeBottom];
        [topView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:pictureBgView ];
    }
    return _pickImageView;
}

/** 点击拍照按钮*/
- (void)pictureBtnDid
{
     [self hideView];
     UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
    
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.showsCameraControls = YES;
    imagePicker.toolbarHidden = YES;
    imagePicker.navigationBarHidden = YES;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.navigationBar.translucent = NO;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}


//当得到该图片后调用该方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"picker return successfully");
    NSLog(@"%@",info);
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    UIImage *theImage = nil;
    theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    //保存图片
    SEL selectorToCall = @selector(imageWasSavedSuccessfully:didFinishSavingWithError:contextInfo:);
    UIImageWriteToSavedPhotosAlbum(theImage, self, selectorToCall, NULL);
    
      [self ChangeImage:theImage];
    
    [picker dismissModalViewControllerAnimated:YES];
}

//保存图片到相册
- (void)imageWasSavedSuccessfully:(UIImage *)paramImage didFinishSavingWithError:(NSError *)paramError contextInfo:(void *)paramContextInfo
{
    if (paramError == nil) {
//        NSLog(@"Image was successfully");
        
      
//        [self.navigationController popViewControllerAnimated:YES];
    }
}

//当用户取消时调用该方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissModalViewControllerAnimated:YES];
}


/** 点击从相册中选择按钮*/
- (void)albumBtnDid
{
    [self hideView];
    CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
    picker.showsCancelButton         = YES;
    picker.delegate                  = self;
    picker.showsNumberOfAssets       = NO;
    picker.navigationController.navigationBar.translucent = NO;
    
    [self presentViewController:picker animated:YES completion:nil];
}
#pragma CTAssetsPickerController
- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    NSMutableArray* arrayMutable = picker.selectedAssets;
    
//    NSMutableArray* arrayMutable2 = [NSMutableArray arrayWithCapacity:arrayMutable.count];
    ALAsset* alasset3 =   arrayMutable[0];
//    for (ALAsset* alasset in arrayMutable) {
//        [arrayMutable2 insertObject:[UIImage imageWithCGImage:alasset.thumbnail] atIndex:arrayMutable2.count];
  
    UIImage *oldImage = [UIImage imageWithCGImage:alasset3.thumbnail];
//    self.headImage.image = oldImage;
//    }
//
//   UIImage *oldImage = [UIImage imageWithCGImage:alasset3.thumbnail];
 
    [self ChangeImage:oldImage];
    
//    [self.delegate flushImageViews:arrayMutable2];
    
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
}
/** 隐藏View*/
- (void)hideView
{
    [UIView animateWithDuration:0.5 animations:^{
        self.pickImageView.transform =CGAffineTransformIdentity;
    }];
}
/** 改变服务器上的图片*/
- (void)ChangeImage:(UIImage *)oldImage
{
    if(![CMTool isConnectionAvailable]){
        
        [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
    }else{
    
    NSString *token = [CMData getToken];
    // 裁剪后的图片
    UIImage *newImage = [UIImage clipImageToRoundImage:oldImage];
    
    NSData *imageData = UIImageJPEGRepresentation(newImage, 1);
    NSDictionary *param = @{@"token":token
                             };
    [CMAPI postUrl:API_USER_MODIFYIMAGE Param:param Settings:nil FileData:imageData OpName:nil FileName:@"UserImage.jpg" FileType:@"image/jpeg" completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
        
        id result = [detailDict objectForKey:@"code"];
        if(succeed)
        {
            NSString *fileName = [detailDict objectForKey:@"fileName"];
//            NSString *path = [PersonCenterUserImageURL stringByAppendingPathComponent:fileName];
//            NSURL *url = [NSURL URLWithString:path];
//             [self.headImage setImageWithURL:url refreshCache:YES placeholderImage:[UIImage imageNamed:@"h.jpg"]];
//
            self.headImage.image = newImage;
            [DataBaseTool updateuserImage:fileName];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CHANGE_USERIMAGE" object:nil];
            
        }else
        {
            
        }
        
    }];

    }
    
}





@end

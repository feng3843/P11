//
//  GoodsHeadViewController.m
//  NewCut
//
//  Created by py on 15-8-5.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "GoodsHeadViewController.h"

@interface GoodsHeadViewController ()

@end

@implementation GoodsHeadViewController
@synthesize headTableView,headImageArray,DressImages;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat h=[UIScreen mainScreen].bounds.size.height;
    CGFloat w=[UIScreen mainScreen].bounds.size.width;

    headTableView = [[UITableView alloc] initWithFrame:CGRectMake(48 , 29.5, h *228/568, w)];
    //hotFilmTableView = [[UITableView alloc] initWithFrame:CGRectMake(0 , 64, w, 225)];
    headTableView.transform = CGAffineTransformMakeRotation(M_PI / 2 *3);
    headTableView.dataSource = self;
    headTableView.delegate = self;
    headTableView.pagingEnabled = YES;//是否设置分页,滑动一次显示一张图片
    //hotFilmTableView.backgroundColor = [UIColor blueColor];
    headTableView.showsVerticalScrollIndicator = NO;
    headTableView.separatorStyle = UITableViewCellAccessoryNone;
    [self.view addSubview:headTableView];

    headImageArray = [[NSMutableArray alloc]init];
    
    DressImages = @[[UIImage imageNamed:@"11.jpg"],
                    [UIImage imageNamed:@"12.jpg"],
                    [UIImage imageNamed:@"13.jpg"],[UIImage imageNamed:@"14.jpg"],[UIImage imageNamed:@"15.jpg"],[UIImage imageNamed:@"16.jpg"]];
    
    // Do any additional setup after loading the view.
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    

    return DressImages.count;
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    static NSString *infocellname = @"cell";
    UIImageView *headImage ;
    UITableViewCell *cell = [headTableView dequeueReusableCellWithIdentifier:infocellname];
    if (cell == nil) {
            
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infocellname];
        cell.transform = CGAffineTransformMakeRotation(M_PI /2 );
        
        
        
    }
    
    headImage = [[UIImageView alloc]initWithFrame:CGRectMake(0 , 0 , w, 228)];
    
    [headImage setImage:[UIImage imageNamed:[DressImages objectAtIndex:indexPath.row]]];
    
    [cell addSubview:headImage];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //CGFloat h=[UIScreen mainScreen].bounds.size.height;
    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    
    return w;
    
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    if(tableView == hotFilmTableView){
//        
//        NSDictionary *dic = [self.hotFilmList objectAtIndex:indexPath.row];
//        NSString *Id = [dic objectForKey:@"movieId"];
//        
//        UIStoryboard *View = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        self.filmDetail = [View instantiateViewControllerWithIdentifier:@"filmDetailViewId"];
//        
//        filmDetail.movieId = Id;
//        
//        [self.navigationController pushViewController:self.filmDetail animated:YES];
//        //[self presentViewController:self.filmDetail animated:YES completion:nil];
//        //[self gotoFilmDetail];
//        
//        
//    }else if (tableView == hotStarTableView){
//        
//        NSDictionary *dic = [self.hotStarList objectAtIndex:indexPath.row];
//        NSString *ID = [dic objectForKey:@"starId"];
//        
//        UIStoryboard *View = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        self.filmStarsDetail = [View instantiateViewControllerWithIdentifier:@"FilmStarDetail"];
//        filmStarsDetail.starId = ID;
//        [self.navigationController pushViewController:self.filmStarsDetail animated:YES];
//        //[self gotoFilmStarsDetail];
//    }
//    
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

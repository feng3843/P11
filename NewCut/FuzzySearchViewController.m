//
//  FuzzySearchViewController.m
//  NewCut
//
//  Created by uncommon on 2015/07/21.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "FuzzySearchViewController.h"
#import "CMAPI.h"
#import "FuzzySearchTableViewCell.h"
#import "EnumList.h"
#import "SDImageView+SDWebCache.h"
#import "PYAllCommon.h"
#import "FilmViewCell.h"
#import "StarViewCell.h"
#import "GoodViewCell.h"

@interface FuzzySearchViewController ()

/** @brief 当前页数据源 */
@property (nonatomic) NSMutableArray *movieArrayMutable;
@property (nonatomic) NSMutableArray *starArrayMutable;
@property (nonatomic) NSMutableArray *goodArrayMutable;
@property (strong, nonatomic) IBOutlet UITableView *fuzzyTableView;

@end

@implementation FuzzySearchViewController
@synthesize searchField;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 70, self.view.bounds.size.width, 2)];
    line.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [self.view addSubview:line];
    isSearch = NO;
    // Do any additional setup after loading the view.
    
    [self createSearchBar];
    
    if (!self.movieArrayMutable)
    {
        self.movieArrayMutable = [NSMutableArray arrayWithCapacity:20];
    }
    
    if (!self.starArrayMutable)
    {
        self.starArrayMutable = [NSMutableArray arrayWithCapacity:20];
    }
    
    if (!self.goodArrayMutable)
    {
        self.goodArrayMutable = [NSMutableArray arrayWithCapacity:20];
    }
    
    self.fuzzyTableView.delegate = self;
    self.fuzzyTableView.dataSource = self;
    [self setUpForDismissKeyboard];
    [self.fuzzyTableView reloadData];
    
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [_btnMovies becomeFirstResponder];
//}

-(void)createSearchBar{
    
    UISearchBar *searchBarInTop = [[UISearchBar alloc] initWithFrame:CGRectMake(42.0, 20.0, self.view.bounds.size.width-42.0, 40.0)];
    
    UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(250,15, 15, 15)];
    [deleteBtn setBackgroundImage:[UIImage imageNamed:@"dl.png"] forState:UIControlStateNormal];
    //[self.view addSubview:deleteBtn];
    
    searchBarInTop.delegate=self;
    searchBarInTop.showsCancelButton=NO;
    //searchBarInTop.barStyle=UIBarButtonItemStylePlain;
    searchBarInTop.barStyle = UITextBorderStyleNone;
    searchBarInTop.placeholder=@"搜索喜欢的商品 影视 明星";
    
//    UITextField *searchField ;
//    NSUInteger numViews = [searchBarInTop.subviews count];
//    for(int i=0;i<numViews;i++){
//    
//        if([[searchBarInTop.subviews objectAtIndex:i] isKindOfClass:[UITextField class]]){
//        
//            searchField = [searchBarInTop.subviews objectAtIndex:i];
//        
//        }
//    
//    }
//    
//    if(!(searchField == nil)){
//    
//        searchField.textColor = [UIColor colorWithHexString:@"bababa"];
//        [searchField setBorderStyle:UITextBorderStyleNone];
//    
//    }
//    
   // [searchBarInTop setBorderStyle:UITextBorderStyleNone];
    //searchBarInTop.keyboardType=UIKeyboardTypeDefault;
    //searchBarInTop.tintColor = [UIColor colorWithHexString:@"ededed"];
    //searchBarInTop.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    searchBarInTop.delegate = self;
    //[self.view addSubview:searchBarInTop];
    [searchBarInTop becomeFirstResponder];
    
    searchField = [[UITextField alloc] initWithFrame:CGRectMake(40, 30, self.view.bounds.size.width-60.0, 35)];
    searchField.delegate = self;
    searchField.placeholder = @"      搜索喜欢的商品 影视 明星";
    searchField.font = [UIFont systemFontOfSize:14];
    searchField.textColor = [UIColor colorWithHexString:@"bababa"];
    searchField.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [searchField setBorderStyle:UITextBorderStyleRoundedRect];
    
    UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, 15, 15)];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"search_small.png"] forState:UIControlStateNormal];
    [searchField addSubview:searchBtn];
    
    UIButton *cancleBtn = [[UIButton alloc]initWithFrame:CGRectMake(240, 10, 15, 15)];
    [cancleBtn setBackgroundImage:[UIImage imageNamed:@"dl.png"] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(deleteText) forControlEvents:UIControlEventTouchUpInside];
    [searchField addSubview:cancleBtn];
    
    UIView *leftview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 16, 15)];
    searchField.leftView = leftview;
    leftview.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    searchField.leftViewMode = UITextFieldViewModeAlways;
    
   // searchField.selectedTextRange =5;

    [self.view addSubview:searchField];

}

-(void)deleteText
{
    
    self.searchField.text = @"";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//点击空白处隐藏键盘
- (void)setUpForDismissKeyboard {
    
    
    //NSNotification *notification = [NSNotification notificationWithName:@"hide" object:nil userInfo:nil];
   // [SVProgressHUD showInfoWithStatus:@"ddddddddddddd"];
    
    //NSInteger i = indexPath.row;
    
    //[[NSNotificationCenter defaultCenter] postNotification:notification];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view addGestureRecognizer:singleTapGR];
                }];
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view removeGestureRecognizer:singleTapGR];
                }];
}

//-(void)hideKeyBoard
//{
//
//    NSNotification *notification = [NSNotification notificationWithName:@"hide" object:nil userInfo:nil];
//    [[NSNotificationCenter defaultCenter] postNotification:notification];
//
//}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
     [self.view endEditing:YES];
   // NSNotification *notification = [NSNotification notificationWithName:@"hide" object:nil userInfo:nil];
   // [[NSNotificationCenter defaultCenter] postNotification:notification];
    
}


#pragma mark- tableView事件

//列表分为三组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 3;
    
}

//cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{


    return 110;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger n;
    
    if(section == 0){
    
        n = filmImageArray.count;
    }else if (section == 1){
    
        n = starImageArray.count;
    }else if (section == 2){
    
        n = goodImageArray.count;
    }
    
    return n;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    UIImageView *filmImage;
//    UIImageView *starImage;
//    UIImageView *goodImage;
//    UILabel *filmName;
//    UILabel *starName;
//    UILabel *goodName;
//    UILabel *directorName;
//    UILabel *joinStarName;
//    UILabel *notice;
//    UILabel *nationLab;
//    UILabel *productLab;
//    UILabel *goodDetailName;
//    UILabel *likeCount;
//    UILabel *commmetCount;
    
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    
    static NSString *CellIdentifier1 = @"filmCell";
    static NSString *CellIdentifier2 = @"starCell";
    static NSString *CellIdentifier3 = @"goodCell";

    UITableViewCell *cell;

    if(indexPath.section == 0){
        
        FilmViewCell *filmCell = (FilmViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if(filmCell == nil)
        {
            filmCell = [[FilmViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
        }
        else
        {
            filmCell = [[FilmViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
        }
        
        //filmImage=[[UIImageView alloc] initWithFrame:CGRectMake(16, 16, 50, 70)];
        NSString *url = [filmImageArray objectAtIndex:indexPath.row];
        NSURL *filmUrl=[NSURL URLWithString:url];
        [filmCell.filmImage setImageWithURL:filmUrl refreshCache:NO placeholderImage:[UIImage imageNamed:DEFAULT_IMAGE_STAR]];
        //[cell addSubview:filmImage];
        filmCell.selectionStyle = UITableViewCellSelectionStyleNone;

        filmCell.filmName.text = [filmNameArray objectAtIndex:indexPath.row];
        filmCell.directorName.text = [directorArray objectAtIndex:indexPath.row];
        filmCell.joinStarName.text = [joinStarArray objectAtIndex:indexPath.row];
        filmCell.notice.text = [noticeArray objectAtIndex:indexPath.row];
        //filmName = [[UILabel alloc] initWithFrame:CGRectMake(90, 17, 200, 16)];
        //filmName.font = [UIFont systemFontOfSize:15];
       // filmName.textColor = [UIColor colorWithHexString:@"000000"];
        //filmCell.filmName.text = [filmNameArray objectAtIndex:indexPath.row];
       // [cell addSubview:filmName];
        
//        directorName = [[UILabel alloc] initWithFrame:CGRectMake(90, 39, 150, 15)];
//        directorName.font = [UIFont systemFontOfSize:13];
//        directorName.textColor = [UIColor colorWithHexString:@"666666"];
//        [cell addSubview:directorName];
//        
//        joinStarName = [[UILabel alloc] initWithFrame:CGRectMake(90, 55, 200, 14)];
//        joinStarName.font = [UIFont systemFontOfSize:13];
//        joinStarName.textColor = [UIColor colorWithHexString:@"666666"];
//        [cell addSubview:joinStarName];
//        
//        notice = [[UILabel alloc] initWithFrame:CGRectMake(90, 78, 100, 13)];
//        notice.font = [UIFont systemFontOfSize:12];
//        notice.textColor = [UIColor colorWithHexString:@"777777"];
        
          cell = filmCell;

    }else if (indexPath.section == 1){
        
        StarViewCell *starCell = (StarViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        if(starCell == nil){
            
            starCell = [[StarViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2];
        }else{
        
            starCell = [[StarViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2];
        }
        
        
        //filmImage=[[UIImageView alloc] initWithFrame:CGRectMake(16, 16, 50, 70)];
        NSString *url = [starImageArray objectAtIndex:indexPath.row];
        NSURL *filmUrl=[NSURL URLWithString:url];
        [starCell.starImage setImageWithURL:filmUrl refreshCache:NO placeholderImage:[UIImage imageNamed:DEFAULT_IMAGE_STAR]];
       
        starCell.starName.text = [starNameArray objectAtIndex:indexPath.row];
        starCell.nation.text = [nationArray objectAtIndex:indexPath.row];
        starCell.product.text = [productArray objectAtIndex:indexPath.row];
        cell = starCell;
//        StarCell *starCell;
//        if (cell == nil) {
//            
//            starCell = [[StarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//            cell = starCell;
//        }
        

        //starImage = [[UIImageView alloc] initWithFrame:CGRectMake(16, 16, 50, 70)];
       // NSString *url = [starImageArray objectAtIndex:indexPath.row];
        //NSURL *starUrl=[NSURL URLWithString:url];
       // [starCell.starImage setImageWithURL:starUrl];
        
       // starCell.starsName.text = [starNameArray objectAtIndex:indexPath.row];
       // [cell addSubview:starImage];
        
        //starName = [[UILabel alloc] initWithFrame:CGRectMake(80,26, 200, 20)];
       // starName.font = [UIFont systemFontOfSize:15];
       // starName.textColor = [UIColor colorWithHexString:@"000000"];
        //starName.text = [starNameArray objectAtIndex:indexPath.row];
        //[cell addSubview:starName];
        
//        nationLab = [[UILabel alloc]initWithFrame:CGRectMake(80, 50, 100, 15)];
//        nationLab.font = [UIFont systemFontOfSize:12];
//        nationLab.textColor = [UIColor colorWithHexString:@"666666"];
//        [cell addSubview:nationLab];
        
//        productLab = [[UILabel alloc] initWithFrame:CGRectMake(80, 64, 200, 13)];;
//        productLab.font = [UIFont systemFontOfSize:12];
//        productLab.textColor = [UIColor colorWithHexString:@"666666"];
//        [cell addSubview:productLab];
    
    }else if(indexPath.section == 2){
    
        GoodViewCell *goodCell = (GoodViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
        if(goodCell == nil){
            
            goodCell = [[GoodViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier3];
        }else{
        
            goodCell = [[GoodViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier3];
        }
        
        
        //filmImage=[[UIImageView alloc] initWithFrame:CGRectMake(16, 16, 50, 70)];
        NSString *url = [goodImageArray objectAtIndex:indexPath.row];
        NSURL *filmUrl=[NSURL URLWithString:url];
        [goodCell.goodsImage setImageWithURL:filmUrl refreshCache:NO placeholderImage:[UIImage imageNamed:DEFAULT_IMAGE_STAR]];
        
        goodCell.goodsName.text = [goodNameArray objectAtIndex:indexPath.row];

        //NSString *url = [goodImageArray objectAtIndex:indexPath.row];
        //NSURL *goodUrl=[NSURL URLWithString:url];
       // [goodCell.goodImage setImageWithURL:goodUrl];
       // goodCell.goodName.text = [goodNameArray objectAtIndex:indexPath.row];
        //[cell addSubview:goodImage];
        
//        goodName = [[UILabel alloc] initWithFrame:CGRectMake(80, 16, 100, 20)];
//        goodName.font = [UIFont boldSystemFontOfSize:16];
//        goodName.textColor = [UIColor colorWithHexString:@"000000"];
//        goodName.text = [goodNameArray objectAtIndex:indexPath.row];
//        [cell addSubview:goodName];
//        
//        goodDetailName = [[UILabel alloc] initWithFrame:CGRectMake(80, 50, 100, 20)];
//        goodDetailName.font = [UIFont systemFontOfSize:12];
//        goodDetailName.textColor = [UIColor colorWithHexString:@"666666"];
//        [cell addSubview:goodDetailName];
        
        UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(80*h/568, 70*h/568, 25*h/568, 13*h/568)];
        title1.font = [UIFont systemFontOfSize:12*h/568];
        title1.textColor = [UIColor colorWithHexString:@"666666"];
        title1.text = @"喜欢";
        [cell addSubview:title1];
        
        UILabel *title2 = [[UILabel alloc]initWithFrame:CGRectMake(80*h/568, 200*h/568, 25*h/568, 13*h/568)];
        title2.font = [UIFont systemFontOfSize:12*h/568];
        title2.textColor = [UIColor colorWithHexString:@"666666"];
        title2.text = @"评论";
        [cell addSubview:title2];
        
        goodCell.likeCount.text = [likeArray objectAtIndex:indexPath.row];
        goodCell.commentCount.text = [commentArray objectAtIndex:indexPath.row];
        goodCell.detailName.text = [goodRelatedArray objectAtIndex:indexPath.row];
        cell = goodCell;
//        likeCount = [[UILabel alloc]initWithFrame:CGRectMake(110, 70, 70, 13)];
//        likeCount.font = [UIFont systemFontOfSize:12];
//        likeCount.textColor = [UIColor colorWithHexString:@"ff9c00"];
//        //likeCount.text = @"评论";
//        //[cell addSubview:likeCount];
//
//        commmetCount = [[UILabel alloc]initWithFrame:CGRectMake(230, 70, 70, 13)];
//        commmetCount.font = [UIFont systemFontOfSize:12];
//        commmetCount.textColor = [UIColor colorWithHexString:@"ff9c00"];
        //likeCount.text = @"评论";
        //[cell addSubview:commmetCount];
    }
    
    //FuzzySearchTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"FuzzySearchCell"];
    //cell.searchListInfo = self.arrayMutable[indexPath.row];
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
}


//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self.arrayMutable removeObjectAtIndex:indexPath.row];
//        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }
//}

//#pragma mark- 查询控件
//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;
//{
//    
//    // [self searchFuzzy:searchBar.text];
//    
//}

//-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
//    if (searchBar!=nil&&searchBar.text.length>0) {
//        //[self searchFuzzy:searchBar.text];
//    }else{
//        //提示输入内容
//    }
//}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{

    NSString *info = searchField.text;
    NSDictionary *params = @{
                             @"key":info
                             };
    
    //-(void)searchFuzzy:(NSString*)searchText{
    
    //[self.fuzzyTableView reloadData];
    
    filmImageArray = [[NSMutableArray alloc]init];
    starImageArray = [[NSMutableArray alloc]init];
    goodImageArray = [[NSMutableArray alloc]init];
    filmNameArray = [[NSMutableArray alloc]init];
    starNameArray = [[NSMutableArray alloc]init];
    goodNameArray =[[NSMutableArray alloc]init];
    directorArray =[[NSMutableArray alloc]init];
    noticeArray = [[NSMutableArray alloc]init];
    nationArray = [[NSMutableArray alloc]init];
    productArray = [[NSMutableArray alloc]init];
    detailNameArray = [[NSMutableArray alloc]init];
    likeArray = [[NSMutableArray alloc]init];
    commentArray = [[NSMutableArray alloc]init];
    joinStarArray = [[NSMutableArray alloc]init];
    filmIdArray = [[NSMutableArray alloc]init];
    starIdArray = [[NSMutableArray alloc]init];
    goodIdArray = [[NSMutableArray alloc]init];
    goodRelatedArray = [[NSMutableArray alloc]init];
    
    [filmImageArray removeAllObjects];
    [starImageArray removeAllObjects];
    [goodImageArray removeAllObjects];
    [filmNameArray removeAllObjects];
    [starNameArray removeAllObjects];
    [goodNameArray removeAllObjects];
    [directorArray removeAllObjects];
    [noticeArray removeAllObjects];
    [nationArray removeAllObjects];
    [productArray removeAllObjects];
    [detailNameArray removeAllObjects];
    [likeArray removeAllObjects];
    [commentArray removeAllObjects];
    [joinStarArray removeAllObjects];
    [filmIdArray removeAllObjects];
    [starIdArray removeAllObjects];
    [goodIdArray removeAllObjects];
    [goodRelatedArray removeAllObjects];
    [self.fuzzyTableView reloadData];
    
    // if(searchText.length == 0){
    
    
    //isSearch = NO;
    
    // }else{
    
    //isSearch = YES;
    // 获取参数
    // NSMutableDictionary *params = [self getParam4FuzzySearch:searchText];
    
    [CMAPI postUrl:API_MOVIE_FUZZY_SEARCH Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
        
        id result = [detailDict objectForKey:@"code"];
        if (succeed)
        {
            //[self.movieArrayMutable removeAllObjects];
            NSDictionary* result = [detailDict objectForKey:RESULT];
            //SearchListInfo* searchListInfo;
            
            NSArray* movieArray = [result objectForKey:@"movie"];
            for (NSDictionary* dic in movieArray) {
                //searchListInfo = [[SearchListInfo alloc]init];
                //searchListInfo.searchType=MoviesType;
                //searchListInfo.movieId=[dic objectForKey:@"movieId"];
                //searchListInfo.movieName=[dic objectForKey:@"movieName"];
                
                
                //NSString *name = searchListInfo.movieName;
                
                NSString *filmId = [dic objectForKey:@"movieId"];
                [filmIdArray addObject:filmId];
                
                NSString *filmUrl = [dic objectForKey:@"moviePhoto"];
                NSString *url = [CMRES_BaseURL stringByAppendingString:filmUrl];
                [filmImageArray addObject:url];
                
                NSString *name = [dic objectForKey:@"movieName"];
                [filmNameArray addObject:name];
                NSLog(@"%@",@"ffffffqqqqqqqffffffuzzy");
                NSLog(@"%@",name);
                NSLog(@"%@",@"ffffffqqqqqqqffffffuzzy");
                
                NSString *directorName = [dic objectForKey:@"director"];
                [directorArray addObject:directorName];
                NSString *joinStarName = [dic objectForKey:@"stars"];
                [joinStarArray addObject:joinStarName];
                
                NSString *time = [dic objectForKey:@"movieYear"];
                [noticeArray addObject:time];
                //searchListInfo.moviePhoto=[dic objectForKey:@"moviePhoto"];
                //[self.movieArrayMutable addObject:searchListInfo];
            }
            
            NSArray* starArray = [result objectForKey:@"star"];
            for (NSDictionary* dic in starArray) {
                //searchListInfo = [[SearchListInfo alloc]init];
                //searchListInfo.searchType=StarsType;
                // searchListInfo.starId=[dic objectForKey:@"starId"];
                // searchListInfo.starName=[dic objectForKey:@"starName"];
                //searchListInfo.starPhoto=[dic objectForKey:@"starPhoto"];
                NSString *starUrl = [dic objectForKey:@"starPhoto"];
                NSString *url = [CMRES_BaseURL stringByAppendingString:starUrl];
                [starImageArray addObject:url];
                NSString *starName = [dic objectForKey:@"starName"];
                [starNameArray addObject:starName];
                
                NSString *nationName = [dic objectForKey:@"starNationality"];
                [nationArray addObject:nationName];
                
                NSString *products = [dic objectForKey:@"movieName"];
                [productArray addObject:products];
                
                NSString *starIds = [dic objectForKey:@"starId"];
                [starIdArray addObject:starIds];
                //[self.starArrayMutable addObject:searchListInfo];
            }
            
            NSArray* goodArray = [result objectForKey:@"good"];
            for (NSDictionary* dic in goodArray) {
                // searchListInfo = [[SearchListInfo alloc]init];
                // searchListInfo.searchType=GoodType;
                // searchListInfo.goodId=[dic objectForKey:@"goodId"];
                // searchListInfo.goodName=[dic objectForKey:@"goodName"];
                // searchListInfo.goodPhoto=[dic objectForKey:@"goodPhoto"];
                
                NSString *goodUrl = [dic objectForKey:@"goodPhoto"];
                NSString *url = [CMRES_BaseURL stringByAppendingString:goodUrl];
                [goodImageArray addObject:url];
                NSString *goodName = [dic objectForKey:@"goodsName"];
                [goodNameArray addObject:goodName];
                
                NSString *likeCount = [dic objectForKey:@"goodPraiseCount"];
                [likeArray addObject:likeCount];
                
                NSString *commentCount = [dic objectForKey:@"commentCount"];
                [commentArray addObject:commentCount];
                
                NSString *description = [dic objectForKey:@"goodRelated"];
                [goodRelatedArray addObject:description];
                
                // NSString *goodsId = [dic objectForKey:@""];
                // [self.goodArrayMutable addObject:searchListInfo];
            }
            
            [self.fuzzyTableView reloadData];
            
        }else{
            
            NSDictionary *dic=[detailDict valueForKey:@"result"];
            if(!!dic&&dic.count>0)
                result=[dic valueForKey:@"reason"];
            
            result=[NSString stringWithFormat:@"\n\n\t%@\t\n\n",result];
            
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"676767"]];
            [SVProgressHUD setInfoImage:nil];
            [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
            [SVProgressHUD showInfoWithStatus:result];
            
        }
        
    }];




}

//- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
//{
//
//}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{

    NSString *info = searchText;
    NSDictionary *params = @{
                             @"key":info
                             };

//-(void)searchFuzzy:(NSString*)searchText{
    
    //[self.fuzzyTableView reloadData];

    filmImageArray = [[NSMutableArray alloc]init];
    starImageArray = [[NSMutableArray alloc]init];
    goodImageArray = [[NSMutableArray alloc]init];
    filmNameArray = [[NSMutableArray alloc]init];
    starNameArray = [[NSMutableArray alloc]init];
    goodNameArray =[[NSMutableArray alloc]init];
    directorArray =[[NSMutableArray alloc]init];
    noticeArray = [[NSMutableArray alloc]init];
    nationArray = [[NSMutableArray alloc]init];
    productArray = [[NSMutableArray alloc]init];
    detailNameArray = [[NSMutableArray alloc]init];
    likeArray = [[NSMutableArray alloc]init];
    commentArray = [[NSMutableArray alloc]init];
    joinStarArray = [[NSMutableArray alloc]init];
    filmIdArray = [[NSMutableArray alloc]init];
    starIdArray = [[NSMutableArray alloc]init];
    goodIdArray = [[NSMutableArray alloc]init];
    goodRelatedArray = [[NSMutableArray alloc]init];
    
    [filmImageArray removeAllObjects];
    [starImageArray removeAllObjects];
    [goodImageArray removeAllObjects];
    [filmNameArray removeAllObjects];
    [starNameArray removeAllObjects];
    [goodNameArray removeAllObjects];
    [directorArray removeAllObjects];
    [noticeArray removeAllObjects];
    [nationArray removeAllObjects];
    [productArray removeAllObjects];
    [detailNameArray removeAllObjects];
    [likeArray removeAllObjects];
    [commentArray removeAllObjects];
    [joinStarArray removeAllObjects];
    [filmIdArray removeAllObjects];
    [starIdArray removeAllObjects];
    [goodIdArray removeAllObjects];
    [goodRelatedArray removeAllObjects];
    [self.fuzzyTableView reloadData];

   // if(searchText.length == 0){
        
       
        //isSearch = NO;
        
   // }else{
        
        //isSearch = YES;
    // 获取参数
        // NSMutableDictionary *params = [self getParam4FuzzySearch:searchText];
    
        [CMAPI postUrl:API_MOVIE_FUZZY_SEARCH Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
            
            id result = [detailDict objectForKey:@"code"];
            if (succeed)
            {
                 //[self.movieArrayMutable removeAllObjects];
                 NSDictionary* result = [detailDict objectForKey:RESULT];
                 //SearchListInfo* searchListInfo;
            
                 NSArray* movieArray = [result objectForKey:@"movie"];
                 for (NSDictionary* dic in movieArray) {
                //searchListInfo = [[SearchListInfo alloc]init];
                //searchListInfo.searchType=MoviesType;
                //searchListInfo.movieId=[dic objectForKey:@"movieId"];
                //searchListInfo.movieName=[dic objectForKey:@"movieName"];
                
                
                //NSString *name = searchListInfo.movieName;
                
                NSString *filmId = [dic objectForKey:@"movieId"];
                [filmIdArray addObject:filmId];
                     
                NSString *filmUrl = [dic objectForKey:@"moviePhoto"];
                NSString *url = [CMRES_BaseURL stringByAppendingString:filmUrl];
                [filmImageArray addObject:url];
                
                NSString *name = [dic objectForKey:@"movieName"];
                [filmNameArray addObject:name];
                NSLog(@"%@",@"ffffffqqqqqqqffffffuzzy");
                NSLog(@"%@",name);
                NSLog(@"%@",@"ffffffqqqqqqqffffffuzzy");
                
                NSString *directorName = [dic objectForKey:@"director"];
                [directorArray addObject:directorName];
                NSString *joinStarName = [dic objectForKey:@"stars"];
                [joinStarArray addObject:joinStarName];
                
                NSString *time = [dic objectForKey:@"movieYear"];
                [noticeArray addObject:time];
                //searchListInfo.moviePhoto=[dic objectForKey:@"moviePhoto"];
                //[self.movieArrayMutable addObject:searchListInfo];
            }
            
                NSArray* starArray = [result objectForKey:@"star"];
                for (NSDictionary* dic in starArray) {
                //searchListInfo = [[SearchListInfo alloc]init];
                //searchListInfo.searchType=StarsType;
               // searchListInfo.starId=[dic objectForKey:@"starId"];
               // searchListInfo.starName=[dic objectForKey:@"starName"];
                //searchListInfo.starPhoto=[dic objectForKey:@"starPhoto"];
                    NSString *starUrl = [dic objectForKey:@"starPhoto"];
                    NSString *url = [CMRES_BaseURL stringByAppendingString:starUrl];
                    [starImageArray addObject:url];
                    NSString *starName = [dic objectForKey:@"starName"];
                    [starNameArray addObject:starName];
                
                    NSString *nationName = [dic objectForKey:@"starNationality"];
                    [nationArray addObject:nationName];
                
                    NSString *products = [dic objectForKey:@"movieName"];
                   [productArray addObject:products];
                    
                    NSString *starIds = [dic objectForKey:@"starId"];
                    [starIdArray addObject:starIds];
                //[self.starArrayMutable addObject:searchListInfo];
            }
            
                   NSArray* goodArray = [result objectForKey:@"good"];
                   for (NSDictionary* dic in goodArray) {
               // searchListInfo = [[SearchListInfo alloc]init];
               // searchListInfo.searchType=GoodType;
               // searchListInfo.goodId=[dic objectForKey:@"goodId"];
               // searchListInfo.goodName=[dic objectForKey:@"goodName"];
               // searchListInfo.goodPhoto=[dic objectForKey:@"goodPhoto"];
                
                    NSString *goodUrl = [dic objectForKey:@"goodPhoto"];
                    NSString *url = [CMRES_BaseURL stringByAppendingString:goodUrl];
                    [goodImageArray addObject:url];
                     NSString *goodName = [dic objectForKey:@"goodsName"];
                    [goodNameArray addObject:goodName];
                
                    NSString *likeCount = [dic objectForKey:@"goodPraiseCount"];
                    [likeArray addObject:likeCount];
                
                    NSString *commentCount = [dic objectForKey:@"commentCount"];
                   [commentArray addObject:commentCount];
                       
                    NSString *description = [dic objectForKey:@"goodRelated"];
                    [goodRelatedArray addObject:description];
                       
                   // NSString *goodsId = [dic objectForKey:@""];
               // [self.goodArrayMutable addObject:searchListInfo];
            }
            
                   [self.fuzzyTableView reloadData];
                
            }else{
                
                NSDictionary *dic=[detailDict valueForKey:@"result"];
                if(!!dic&&dic.count>0)
                    result=[dic valueForKey:@"reason"];
                
                result=[NSString stringWithFormat:@"\n\n\t%@\t\n\n",result];
                
                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
                [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"676767"]];
                [SVProgressHUD setInfoImage:nil];
                [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
                [SVProgressHUD showInfoWithStatus:result];
                
            }

        }];
   // }
}

/**
 * @brief 获取参数
 *
 * @param
 */
-(NSMutableDictionary *)getParam4FuzzySearch:(NSString*)searchText{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:10];
    
    [params setValue:searchText forKey:@"Key"];
    
    return params;
}

#pragma mark- 返回
//返回按钮事件
- (IBAction)btnGoBack_Click:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self.navigationController popViewControllerAnimated:YES];
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

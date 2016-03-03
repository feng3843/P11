
#import "InfoCell.h"
#import "CMAPI.h"
#import "CMTool.h"
#import "PYAllCommon.h"
#import "CMDefault.h"
#import "Cell.h"
#import "SDImageView+SDWebCache.h"

@interface InfoCell()
{
     NSInteger maxNoticeId;
  
}
@property (nonatomic, retain) NSMutableArray   *dataArray1;

@end

@implementation InfoCell
@synthesize dataArray1 = _dataArray1,images1,images2,filmDetail,filmId,filmName,filmPhoto,filmInfo,content,hotFilmList,filmImage,filmImageView,imgUrl,imgUrlArr,filmIdLab;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:@"reload" object:nil];
    CGFloat h=[UIScreen mainScreen].bounds.size.height;
    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //47.5
        filmImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0 , 0 , w, 224)];
        [self addSubview:filmImageView];
        
        filmIdLab = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 20, 20)];
        //[self addSubview:filmIdLab];

        //45
       // hortable = [[UITableView alloc]initWithFrame:CGRectMake(47.5 , -45 , 225, w) style:UITableViewStylePlain];
        //hortable = [[UITableView alloc]initWithFrame:CGRectMake(0 , 0 , w, 50) style:UITableViewStylePlain];
        //hortable.delegate = self;
        //hortable.dataSource = self;
        //hortable.transform = CGAffineTransformMakeRotation(M_PI / 2 *3);
        //hortable.showsVerticalScrollIndicator = NO;
        //[self addSubview:hortable];
        //hortable.pagingEnabled = YES;//是否设置分页,滑动一次显示一张图片
        
//        images1 = @[[UIImage imageNamed:@"h.jpg"],
//                         [UIImage imageNamed:@"aa.jpg"],
//                         [UIImage imageNamed:@"bb.jpg"]
//                         ];
        
//        images2 = @[[UIImage imageNamed:@"lou.jpg"],
//                    [UIImage imageNamed:@"zhong.jpg"],
//                    [UIImage imageNamed:@"yang.jpg"],
//                    [UIImage imageNamed:@"yangy.jpg"],
//                    [UIImage imageNamed:@"sun.jpg"]];
//        
//        _dataArray1 = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",nil];
//        
//        filmInfo = [[NSDictionary alloc] init];
//        filmPhoto = [[NSMutableArray alloc] init];
//        filmName = [[NSMutableArray alloc] init];
//        filmId = [[NSMutableArray alloc] init];
//        content = [[NSMutableArray alloc] init];
//        hotFilmList = [[NSMutableArray alloc] init];
//        filmImage = [[NSMutableArray alloc] init];
//        
//        maxNoticeId = 0;
//        
//        
//        self.imgUrl = [[NSMutableArray alloc]init];
        // Do any additional setup after loading the view, typically from a nib.
        //[self addSubview:filmImageView];
   }
    //[self initImageArray];
    //[self reloadData];
    //[self getFilmPhoto];
    return self;
    
}

//- (void) initImageArray {
//    if (imgUrlArr==nil) {
//        
//        imgUrlArr = [NSArray arrayWithObjects:@"http://www.nyist.net/nyist_new/img/4562_1.jpg",
//                   @"http://www.nyist.net/nyist_new/img/(5)_1.jpg",
//                   @"http://soft.nyist.edu.cn/images/13/05/05/1mko5htk3p/pry2_vsb51E8-396.png",@"http://www.nyist.net/nyist_new/img/tyg.jpg",
//                   @"http://soft.nyist.edu.cn/images/13/05/03/3va2w52ys4/7xin_image001.jpg",
//                   @"http://soft.nyist.edu.cn/images/13/05/03/3va2w52ys4/7xin_image008.jpg",
//                   @"http://soft.nyist.edu.cn/images/13/05/03/3va2w52ys4/7xin_image007.jpg", nil];
//        
//        
//        self.filmImage = [[NSMutableArray alloc]init];
//        
//        for(int i=0;i <self.imgUrlArr.count;i++){
//            
//            NSString *url = self.imgUrlArr[i];
//            [self.imgUrl addObject:url];
//            
//        }
//        
//    }
//}
//
//
//
//-(void)getFilmPhoto{
//    
//    if(![CMTool isConnectionAvailable]){
//    
//        [SVProgressHUD showInfoWithStatus:@"网络没有连接！"];
//    }else{
//        
//        [CMAPI postUrl:API_MOVIE_GETMOVIENAME Param:nil Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
//            
//             id result = [detailDict objectForKey:@"code"];
//            if(succeed){
//                
//                filmInfo = [detailDict objectForKey:@"result"];
//                content = [filmInfo objectForKey:@"movie"];
//                
//                NSInteger n = content.count;
//                NSString *count= [NSString stringWithFormat:@"%ld",(long)n];
//                
//                NSLog(@"%@",count);
//
//                for(int i=0; i<content.count; i++){
//                    
//                    NSString *Id = [content[i] objectForKey:@"movieId"];
//                    NSString *Name = [content[i] objectForKey:@"movieName"];
//                    NSString *Path = [content[i] objectForKey:@"moviePhoto"];
//                    NSString *newUrl = [CMRES_BaseURL stringByAppendingString:Path];
//                    [filmId addObject:Id];
//                    [filmName addObject:Name];
//                    [filmPhoto addObject:newUrl];
//                    
//                    [self.hotFilmList insertObjects:content atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, content.count)]];
//                    NSLog(@"%@",Path);
//                
//                }
//                
//                //[self getImageByURL];
//                [self reloadData];
//            
//            }else{
//            
//                NSDictionary *dic=[detailDict valueForKey:@"result"];
//                if(!!dic&&dic.count>0)
//                    result=[dic valueForKey:@"reason"];
//                
//                result=[NSString stringWithFormat:@"\n\n\t%@\t\n\n",result];
//                
//                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
//                [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"676767"]];
//                [SVProgressHUD setInfoImage:nil];
//                [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
//                [SVProgressHUD showInfoWithStatus:result];
//
//            
//            }
//        }];
//    
//    
//    }
//    
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    
//        return  self.filmName.count;
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    CGFloat w=[UIScreen mainScreen].bounds.size.width;
//    CGFloat h=[UIScreen mainScreen].bounds.size.height;
//
//    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld",(long)indexPath.row];
//    NSDictionary *dic = [self.hotFilmList objectAtIndex:indexPath.row];
//    //static NSString *cellIdentify = @"cell";
//	Cell *cell = [hortable dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    // NSDictionary *dic = [self.hotFilmList objectAtIndex:indexPath.row];
//	if (cell == nil){
//        
//        cell = [[Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        cell.transform = CGAffineTransformMakeRotation(M_PI/2);
//        
//    }
//    
//    cell.filmName.text = [dic objectForKey:@"movieName"];
//    NSString *url = [dic objectForKey:@"moviePhoto"];
//    NSString *newUrl = [CMRES_BaseURL stringByAppendingString:url];
//    NSURL *filmurl=[NSURL URLWithString:imgUrl[indexPath.row]];
//    [cell.imgView setImageWithURL:filmurl];
//    
//    //[[cell textLabel] setText:[_dataArray1 objectAtIndex:indexPath.row]];
//    //cell.textLabel.numberOfLines = 0;
//    //cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
//		
//    return cell;
//    
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    CGFloat w=[UIScreen mainScreen].bounds.size.width;
//    return w;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    //if(indexPath.section == 0){
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"trans" object:nil];
//    
//   // }
//    NSLog(@"点击%ld",(long)[indexPath row]);
//}
//
//-(void)reloadData
//{
//    [hortable reloadData];
//    //[self flushLoadingMoreFrame];
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


@end

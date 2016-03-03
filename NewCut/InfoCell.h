

#import <UIKit/UIKit.h>
#import "FilmDetailViewController.h"
//#import "EGOImageView.h"

//@class EGOImageView;
@interface InfoCell : UITableViewCell
{
    //UITableView *hortable;
    //NSInteger porsection;
//    NSDictionary *filmInfo;
//    NSMutableArray *filmPhoto;
//    NSMutableArray *filmId;
//    NSMutableArray *filmName;
//    NSMutableArray *content;
    
    NSInteger *movieId;
}

@property (strong, nonatomic) NSArray *images1;
@property (strong, nonatomic) NSArray *images2;
@property (strong,nonatomic) FilmDetailViewController *filmDetail;
@property (strong,nonatomic) NSDictionary *filmInfo;
@property (strong,nonatomic) NSMutableArray *filmPhoto;
@property (strong,nonatomic) NSMutableArray *filmId;
@property (strong,nonatomic) NSMutableArray *filmName;
@property (strong,nonatomic) NSMutableArray *content;
@property (strong,nonatomic) NSMutableArray *hotFilmList;
@property (strong,nonatomic) NSMutableArray *filmImage;
@property(nonatomic,strong) NSArray *imgUrlArr;
@property(nonatomic,strong) NSMutableArray *imgUrl;

//@property(nonatomic,retain) EGOImageView *egoImgView;
@property (strong,nonatomic)UIImageView *filmImageView;
@property (strong,nonatomic)UILabel *filmIdLab;
-(void)getFilmPhoto;
-(void)reloadData;
-(void)egoImageViewWithImg:(NSString *)imgURLStr;
@end

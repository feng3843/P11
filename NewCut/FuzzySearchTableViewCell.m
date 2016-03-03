//
//  FuzzySearchTableViewCell.m
//  NewCut
//
//  Created by uncommon on 2015/07/21.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "FuzzySearchTableViewCell.h"

@implementation FuzzySearchTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setSearchListInfo:(SearchListInfo *)searchListInfo
{
    
    [self setContrloHidden:searchListInfo];
    [self setContrloValue:searchListInfo];
}

//设置控件值
-(void)setContrloValue:(SearchListInfo *)searchListInfo{
    UIImage* image;
    
    switch ((int)searchListInfo.searchType) {
        case MoviesType:
            image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:searchListInfo.moviePhoto]]];
            [_imageViewMy setImage:image];
            _lblMovieName.text=[NSString stringWithFormat:@"%@",searchListInfo.movieName];
            _lblMovieWantSeeNum.text=@"";
            _lblMovieDirector.text=@"";
            _lblMovieToStar.text=@"";
            _lblReleaseDate.text=@"";
            break;
        case StarsType:
            image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:searchListInfo.starPhoto]]];
            [_imageViewMy setImage:image];
            _lblStarName.text=[NSString stringWithFormat:@"%@",searchListInfo.starName];
            _lblStarNationality.text=@"";
            _lblStarRepresentativeWorks.text=@"";
            break;
        case GoodType:
            image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:searchListInfo.goodPhoto]]];
            [_imageViewMy setImage:image];
            _lblGoodName.text=[NSString stringWithFormat:@"%@",searchListInfo.goodName];
            _lblGoodDescription.text=@"";
            _lblGoodLoveNum1.text=@"";
            _lblGoodLoveNum.text=@"";
            _lblGoodCommentNum1.text=@"";
            _lblGoodCommentNum.text=@"";
            break;
            
        default:
            break;
    }
}

//设置控件隐藏与显示
-(void)setContrloHidden:(SearchListInfo *)searchListInfo{
    BOOL isTypeMovies=NO;
    BOOL isTypeStars=NO;
    BOOL isTypeGood=NO;
    
    switch ((int)searchListInfo.searchType) {
        case MoviesType:
            isTypeMovies=YES;
            break;
        case StarsType:
            isTypeStars=YES;
            break;
        case GoodType:
            isTypeGood=YES;
            break;
            
        default:
            break;
    }
    
    //Movies
    _lblMovieName.hidden=!isTypeMovies;
    _lblMovieWantSeeNum.hidden=!isTypeMovies;
    _lblMovieWantSee2.hidden=!isTypeMovies;
    _lblMovieDirector.hidden=!isTypeMovies;
    _lblMovieToStar.hidden=!isTypeMovies;
    _lblReleaseDate.hidden=!isTypeMovies;
    
    //Star
    _lblStarName.hidden=!isTypeStars;
    _lblStarNationality.hidden=!isTypeStars;
    _lblStarRepresentativeWorks.hidden=!isTypeStars;

    //Goods
    _lblGoodName.hidden=!isTypeGood;
    _lblGoodDescription.hidden=!isTypeGood;
    _lblGoodLoveNum1.hidden=!isTypeGood;
    _lblGoodLoveNum.hidden=!isTypeGood;
    _lblGoodCommentNum1.hidden=!isTypeGood;
    _lblGoodCommentNum.hidden=!isTypeGood;
}

//异步加载图片
//- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse*)response{
//    //可以在显示图片前先用本地的一个loading.gif来占位。
//    UIImage *img = [[UIImage alloc] initWithContentsOfFile:@"loading.gif"];
//    [self.imageView setImage:img];
//    _data = [[NSMutableData alloc] init];
//    //保存接收到的响应对象，以便响应完毕后的状态。
//    _response = response;
//}
//- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data {
//    //_data为NSMutableData类型的私有属性，用于保存从网络上接收到的数据。
//    //也可以从此委托中获取到图片加载的进度。
//    [_data appendData:data];
//    NSLog(@"%lld%%", data.length/_response.expectedContentLength * 100);
//}
//- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error{
//    //请求异常，在此可以进行出错后的操作，如给UIImageView设置一张默认的图片等。
//}
//- (void)connectionDidFinishLoading:(NSURLConnection*)connection{
//    //加载成功，在此的加载成功并不代表图片加载成功，需要判断HTTP返回状态。
//    NSHTTPURLResponse*response=(NSHTTPURLResponse*)_response;
//    if(response.statusCode == 200){
//        //请求成功
//        UIImage *img=[UIImage imageWithData:_data];
//        [self.imageView setImage:img];
//    }
//}

@end

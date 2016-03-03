//
//  AdvertistingColumn.m
//  NewCut
//
//  Created by py on 15-7-16.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "AdvertistingColumn.h"
#import "PYAllCommon.h"
#import "CMAPI.h"
#import "SDImageView+SDWebCache.h"
#import "ADModel.h"
@implementation AdvertistingColumn

-(id)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.delegate = self;//设置代理UIscrollViewDelegate
        _scrollView.showsVerticalScrollIndicator = NO;//是否显示竖向滚动条
        _scrollView.showsHorizontalScrollIndicator = NO;//是否显示横向滚动条
        _scrollView.pagingEnabled = YES;//是否设置分页
        
        [self addSubview:_scrollView];
        
        /*
         ***容器，装载
         */
        UIView *containerView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)-20, CGRectGetWidth(self.frame), 20)];
        containerView.backgroundColor = [UIColor clearColor];
        [self addSubview:containerView];
        UIView *alphaView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(containerView.frame), CGRectGetHeight(containerView.frame))];
        alphaView.backgroundColor = [UIColor clearColor];
        alphaView.alpha = 0.7;
        [containerView addSubview:alphaView];
        
        //分页控制
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(100, 0, CGRectGetWidth(containerView.frame)-20, 20)];
        _pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//貌似不起作用呢
        _pageControl.currentPage = 0; //初始页码为0
        _pageControl.backgroundColor  = [UIColor clearColor];
        [containerView addSubview:_pageControl];
        //图片张数
        _imageNum = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, CGRectGetWidth(containerView.frame)-20, 20)];
        _imageNum.font = [UIFont boldSystemFontOfSize:15];
        _imageNum.backgroundColor = [UIColor clearColor];
        _imageNum.textColor = [UIColor whiteColor];
        _imageNum.textAlignment = NSTextAlignmentRight;
        //[containerView addSubview:_imageNum];
        /*
         ***配置定时器，自动滚动广告栏
         */
        
        [self performSelector:@selector(delayMethod) withObject:nil afterDelay:5.0f];
    }
    return self;

}

-(void)delayMethod
{
    timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    [[NSRunLoop  currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    [self openTimer];
}

-(void)timerAction:(NSTimer *)timer
{
    CGPoint newOffset = _scrollView.contentOffset;
    newOffset.x = newOffset.x + CGRectGetWidth(_scrollView.frame);
    //    NSLog(@"newOffset.x = %f",newOffset.x);
    if (newOffset.x > (CGRectGetWidth(_scrollView.frame) * (_totalNum-1))) {
        newOffset.x = 0 ;
    }
    int index = newOffset.x / CGRectGetWidth(_scrollView.frame);   //当前是第几个视图
    newOffset.x = index * CGRectGetWidth(_scrollView.frame);
    _imageNum.text = [NSString stringWithFormat:@"%d / %ld",index+1,(long)_totalNum];
    [_scrollView setContentOffset:newOffset animated:YES];
}


#pragma mark- PageControl绑定ScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{//滚动就执行（会很多次）
    if ([scrollView isMemberOfClass:[UITableView class]]) {
        
    }else {
        int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;   //当前是第几个视图
        _pageControl.currentPage = index;
        for (UIView *view in scrollView.subviews) {
            if(view.tag == index){
                
            }else{
                
            }
        }
    }
    //    NSLog(@"string%f",scrollView.contentOffset.x);
}
- (void)setArray:(NSArray *)imgArray{
    
    _totalNum = [imgArray count];
    if (_totalNum>0) {
        for (int i = 0; i<_totalNum; i++) {
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(i*CGRectGetWidth(_scrollView.frame), 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame))];
            img.contentMode = UIViewContentModeScaleAspectFill;
              ADModel *model = imgArray[i];
                NSString *path = [CMRES_ImageURL stringByAppendingPathComponent:model.stills];
                [img setImageWithURL:[NSURL URLWithString:path]  refreshCache:NO placeholderImage:[UIImage imageNamed:DEFAULT_IMAGE_FILM_H]];
//            img.image = [UIImage imageNamed:imgArray[i]];
            //img.backgroundColor = imgArray[i];
            [img setTag:i];
            [_scrollView addSubview:img];
        }
        _imageNum.text = [NSString stringWithFormat:@"%ld / %ld",_pageControl.currentPage+1,(long)_totalNum];
        _pageControl.numberOfPages = _totalNum; //设置页数 //滚动范围 600=300*2，分2页
        CGRect frame;
        frame = _pageControl.frame;
        frame.size.width = 15*_totalNum;
        frame.origin.x = (CGRectGetWidth(self.scrollView.frame) - CGRectGetWidth(frame))/2;
        _pageControl.frame = frame;
        [self openTimer];
    }else{
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame))];
        [img setImage:[UIImage imageNamed:@"comment_gray"]];
        img.userInteractionEnabled = YES;
        [_scrollView addSubview:img];
        _imageNum.text = @"提示：滚动栏无数据。";
        [self closeTimer];
    }
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.frame)*_totalNum,CGRectGetHeight(_scrollView.frame));//滚动范围 600=300*2，分2页
}

- (void)openTimer{
    [timer setFireDate:[NSDate distantPast]];//开启定时器
}

- (void)closeTimer{
    [timer setFireDate:[NSDate distantFuture]];//关闭定时器
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  FilmImageCell.m
//  NewCut
//
//  Created by py on 15-7-12.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "FilmImageCell.h"
#import "PYAllCommon.h"
#import "SDImageView+SDWebCache.h"
#import "myCollectionViewController.h"
#import "FilmDetailViewController.h"

@interface FilmImageCell()

@property (nonatomic, strong) NSMutableArray *blurImages;
@property (nonatomic, assign) CGFloat OTCoverHeight;
@property (nonatomic, strong) UIView* scrollHeaderView;

@end
@implementation FilmImageCell
@synthesize headerImageView,images1;

@synthesize delegate;

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    CGFloat w=[UIScreen mainScreen].bounds.size.width;
     self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     //CGRect bounds = [[UIScreen mainScreen] bounds];
     //self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, height)];
    if (self) {
        // hortable = [[UITableView alloc]initWithFrame:CGRectMake(100, -90, 225, 320) style:UITableViewStylePlain];
        hortable = [[UITableView alloc]initWithFrame:CGRectMake(25, -25, 270, 320) style:UITableViewStylePlain];
        hortable.delegate = self;
        hortable.dataSource = self;
        hortable.transform = CGAffineTransformMakeRotation(M_PI / 2 *3);
        hortable.showsVerticalScrollIndicator = NO;
        hortable.separatorStyle = UITableViewCellAccessoryNone;
        hortable.pagingEnabled = YES;
        [self addSubview:hortable];
        
//        self.images1 = @[[UIImage imageNamed:@"aa.jpg"],
//                         [UIImage imageNamed:@"bb.jpg"],
//                         [UIImage imageNamed:@"cc.jpg"],
//                         [UIImage imageNamed:@"dd.jpg"],
//                         [UIImage imageNamed:@"h.jpg"]];
        //“全部”按钮
        UIImage* imageGoAll = [UIImage imageNamed:@"bt_all.png"];
        UIButton *btnGoAll = [UIButton buttonWithType:UIButtonTypeCustom];
        btnGoAll.frame = CGRectMake(281, 90, 39, 101);
        [btnGoAll setBackgroundImage:imageGoAll forState:UIControlStateNormal];
        [btnGoAll addTarget:self action: @selector(notificationJump) forControlEvents: UIControlEventTouchUpInside];
        [self addSubview:btnGoAll];
        
        UILabel *hline = [[UILabel alloc]initWithFrame:CGRectMake(0, 270, w, 1)];
        hline.backgroundColor = [UIColor colorWithHexString:@"bababa"];
        [self addSubview:hline];

        
        
        
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(prepareForBlurImages) name:@"big" object:nil];
    
    return self;

}

- (NSMutableArray *)filmImages
{
    if (_filmImages == nil) {
        _filmImages = [NSMutableArray array];
    }
    return _filmImages;
}


//跳转到全部
-(void)notificationJump
{
    
    
    
    if ([self.delegate respondsToSelector:@selector(jump2BrowseImageViewController:)]) {
        [self.delegate jump2BrowseImageViewController:MoviesType];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [self.filmImages count];
   // return [images1 count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIImageView *filmImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 270)];
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld",(long)indexPath.row];
    
    NSString *url = [self.filmImages objectAtIndex:indexPath.row];
    NSString *newUrl = [CMRES_BaseURL stringByAppendingString:url];
    NSURL *filmurl=[NSURL URLWithString:newUrl];
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.transform = CGAffineTransformMakeRotation(M_PI/2);
        
        //[filmImageView setImage:[filmImages objectAtIndex:indexPath.row]];
        [filmImageView setImageWithURL:filmurl refreshCache:NO placeholderImage:[UIImage imageNamed:DEFAULT_IMAGE_FILM]];
       // [filmImageView setImage:[images1 objectAtIndex:indexPath.row]];
        [cell addSubview:filmImageView];
      
        
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 320;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"点击%ld",(long)[indexPath row]);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (FilmImageCell*)initWithTableViewWithHeaderImage:(UIImage*)headerImage withOTCoverHeight:(CGFloat)height{
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    self = [[FilmImageCell alloc] initWithFrame:bounds];
    
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, height)];
    [self.headerImageView setImage:headerImage];
    [self addSubview:self.headerImageView];
    
    self.OTCoverHeight = height;
    
    hortable = [[UITableView alloc] initWithFrame:self.frame];
    hortable.tableHeaderView.backgroundColor = [UIColor clearColor];
    hortable.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, height)];
    hortable.backgroundColor = [UIColor clearColor];
    
    
    [self addSubview:hortable];
    
    [hortable addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    self.blurImages = [[NSMutableArray alloc] init];
    [self prepareForBlurImages];
    

    return self;
}

- (FilmImageCell*)initWithScrollViewWithHeaderImage:(UIImage*)headerImage withOTCoverHeight:(CGFloat)height withScrollContentViewHeight:(CGFloat)ContentViewheight{
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    self = [[FilmImageCell alloc] initWithFrame:bounds];
    
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, height)];
    [self.headerImageView setImage:headerImage];
    [self addSubview:self.headerImageView];
    
    self.OTCoverHeight = height;
    
    scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    scrollView.backgroundColor = [UIColor clearColor];
    [self addSubview:scrollView];
    
    scrollContentView = [[UIView alloc] initWithFrame:CGRectMake(0, height, bounds.size.width, ContentViewheight)];
    scrollContentView.backgroundColor = [UIColor whiteColor];
    scrollView.contentSize = scrollContentView.frame.size;
    [scrollView addSubview:scrollContentView];
    
    [scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    self.blurImages = [[NSMutableArray alloc] init];
    [self prepareForBlurImages];
    
    return self;
}


- (void)prepareForBlurImages
{
    CGFloat factor = 0.1;
    [self.blurImages addObject:self.headerImageView.image];
    for (NSUInteger i = 0; i < self.OTCoverHeight/10; i++) {
        [self.blurImages addObject:[self.headerImageView.image boxblurImageWithBlur:factor]];
        factor+=0.04;
    }
}

- (void)setHeaderImage{
     for(int i=0;i<[self.filmImages count];i++){
           [self.headerImageView setImage:[self.filmImages objectAtIndex:i]];
     }
    
    [self.blurImages removeAllObjects];
    [self prepareForBlurImages];
}



@end
@implementation UIImage (Blur)

-(UIImage *)boxblurImageWithBlur:(CGFloat)blur {
    
    NSData *imageData = UIImageJPEGRepresentation(self, 1); // convert to jpeg
    UIImage* destImage = [UIImage imageWithData:imageData];
    
    
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = destImage.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    
    vImage_Error error;
    
    void *pixelBuffer;
    
    
    //create vImage_Buffer with data from CGImageRef
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //create vImage_Buffer for output
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    // Create a third buffer for intermediate processing
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    
    //perform convolution
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    
    CGImageRelease(imageRef);
    
    return returnImage;
}


//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}


@end


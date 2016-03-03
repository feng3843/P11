//
//  GoAllImageBrowse.h
//  NewCut
//
//  Created by uncommon on 2015/07/22.
//  Copyright (c) 2015年 py. All rights reserved.
//

#ifndef NewCut_GoAllImageBrowse_h
#define NewCut_GoAllImageBrowse_h

#import "EnumList.h"

@protocol GoAllImageBrowseDelegate

/** @brief 跳转到照片浏览界面 */
- (void)jump2BrowseImageViewController:(ExhibitionType)pExhibitionType;

@end

#endif

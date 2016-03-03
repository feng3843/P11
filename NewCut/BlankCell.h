//
//  BlankCell.h
//  NewCut
//
//  Created by py on 15-7-12.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    BlankCellTypeDouble,
    BlankCellTypeSingleUp,
    BlankCellTypeSingleDown
}BlankCellType;

@interface BlankCell : UITableViewCell

@property BlankCellType type;

@end

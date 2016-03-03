//
//  SettingTableViewCell.m
//  0410-彩票
//
//  Created by 夏雪 on 15/6/5.
//  Copyright (c) 2015年 夏雪. All rights reserved.
//

#import "SettingTableViewCell.h"
#import "SettingArrowItem.h"
#import "SettingSwitchItem.h"
#import "UIColor+Extensions.h"

@interface SettingTableViewCell()

/**
 *  这里一定要写强指针注意了
 *  右边的箭头
 */
@property(nonatomic ,strong)UIImageView *arrowImageView;

@property(nonatomic ,strong)UISwitch *rightSwitch;

@end
@implementation SettingTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/**
 *  懒加载

 */
- (UIImageView *)arrowImageView
{
    if (_arrowImageView == nil) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CellArrow"]];
 
        _arrowImageView = imageView;
    }
    return _arrowImageView;
}

- (UISwitch *)rightSwitch
{
    if (_rightSwitch == nil) {
        
        _rightSwitch = [[UISwitch alloc]init];
    }
    return _rightSwitch;
}

- (void)setItem:(SettingItem *)item
{
    _item = item;
    if (item.icon!=nil) {
        
         self.imageView.image = [UIImage imageNamed:item.icon];
    }
   
    self.textLabel.text = item.title;
    
    // 箭头
    if ([item isKindOfClass:[SettingArrowItem class]]) {
//        self.accessoryView = self.arrowImageView;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
      
    }
    else if ([item isKindOfClass:[SettingSwitchItem class]])  // 开关
    {
        self.accessoryView = self.rightSwitch;
          self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
        
}

- (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"setting";
  
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[SettingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"666666"];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        
    }
    return cell;
    
}

+ (instancetype)initWithTableView:(UITableView *)tableView
{
    return [[[self alloc]init]cellWithTableView:tableView];
}

@end

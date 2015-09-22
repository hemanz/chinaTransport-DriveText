//
//  KuaidiDetailCell.h
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/12.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KuaidiDetailCell : UITableViewCell
{
    UILabel *dayLabel;
    UILabel *timeLabel;
    UILabel *desLabel;
    UIImageView *logoImgView;
    UILabel *vLabel;
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withType:(NSString *)type;
-(void)configDay:(NSString *)dayString time:(NSString *)timeString des:(NSString *)desString;
//@property (nonatomic,copy)NSString *type;
@end

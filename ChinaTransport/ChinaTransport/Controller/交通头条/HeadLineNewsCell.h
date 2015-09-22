//
//  HeadLineNewsCell.h
//  ChinaTransport
//
//  Created by 张鹤楠 on 15/9/10.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THeadLineNewsModel.h"

@interface HeadLineNewsCell : UITableViewCell

@property (nonatomic, strong) THeadLineNewsModel *newsModel;

@property (strong, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *souce;

@property (weak, nonatomic) IBOutlet UIImageView *pic;
@property (weak, nonatomic) IBOutlet UIImageView *sencondPic;
@property (weak, nonatomic) IBOutlet UIImageView *thirdPic;

+ (NSInteger) idForRow:(THeadLineNewsModel *)model;

+ (CGFloat) heighForRow:(THeadLineNewsModel *)model;
@end

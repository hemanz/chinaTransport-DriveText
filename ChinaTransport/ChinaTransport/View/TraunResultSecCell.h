//
//  TraunResultSecCell.h
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/14.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrainPriceModel.h"

@interface TraunResultSecCell : UITableViewCell
{
//        票价信息
    UILabel *sitLevelLabel;
    UILabel *priceLabel;
    UILabel *numLabel;
}
//-(void)config:(NSString *)sit andSale:(NSString *)sale num:(NSString *)num;
@property (nonatomic,retain)TrainPriceModel *trainPriceModel;
@end

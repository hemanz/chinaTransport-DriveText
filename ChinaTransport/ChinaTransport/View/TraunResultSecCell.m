//
//  TraunResultSecCell.m
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/14.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "TraunResultSecCell.h"

@implementation TraunResultSecCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]  ) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    //sitLevelLabel;
    sitLevelLabel = [MyControl createLabelWithFrame:CGRectMake(30, 15, 60, 20) text:nil font:16 textcolor:RGBCOLOR(51, 51, 51) textAlignment:0 backgroundColor:nil];
    [self.contentView addSubview:sitLevelLabel];
    //priceLabel
    priceLabel = [MyControl createLabelWithFrame:CGRectMake(wid/2-50, 15, 100, 20) text:nil font:15 textcolor:RGBCOLOR(250, 103, 67) textAlignment:1 backgroundColor:nil];
    [self.contentView addSubview:priceLabel];
    //numLabel
    numLabel= [MyControl createLabelWithFrame:CGRectMake(wid-90, 15, 60, 20) text:nil font:14 textcolor:nil textAlignment:2 backgroundColor:nil];
    [self.contentView addSubview:numLabel];
}
-(void)layoutSubviews{
    if ([self.trainPriceModel.sitType isEqualToString:@"swz_num"]) {
        sitLevelLabel.text = @"商务座";
    }
    if ([self.trainPriceModel.sitType isEqualToString:@"zy_num"]) {
        sitLevelLabel.text = @"一等座";
    }
    if ([self.trainPriceModel.sitType isEqualToString:@"ze_num"]) {
        sitLevelLabel.text = @"二等座";
    }
    if ([self.trainPriceModel.sitType isEqualToString:@"yz_num"]) {
        sitLevelLabel.text = @"硬座";
    }
    if ([self.trainPriceModel.sitType isEqualToString:@"yw_num"]) {
        sitLevelLabel.text = @"硬卧";
    }
    if ([self.trainPriceModel.sitType isEqualToString:@"wz_num"]) {
        sitLevelLabel.text = @"无座";
    }
    if ([self.trainPriceModel.sitType isEqualToString:@"tz_num"]) {
        sitLevelLabel.text = @"特等座";
    }
    if ([self.trainPriceModel.sitType isEqualToString:@"rz_num"]) {
        sitLevelLabel.text = @"软座";
    }
    if ([self.trainPriceModel.sitType isEqualToString:@"rw_num"]) {
        sitLevelLabel.text = @"软卧";
    }
    
    if ([self.trainPriceModel.sitType isEqualToString:@"qt_num"]) {
        sitLevelLabel.text = @"其他";
    }
    if ([self.trainPriceModel.sitType isEqualToString:@"gr_num"]) {
        sitLevelLabel.text = @"高级软卧";
    }
    priceLabel.text = self.trainPriceModel.price;
    numLabel.text = self.trainPriceModel.sitNum;
    numLabel.textColor =RGBCOLOR(102, 102, 102);
    if (self.trainPriceModel.limitNum) {
        numLabel.textColor =RGBCOLOR(250, 103, 67);
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

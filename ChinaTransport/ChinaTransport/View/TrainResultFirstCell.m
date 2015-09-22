//
//  TrainResultFirstCell.m
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/14.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "TrainResultFirstCell.h"
#import "masonry.h"
@implementation TrainResultFirstCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]  ) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
//    time
    startTimeLabel = [[UILabel alloc] init];
    startTimeLabel.font = [UIFont systemFontOfSize:16];
    startTimeLabel.textColor = RGBCOLOR(51, 51, 51);
    [self.contentView addSubview:startTimeLabel];
    arriveTimeLabel = [[UILabel alloc] init];
    arriveTimeLabel.font = [UIFont systemFontOfSize:13];
    arriveTimeLabel.textColor = RGBCOLOR(51, 51, 51);
    [self.contentView addSubview:arriveTimeLabel];
//    station
    isStartImg = [[UIImageView alloc] init];
    
    [self.contentView addSubview:isStartImg];
    isEndImg = [[UIImageView alloc] init];
    
    [self.contentView addSubview:isEndImg];
    fromStationLabel = [[UILabel alloc] init];
    fromStationLabel.font = [UIFont systemFontOfSize:15];
    fromStationLabel.textColor = RGBCOLOR(51, 51, 51);
    [self.contentView addSubview:fromStationLabel];
    toStationLabel = [[UILabel alloc] init];
    toStationLabel.font = [UIFont systemFontOfSize:13];
    toStationLabel.textColor = RGBCOLOR(102, 102, 102);
    [self.contentView addSubview:toStationLabel];
//    checi
    cheCiLabel = [[UILabel alloc] init];
    cheCiLabel.font = [UIFont systemFontOfSize:16];
    cheCiLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:cheCiLabel];
    lishiLabel = [[UILabel alloc] init];
    lishiLabel.font = [UIFont systemFontOfSize:11];
    lishiLabel.textColor = RGBCOLOR(102, 102, 102);
    [self.contentView addSubview:lishiLabel];
//    sale
    saleLabel = [[UILabel alloc] init];
    saleLabel.font = [UIFont systemFontOfSize:15];
    saleLabel.textColor = RGBCOLOR(255, 52, 2);
    [self.contentView addSubview:saleLabel];
    numLabel = [[UILabel alloc] init];
    numLabel.font = [UIFont systemFontOfSize:11];
    numLabel.textColor = RGBCOLOR(102, 102, 102);
    [self.contentView addSubview:numLabel];
//    mas_make
    [startTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(10);
        make.top.equalTo(self.contentView).with.offset(10);
        make.centerY.equalTo(@[isStartImg,fromStationLabel,cheCiLabel,saleLabel]);
    }];
    [arriveTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(10);
        make.top.equalTo(startTimeLabel.mas_bottom).with.offset(8);
        make.centerY.equalTo(@[isEndImg,toStationLabel,lishiLabel,numLabel]);
    }];
    [fromStationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(52, 16));
        make.right.equalTo(self.contentView.mas_centerX).with.offset(-3);
    }];
    [toStationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(52, 16));
        make.right.equalTo(self.contentView.mas_centerX).with.offset(-3);
    }];
    [isStartImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(fromStationLabel.mas_left).with.offset(-6);
        make.size.mas_equalTo(CGSizeMake(14, 14));
    }];
    [isEndImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(toStationLabel.mas_left).with.offset(-6);
        make.size.mas_equalTo(CGSizeMake(14, 14));
    }];
    [cheCiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_centerX).with.offset(20);
    }];
    [lishiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_centerX).with.offset(20);
    }];
    [saleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
    }];
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
    }];
    
    
}


-(void)layoutSubviews{
    startTimeLabel.text = self.trainModel.start_time;
    arriveTimeLabel.text = self.trainModel.arrive_time;
    fromStationLabel.text = self.trainModel.from_station_name;
    toStationLabel.text = self.trainModel.to_station_name;
    cheCiLabel.text = self.trainModel.station_train_code;
    lishiLabel.text = self.trainModel.lishi;
    if ([self.trainModel.start_station_name isEqualToString: self.trainModel.from_station_name]) {
        isStartImg.image =[UIImage imageNamed:@"始"];
    }else{
        isStartImg.image=nil;
    }
    if ([self.trainModel.end_station_name isEqualToString: self.trainModel.to_station_name]) {
        isEndImg.image =[UIImage imageNamed:@"终"];
    }else{
        isEndImg.image=nil;
    }
    if ([self.trainModel.canWebBuy isEqualToString:@"Y"]) {
        if (![self.trainModel.yz_num isEqualToString:@"--"]) {
            numLabel.text=[NSString stringWithFormat:@"硬座 %@",self.trainModel.yz_num];
        }else{
            if (![self.trainModel.yw_num isEqualToString:@"--"]) {
                 numLabel.text=[NSString stringWithFormat:@"硬卧 %@",self.trainModel.yw_num];
            }else{
                if (![self.trainModel.rz_num isEqualToString:@"--"]) {
                    numLabel.text=[NSString stringWithFormat:@"软座 %@",self.trainModel.rz_num];
                }else{
                    if (![self.trainModel.rw_num isEqualToString:@"--"]) {
                        numLabel.text=[NSString stringWithFormat:@"软卧 %@",self.trainModel.rw_num];
                    }else{
                        if (![self.trainModel.ze_num isEqualToString:@"--"]) {
                            numLabel.text=[NSString stringWithFormat:@"二等座 %@",self.trainModel.ze_num];
                        }else{
                            if (![self.trainModel.zy_num isEqualToString:@"--"]) {
                                numLabel.text=[NSString stringWithFormat:@"一等座 %@",self.trainModel.zy_num];
                            }else{
                                if (![self.trainModel.tz_num isEqualToString:@"--"]) {
                                    numLabel.text=[NSString stringWithFormat:@"特等座 %@",self.trainModel.tz_num];
                                }else{
                                    if (![self.trainModel.wz_num isEqualToString:@"--"]) {
                                        numLabel.text=[NSString stringWithFormat:@"无座 %@",self.trainModel.wz_num];
                                    }else{
                                        numLabel.text=@"无";
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

    }else{
        numLabel.text=@"无";
    }
}

@end

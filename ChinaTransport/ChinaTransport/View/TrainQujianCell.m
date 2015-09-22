//
//  TrainResultCell.m
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/12.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "TrainQujianCell.h"
#import "Masonry.h"

@implementation TrainQujianCell

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
        stationNoLabel = [[UILabel alloc] init];
        stationNoLabel.textAlignment =NSTextAlignmentCenter;
        [self.contentView addSubview:stationNoLabel];
        stationNameLabel = [[UILabel alloc] init];
        stationNameLabel.textAlignment =NSTextAlignmentCenter;
        [self.contentView addSubview:stationNameLabel];
        arriveTimeLabel = [[UILabel alloc] init];
        arriveTimeLabel.textAlignment =NSTextAlignmentCenter;
        [self.contentView addSubview:arriveTimeLabel];
        startTimeLabel = [[UILabel alloc] init];
        startTimeLabel.textAlignment =NSTextAlignmentCenter;
        [self.contentView addSubview:startTimeLabel];
        stopoverTimeLabel = [[UILabel alloc] init];
        stopoverTimeLabel.textAlignment =NSTextAlignmentCenter;
        [self.contentView addSubview:stopoverTimeLabel];
        [stationNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).with.offset(12);
            make.size.mas_equalTo(CGSizeMake(wid/5, 20));
            make.centerY.equalTo(@[stationNameLabel,arriveTimeLabel,startTimeLabel,stopoverTimeLabel]);
        }];
        [stationNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(stationNoLabel.mas_right);
            make.size.mas_equalTo(CGSizeMake(wid/5, 20));
        }];
        [arriveTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(stationNameLabel.mas_right);
            make.size.mas_equalTo(CGSizeMake(wid/5, 20));
        }];
        [startTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(arriveTimeLabel.mas_right);
            make.size.mas_equalTo(CGSizeMake(wid/5, 20));
        }];
        [stopoverTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(startTimeLabel.mas_right);
            make.size.mas_equalTo(CGSizeMake(wid/5, 20));
        }];
}


-(void)layoutSubviews{
    stationNoLabel.text = self.trainQujianModel.station_no;
    stationNameLabel.text = self.trainQujianModel.station_name;
    arriveTimeLabel.text = self.trainQujianModel.arrive_time;
    startTimeLabel.text = self.trainQujianModel.start_time;
    stopoverTimeLabel.text = self.trainQujianModel.stopover_time;

    if (self.trainQujianModel.cellType==TrainQujianCellTypeUnselected) {
        stationNoLabel.textColor =RGBCOLOR(51, 51, 51);
        stationNoLabel.font = [UIFont systemFontOfSize:14];
        stationNameLabel.textColor =RGBCOLOR(51, 51, 51);
        stationNameLabel.font = [UIFont systemFontOfSize:14];
        arriveTimeLabel.textColor =RGBCOLOR(51, 51, 51);
        arriveTimeLabel.font = [UIFont systemFontOfSize:14];
        startTimeLabel.textColor =RGBCOLOR(51, 51, 51);
        startTimeLabel.font = [UIFont systemFontOfSize:14];
        stopoverTimeLabel.textColor =RGBCOLOR(51, 51, 51);
        stopoverTimeLabel.font = [UIFont systemFontOfSize:14];
    
    }else if (self.trainQujianModel.cellType==TrainQujianCellTypeSelected){
        stationNoLabel.textColor =[UIColor redColor];
        stationNoLabel.font = [UIFont systemFontOfSize:14];
        stationNameLabel.textColor =[UIColor redColor];
        stationNameLabel.font = [UIFont systemFontOfSize:14];
        arriveTimeLabel.textColor =[UIColor redColor];
        arriveTimeLabel.font = [UIFont systemFontOfSize:14];
        startTimeLabel.textColor =[UIColor redColor];
        startTimeLabel.font = [UIFont systemFontOfSize:14];
        stopoverTimeLabel.textColor =[UIColor redColor];
        stopoverTimeLabel.font = [UIFont systemFontOfSize:14];
    }else if (self.trainQujianModel.cellType==TrainQujianCellTypeCannotSelected){
        stationNoLabel.textColor =[UIColor grayColor];
        stationNoLabel.font = [UIFont systemFontOfSize:14];
        stationNameLabel.textColor =[UIColor grayColor];
        stationNameLabel.font = [UIFont systemFontOfSize:14];
        arriveTimeLabel.textColor =[UIColor grayColor];
        arriveTimeLabel.font = [UIFont systemFontOfSize:14];
        startTimeLabel.textColor =[UIColor grayColor];
        startTimeLabel.font = [UIFont systemFontOfSize:14];
        stopoverTimeLabel.textColor =[UIColor grayColor];
        stopoverTimeLabel.font = [UIFont systemFontOfSize:14];
    }else if (self.trainQujianModel.cellType==TrainQujianCellTypeStartStationRow){
        stationNoLabel.textColor =RGBCOLOR(9, 131, 145);
        stationNoLabel.font = [UIFont systemFontOfSize:14];
        stationNameLabel.textColor =RGBCOLOR(9, 131, 145);
        stationNameLabel.font = [UIFont systemFontOfSize:14];
        arriveTimeLabel.textColor =RGBCOLOR(9, 131, 145);
        arriveTimeLabel.font = [UIFont systemFontOfSize:14];
        startTimeLabel.textColor =RGBCOLOR(9, 131, 145);
        startTimeLabel.font = [UIFont systemFontOfSize:14];
        stopoverTimeLabel.textColor =RGBCOLOR(9, 131, 145);
        stopoverTimeLabel.font = [UIFont systemFontOfSize:14];
    }

    else{
        stationNoLabel.textColor =[UIColor whiteColor];;
        stationNoLabel.font = [UIFont systemFontOfSize:15];
        stationNameLabel.textColor =[UIColor whiteColor];
        stationNameLabel.font = [UIFont systemFontOfSize:15];
        arriveTimeLabel.textColor =[UIColor whiteColor];
        arriveTimeLabel.font = [UIFont systemFontOfSize:15];
        startTimeLabel.textColor =[UIColor whiteColor];
        startTimeLabel.font = [UIFont systemFontOfSize:15];
        stopoverTimeLabel.textColor =[UIColor whiteColor];
        stopoverTimeLabel.font = [UIFont systemFontOfSize:15];

    }
}

@end

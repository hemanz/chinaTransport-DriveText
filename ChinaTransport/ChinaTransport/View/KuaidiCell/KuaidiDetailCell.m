//
//  KuaidiDetailCell.m
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/12.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "KuaidiDetailCell.h"
#import "Masonry.h"

@implementation KuaidiDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withType:(NSString *)type
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]  ) {
        if ([type isEqualToString:@"section1"]) {
            [self makeUI];
        }else{
        [self createUI];
        }
    }
    return self;
}

-(void)createUI {
    //标签
    dayLabel = [[UILabel alloc] init];
    dayLabel.font =[UIFont systemFontOfSize:14];
    dayLabel.textColor =RGBCOLOR(51, 51, 51);
    [self.contentView addSubview:dayLabel];
    timeLabel = [[UILabel alloc] init];
    timeLabel.font =[UIFont systemFontOfSize:18];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.textColor =RGBCOLOR(51, 51, 51);
    [self.contentView addSubview:timeLabel];
    logoImgView = [[UIImageView alloc] init];
    logoImgView.image = [UIImage imageNamed:@"向上箭头@2x(1)"];
    [self.contentView addSubview:logoImgView];
    desLabel = [[UILabel alloc] init];
    desLabel.font =[UIFont systemFontOfSize:16];
    desLabel.textColor =RGBCOLOR(51, 51, 51);
    desLabel.numberOfLines = 0;
    [self.contentView addSubview:desLabel];
    vLabel = [[UILabel alloc] init];
    vLabel.backgroundColor = RGBACOLOR(200, 200, 200, 0.6);
    [self.contentView addSubview:vLabel];
}
-(void)makeUI{
    //标签
//    dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 25,74, 20)];
    dayLabel = [[UILabel alloc] init];
    dayLabel.font =[UIFont systemFontOfSize:13];
    dayLabel.textColor =[UIColor orangeColor];
    [self.contentView addSubview:dayLabel];
//    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(dayLabel.frame)+5, 74, 20)];
    timeLabel = [[UILabel alloc] init];
    timeLabel.font =[UIFont systemFontOfSize:18];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.textColor =[UIColor orangeColor];
    [self.contentView addSubview:timeLabel];
//    logoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(timeLabel.frame)+5, CGRectGetMaxY(dayLabel.frame)+5, 17, 17)];
    logoImgView = [[UIImageView alloc] init];
    logoImgView.image = [UIImage imageNamed:@"时钟"];
    [self.contentView addSubview:logoImgView];
    desLabel = [[UILabel alloc] init];
    desLabel.font =[UIFont systemFontOfSize:16];
    desLabel.textColor =[UIColor orangeColor];
    desLabel.numberOfLines = 0;
    [self.contentView addSubview:desLabel];
    vLabel = [[UILabel alloc] init];
    vLabel.backgroundColor = RGBACOLOR(200, 200, 200, 0.6);
    [self.contentView addSubview:vLabel];
    

}
-(void)configDay:(NSString *)dayString time:(NSString *)timeString des:(NSString *)desString
{
    dayLabel.text = dayString;
    timeLabel.text = timeString;
    desLabel.text = desString;
//    desLabel.frame = CGRectMake(wid-14-74-5-17-5, 25, wid-10-74-5-17-5-10, [self getTextSize:desString]);
    [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(wid-10-76-5-17-8-10, [self getTextSize:desString]));
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-20);
    }];
    [logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).with.offset(14+74+5);
        make.centerY.equalTo(desLabel.mas_centerY);
        make.right.equalTo(desLabel.mas_left).with.offset(-10);
    }];
    [dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(logoImgView.mas_centerY).with.offset(-13);
        make.left.equalTo(self.contentView).with.offset(14);
        make.size.mas_equalTo(CGSizeMake(76, 20));
    }];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dayLabel.mas_bottom).offset(0);
        make.size.mas_equalTo(CGSizeMake(76, 20));
        make.left.equalTo(self.contentView).with.offset(14);

    }];
    [vLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(logoImgView.mas_centerX).with.offset(-0.5);
        make.size.mas_equalTo(CGSizeMake(1, [self getTextSize:desString]+50));
    }];
}
    
  
//   根据字数判断size
-(CGFloat)getTextSize:(NSString *)string{
    CGSize size = CGSizeMake(wid-10-74-5-17-8-10,999);//LableWight标签宽度，固定的
    //计算实际frame大小，并将label的frame变成实际大小
    UIFont *font =[UIFont systemFontOfSize:16 weight:50];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGRect rect =  [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    return rect.size.height;
}

@end

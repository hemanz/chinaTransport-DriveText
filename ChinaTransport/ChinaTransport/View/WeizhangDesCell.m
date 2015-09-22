//
//  WeizhangDesCell.m
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/19.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "WeizhangDesCell.h"

@implementation WeizhangDesCell

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
    bgImgView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"renqi的圆角矩形-1"]];
    [self.contentView addSubview:bgImgView];
    timeLabel =[MyControl createLabelWithtext:nil font:13 textcolor:RGBCOLOR(102, 102, 102) backgroundColor:nil];
    jifenLabel =[MyControl createLabelWithtext:@"计分分数" font:17 textcolor:RGBCOLOR(51, 51, 51) backgroundColor:nil];
    jifenNumLabel=[MyControl createLabelWithtext:nil font:16 textcolor:[UIColor orangeColor] backgroundColor:nil];
    fakuanLabel =[MyControl createLabelWithtext:@"罚款金额" font:17 textcolor:RGBCOLOR(51, 51, 51) backgroundColor:nil];
    fakuanNumLabel=[MyControl createLabelWithtext:nil font:17 textcolor:[UIColor orangeColor] backgroundColor:nil];
    jiaoKuanStatus =[MyControl createLabelWithtext:nil font:16 textcolor:[UIColor orangeColor] backgroundColor:nil];
    cjjgLabel =[MyControl createLabelWithtext:@"采集机关" font:17 textcolor:RGBCOLOR(51, 51, 51) backgroundColor:nil];
    cjjgDesLabel =[MyControl createLabelWithtext:nil font:15 textcolor:RGBCOLOR(101, 101, 101) backgroundColor:nil];
    wfdzLabel =[MyControl createLabelWithtext:@"违法地址" font:17 textcolor:RGBCOLOR(51, 51, 51) backgroundColor:nil];
    wfdzDesLabel =[MyControl createLabelWithtext:nil font:15 textcolor:RGBCOLOR(101, 101, 101) backgroundColor:nil];
    wfxwLabel =[MyControl createLabelWithtext:@"违法行为" font:17 textcolor:RGBCOLOR(51, 51, 51) backgroundColor:nil];
    wfxwDesLabel =[MyControl createLabelWithtext:nil font:15 textcolor:RGBCOLOR(101, 101, 101) backgroundColor:nil];
    [bgImgView addSubview:timeLabel];
    [bgImgView addSubview:jifenLabel];
    [bgImgView addSubview:jifenNumLabel];
    [bgImgView addSubview:fakuanLabel];
    [bgImgView addSubview:fakuanNumLabel];
    [bgImgView addSubview:jiaoKuanStatus];
    [bgImgView addSubview:cjjgLabel];
    [bgImgView addSubview:cjjgDesLabel];
    [bgImgView addSubview:wfdzLabel];
    [bgImgView addSubview:wfdzDesLabel];
    [bgImgView addSubview:wfxwLabel];
    [bgImgView addSubview:wfxwDesLabel];
    
}
-(void)layoutSubviews{
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgImgView).with.offset(3);
        make.right.equalTo(bgImgView.mas_right).with.offset(-6);
    }];
    [jifenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeLabel.mas_bottom).with.offset(12);
        make.left.equalTo(bgImgView).with.offset(10);
        make.centerY.equalTo(@[jifenNumLabel,fakuanLabel,fakuanNumLabel,jiaoKuanStatus]);
    }];
    [jifenNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(jifenLabel.mas_right).with.offset(10);
    }];
    [fakuanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgImgView.mas_centerX);
    }];
    [fakuanNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fakuanLabel.mas_right).with.offset(10);
    }];
    [jiaoKuanStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgImgView).with.offset(-20);
    }];
    [cjjgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(jifenLabel.mas_bottom).with.offset(15);
        make.left.equalTo(bgImgView).with.offset(10);
    }];
    [cjjgDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(jifenLabel.mas_bottom).with.offset(15);
        make.left.equalTo(cjjgLabel.mas_right).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(wid-120, [self getTextSize:self.weizhangDesModel.fxjg]));
    }];
    [wfdzLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cjjgDesLabel.mas_bottom).with.offset(15);
        make.left.equalTo(bgImgView).with.offset(10);
    }];
    [wfdzDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cjjgDesLabel.mas_bottom).with.offset(15);
        make.left.equalTo(wfdzLabel.mas_right).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(wid-120, [self getTextSize:self.weizhangDesModel.wfdz]));
    }];
    [wfxwLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wfdzDesLabel.mas_bottom).with.offset(15);
        make.left.equalTo(bgImgView).with.offset(10);
    }];
    [wfxwDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wfdzDesLabel.mas_bottom).with.offset(15);
        make.left.equalTo(wfxwLabel.mas_right).with.offset(10);
        make.bottom.equalTo(bgImgView.mas_bottom).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(wid-120, [self getTextSize:self.weizhangDesModel.wfxw]));
    }];
    
    [bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(10);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).with.offset(-5);
    }];
    

    timeLabel.text = self.weizhangDesModel.wfsj;
    jifenNumLabel.text = self.weizhangDesModel.kffs;
    fakuanNumLabel.text = self.weizhangDesModel.fkje;
    cjjgDesLabel.text = self.weizhangDesModel.fxjg;
    wfdzDesLabel.text = self.weizhangDesModel.wfdz;
    wfxwDesLabel.text = self.weizhangDesModel.wfxw;
}
//   根据字数判断size
-(CGFloat)getTextSize:(NSString *)string{
    CGSize size = CGSizeMake(wid-120,999);//LableWight标签宽度，固定的
    //计算实际frame大小，并将label的frame变成实际大小
    UIFont *font =[UIFont systemFontOfSize:16 ];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGRect rect =  [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    return rect.size.height;
}

@end

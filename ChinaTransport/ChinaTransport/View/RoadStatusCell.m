//
//  RoadStatusCell.m
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/16.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "RoadStatusCell.h"

@implementation RoadStatusCell

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
    
    topImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 1, wid-20,44 )];
    topImgView.image=[UIImage imageNamed:@"renqi的圆角矩形-1"];
    [self.contentView addSubview:topImgView];
    logoImgView =[MyControl createImageViewFrame:CGRectMake(10, 10, 45, 24) imageName:nil];
    [topImgView addSubview:logoImgView];
    titleLabel = [MyControl createLabelWithFrame:CGRectMake(CGRectGetMaxX(logoImgView.frame)+10, 10, 70, 24) text:nil font:17 textcolor:RGBCOLOR(51, 51, 51) textAlignment:0 backgroundColor:nil];
    [topImgView addSubview:titleLabel];
    typeLabel =[MyControl createLabelWithFrame:CGRectMake(wid-20-20-100, 15, 30, 20) text:nil font:13 textcolor:RGBCOLOR(102, 102, 102) textAlignment:0 backgroundColor:nil];
    [topImgView addSubview:typeLabel];
    timeLable =[MyControl createLabelWithFrame:CGRectMake(wid-20-20-65, 15, 80, 20) text:nil font:13 textcolor:[UIColor grayColor] textAlignment:0 backgroundColor:nil];
    [topImgView addSubview:timeLable];
    botImgView = [[UIImageView alloc] init];
    botImgView.image=[UIImage imageNamed:@"renqi的圆角矩形-1"];
    [self.contentView addSubview:botImgView];
    sizeStringLabel = [MyControl createLabelWithtext:nil font:18 textcolor:RGBCOLOR(102, 102, 102) backgroundColor:nil];
    [botImgView addSubview:sizeStringLabel];
    
}


-(void)layoutSubviews{
    if ([self.roadStatusmodel.status isEqualToString:@"0301"]) {
        logoImgView.image = [UIImage imageNamed:@"事故"];
        titleLabel.text = @"事故路段";
    }
    else if ([self.roadStatusmodel.status isEqualToString:@"0302"]) {
        logoImgView.image = [UIImage imageNamed:@"交通畅通"];
        titleLabel.text = @"交通畅通";
    }
    else if ([self.roadStatusmodel.status isEqualToString:@"0303"]) {
        logoImgView.image = [UIImage imageNamed:@"缓慢通行"];
        titleLabel.text = @"交通拥堵";
    }
    timeLable.text =self.roadStatusmodel.time;
    
    CGFloat sizeHeight = [self getTextSize:self.roadStatusmodel.content];
    botImgView.frame = CGRectMake(10, 46, wid-20,sizeHeight+15 );
    sizeStringLabel.text =self.roadStatusmodel.content;
    sizeStringLabel.frame =CGRectMake(10,5 , wid-40, sizeHeight);
    typeLabel.text = self.roadStatusmodel.type;
}
//   根据字数判断size
-(CGFloat)getTextSize:(NSString *)string{
    CGSize size = CGSizeMake(wid-20,999);//LableWight标签宽度，固定的
    //计算实际frame大小，并将label的frame变成实际大小
    UIFont *font =[UIFont systemFontOfSize:18 weight:50];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGRect rect =  [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    return rect.size.height;
}

@end

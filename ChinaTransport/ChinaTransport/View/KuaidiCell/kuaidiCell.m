//
//  kuaidiCell.m
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/11.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "kuaidiCell.h"

@implementation kuaidiCell

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
    //图片
    logoImageView = [MyControl createImageViewFrame:CGRectMake(25, 7,36, 36) imageName:nil];
    logoImageView.layer.masksToBounds = YES;
    logoImageView.layer.cornerRadius = 8;
    [self.contentView addSubview:logoImageView];
    
    //标签
    nameLable = [MyControl createLabelWithFrame:CGRectMake(CGRectGetMaxX(logoImageView.frame)+30, 10, 150, 30) text:nil font:18 textcolor:RGBCOLOR(51, 51, 51) textAlignment:0 backgroundColor:nil];
    [self.contentView addSubview:nameLable];

}
-(void)config:(NSString *)logoImage andName:(NSString *)titleString{
    logoImageView.image = [UIImage imageNamed:logoImage];
    nameLable.text = titleString;
}
@end

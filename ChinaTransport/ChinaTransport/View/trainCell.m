//
//  trainCell.m
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/12.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "trainCell.h"

@implementation trainCell

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
    //titleLabel
    titleLabel = [MyControl createLabelWithFrame:CGRectMake(18, 15, 52, 20) text:nil font:13 textcolor:RGBCOLOR(15, 141, 156) textAlignment:0 backgroundColor:nil];
    [self.contentView addSubview:titleLabel];
    //textLabel
    textLabel = [MyControl createLabelWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame)+10, 15, 150, 20) text:nil font:18 textcolor:[UIColor blackColor] textAlignment:0 backgroundColor:nil];
    [self.contentView addSubview:textLabel];
    
}
-(void)config:(NSString *)title andName:(NSString *)text{
    titleLabel.text = title;
    textLabel.text = text;
}

@end

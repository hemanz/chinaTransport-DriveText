//
//  DrivingAnswerTableViewCell.m
//  ChinaTransport
//
//  Created by herr on 15/9/18.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "DrivingAnswerTableViewCell.h"
#import "Masonry.h"

@implementation DrivingAnswerTableViewCell

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
    flagImageView = [[UIImageView alloc] init];

    [self.contentView addSubview:flagImageView];
    answerLabel = [[UILabel alloc] init];
    answerLabel.textAlignment =NSTextAlignmentLeft;
    answerLabel.font=[UIFont systemFontOfSize:14];
    answerLabel.numberOfLines=0;
    [self.contentView addSubview:answerLabel];

//    [flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentView).with.offset(12);
//        make.left.equalTo(self.contentView).with.offset(20);
//        make.size.mas_equalTo(CGSizeMake(19, 19));
//        make.centerY.equalTo(@[answerLabel]);
//    }];
//    [answerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(flagImageView.mas_right).with.offset(20);
//        make.size.mas_equalTo(CGSizeMake(250, 20));
//    }];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    NSString *pngStr=[NSString stringWithFormat:@"answer%@",self.drivingAnswerModel.answerOrder];

    answerLabel.text = self.drivingAnswerModel.answerContent;
    switch (self.drivingAnswerModel.answerChooseType) {
        case DrivingAnswerTypeNotChoose:
            break;
        case DrivingAnswerTypeCorrect:
            pngStr=@"对号";
            break;
        case DrivingAnswerTypeNotCorrect:
            pngStr=@"错号";
            break;
        default:
            break;
    }
    flagImageView.image=[UIImage imageNamed:pngStr];
    
    UIFont *font=[UIFont systemFontOfSize:12];
    CGFloat height = [self getSizeWithString:self.drivingAnswerModel.answerContent withFont:font withSize:CGSizeMake(270,300)].height;
    [flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(19, 19));
        make.centerY.equalTo(@[self.contentView]);
    }];
    [answerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(flagImageView.mas_right).with.offset(10);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(270, height));
    }];
    
}

- (CGSize)getSizeWithString:(NSString *)str withFont:(UIFont *)font withSize:(CGSize)size{
    CGSize newsize ;
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    newsize =[str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    return newsize;
}

//- (void)drawRect:(CGRect)rect
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
//    CGContextFillRect(context, rect);
//    
//    //上分割线，
//    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
//    CGContextStrokeRect(context, CGRectMake(5, 0, rect.size.width - 10, 1));
//    
//    //下分割线
//    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
//    CGContextStrokeRect(context, CGRectMake(5, rect.size.height-1, rect.size.width - 10, 1));
//}


@end

//
//  ChaWeizhangCell.m
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/14.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "ChaWeizhangCell.h"

@implementation ChaWeizhangCell

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
    cityLabel = [MyControl createLabelWithtext:nil font:19 textcolor:RGBCOLOR(0, 0, 0) backgroundColor:nil];
    [self.contentView addSubview:cityLabel];
    _carNumField = [[UITextField alloc] init];
    _carNumField.delegate =self;
    _carNumField.returnKeyType =UIReturnKeyDone;
    _carNumField.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_carNumField];
    [cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(15);
        make.left.equalTo(self.contentView).with.offset(15);
        make.bottom.equalTo(self.contentView).with.offset(-15);
    }];
    [_carNumField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(15);
        make.left.greaterThanOrEqualTo(self.contentView.mas_centerX).with.offset(20);
        make.right.greaterThanOrEqualTo(self.contentView.mas_right).with.offset(-10);
        make.bottom.equalTo(self.contentView).with.offset(-15);
    }];
}
-(void)layoutSubviews{
    if (self.chaWeizhanModel.isenabled) {
        if ([self.chaWeizhanModel.engine isEqualToString:@"1"]) {
            cityLabel.text = @"发动机号";
            if ([self.chaWeizhanModel.engineno isEqualToString:@"0"]) {
                _carNumField.placeholder = @"请输完整发动机号";
            }else{
                _carNumField.placeholder =[NSString stringWithFormat:@"请输发动机号后%@位",self.chaWeizhanModel.engineno];
            }
        }
        if([self.chaWeizhanModel.classa isEqualToString:@"1"]) {
            cityLabel.text = @"机架号";
            if ([self.chaWeizhanModel.classno isEqualToString:@"0"]) {
                _carNumField.placeholder = @"请输入完整机架号";
            }else{
                _carNumField.placeholder =[NSString stringWithFormat:@"请输机架号后%@位",self.chaWeizhanModel.classno];
            }
        }

    }
    
    
}
#pragma mark - textfield
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self tapClick];
    return YES;
}
-(void)tapClick{
    [_carNumField resignFirstResponder];
}
@end

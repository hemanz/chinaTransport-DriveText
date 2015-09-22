//
//  ChaWeizhangCell.h
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/14.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChaWeizhanModel.h"

@interface ChaWeizhangCell : UITableViewCell<UITextFieldDelegate>
{
    UILabel *cityLabel;
//    UILabel *cityNameLabel;
////    UILabel *carNumLabel;
//    UILabel *carEngineNumLabel;
//    UILabel *carJijiaNumLabel;
////    UITextField *carNumField;
//    UITextField *carEngineField;
//    UITextField *carJijiaNumField;
//    UIButton *cityButton;
}

@property (nonatomic,retain)ChaWeizhanModel *chaWeizhanModel;
@property(nonatomic,retain)UILabel *carNumLabel;
@property(nonatomic,retain)UITextField *carNumField;
@end

//
//  LeftScrollController.h
//  ChinaTransport
//
//  Created by 王攀登 on 15/9/1.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoData.h"

@interface LeftScrollController : UIViewController

@property (nonatomic,strong)UserInfoData *userInfoData;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

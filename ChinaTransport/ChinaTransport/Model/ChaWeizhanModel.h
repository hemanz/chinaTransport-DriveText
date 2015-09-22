//
//  ChaWeizhanModel.h
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/18.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChaWeizhanModel : NSObject

@property (nonatomic,copy)NSString *isenabled;  //0为不可查  其他可查
@property (nonatomic,copy)NSString *abbr ;  //省标
@property (nonatomic,copy)NSString *engine;  //是否需要发动
@property (nonatomic,copy)NSString *engineno;  //需要几位发动机号
@property (nonatomic,copy)NSString *classa ;  //是否需要车架号（即识别码）
@property (nonatomic,copy)NSString *classno;  //需要几位车架号

@end

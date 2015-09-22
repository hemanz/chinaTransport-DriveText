//
//  THeadLineNewsModel.m
//  ChinaTransport
//
//  Created by 张鹤楠 on 15/9/10.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "THeadLineNewsModel.h"

@implementation THeadLineNewsModel

+ (instancetype)newsModelWithDict:(NSDictionary *)dict
{
    THeadLineNewsModel *model = [[self alloc]init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}

@end

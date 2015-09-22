//
//  THeadLineNewsModel.h
//  ChinaTransport
//
//  Created by 张鹤楠 on 15/9/10.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THeadLineNewsModel : NSObject

@property (nonatomic,copy) NSString *publishTime;

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *source;
@property (nonatomic,copy) NSString *htmlurl;
@property (nonatomic,copy) NSString *flag;//轮播图标记
@property (nonatomic,copy) NSArray *litpic;//新闻图片数组

@property (nonatomic,copy) NSString *newsType;



//pkid
//"title": "牡丹江公交：智取新能源 宇通靠得住",
//"source": "中国交通新闻网",
//"author": "",
//"htmlurl": "http://192.168.3.3/mzpt/mobile_do.php?dopost=view&aid=5454",
//"flag": "0501",
//"litpic"

+ (instancetype)newsModelWithDict:(NSDictionary *)dict;

@end

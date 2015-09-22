//
//  Url.h
//  ChinaTransport
//
//  Created by 王攀登 on 15/8/31.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Url : NSObject
/**
 *  拼接图片的URl
 *
 *  @return nsstring
 */
+(NSString *)GetImageWithUrl:(NSString *)urlString;
/**
 *  路况URL
 *
 *  @param cityid 城市id
 *  @param type   区别是实时路况还是高速
 *
 *  @return NSString
 */
+(NSString *)RoadCondition:(NSString *)cityid andType:(NSString *)type;
/**
 *  主页的轮播图
 */
+(NSString *)mainTimeImageView;
/**
 *  快递Url
 */
+(NSString *)queryKuaiDicom:(NSString *)com num:(NSString *)num;
/**
 *  火车票站站
 */
+(NSString *)queryTrainByFromTo:(NSString *)fromStation toStation:(NSString *)toStation date:(NSString *)date;
/**
 *  火车票车次
 */
+(NSString *)queryTrainByCheci:(NSString *)checi date:(NSString *)date;
/**
 *  火车票票价查询
 */
//+(NSString *)queryTrainPrice:(NSString *)
/**
 *  违章开始的是否需要发动机号 机架号等查询
 */
+(NSString *)queryCityWZInfoCity:(NSString *)cityName;
/**
 *  违章内容的查询接口
 */
+(NSString *)queryWeizhangNewWithCity:(NSString *)cityName carNo:(NSString *)carNO engineno:(NSString *)engineno classno:(NSString *)classno rand:(NSString *)ranCode;
/**
 *  验证码接口
 */
+(NSString *)getRandCode;
/**
 *  交通头条接口
 */
+ (NSString *)GetTransportHeadLineURLWithPage:(NSInteger)page PageSize:(NSString *)Size ContentType:(NSString *)Type;
/**
 *  feedback暂用接口
 */
+(NSString *)FeedBackUrl:(NSString *)mphone withFeedBack:(NSString *)feedBack;
@end

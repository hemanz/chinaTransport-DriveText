//
//  Url.m
//  ChinaTransport
//
//  Created by 王攀登 on 15/8/31.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "Url.h"

@implementation Url


/**
 *  获取url地址
 *
 *  @param methodName 方法名
 *  @param param参数      get的所有参数,如果param为空，则传@""
 *
 *  @return url地址
 */
+(NSString *)GetURL:(NSString *)methodName withParam:(NSString *)param{
    NSString *str =[NSString stringWithFormat:@"%@/%@/ios/%@/%.1f%@",kHostAddr,methodName,kCURRENT_UUID,kCURRENT_APP_VERSION,param];
    return str;
}
+(NSString *)GetImageWithUrl:(NSString *)urlString{
    NSString *url =[kHostAddr stringByAppendingString:@"/getImage?uri="];
    return [url stringByAppendingString:[NSString stringWithFormat:@"%@",urlString]];
}

+(NSString *)mainTimeImageView{
   return  [self GetURL:@"queryMainActivity" withParam:@""];
}
+(NSString *)RoadCondition:(NSString *)cityid andType:(NSString *)type{
    NSString *UrlString = [NSString stringWithFormat:@"?cityid=%@&type=%@",cityid,type];
    return [self GetURL:@"queryRoadCondition" withParam:UrlString];
}
+(NSString *)queryKuaiDicom:(NSString *)com num:(NSString *)num{
    NSString *UrlString =[NSString stringWithFormat:@"?com=%@&num=%@",com,num];
    return [self GetURL:@"queryKuaiDi" withParam:UrlString];
}
+(NSString *)queryTrainByFromTo:(NSString *)fromStation toStation:(NSString *)toStation date:(NSString *)date{
     NSString *UrlString =[NSString stringWithFormat:@"?from_sta_code=%@&to_sta_code=%@&train_date=%@",fromStation,toStation,date];
    return [self GetURL:@"queryTrainByFromTo" withParam:UrlString];
}
+(NSString *)queryTrainByCheci:(NSString *)checi date:(NSString *)date{
     NSString *UrlString =[NSString stringWithFormat:@"?checi=%@&train_date=%@",checi,date];
     return  [self GetURL:@"queryTrainByCheci" withParam:UrlString];
}
+(NSString *)queryCityWZInfoCity:(NSString *)cityName{
    NSString *UrlString =[NSString stringWithFormat:@"?city=%@",cityName];
     return  [self GetURL:@"queryCityWZInfo" withParam:UrlString];
}
+(NSString *)queryWeizhangNewWithCity:(NSString *)cityName carNo:(NSString *)carNO engineno:(NSString *)engineno classno:(NSString *)classno rand:(NSString *)ranCode{
    NSString *UrlString = [NSString stringWithFormat:@"?city=%@&carNo=%@&engineno=%@&classno=%@&rand=%@",cityName,carNO,engineno,classno,ranCode];
    return [self GetURL:@"queryWeizhangNew" withParam:UrlString];
}
+(NSString *)getRandCode{
    return [NSString stringWithFormat:@"%@/%@",kHostAddr,@"getRandCode"];
}


+ (NSString *)GetTransportHeadLineURLWithPage:(NSInteger)page PageSize:(NSString *)Size ContentType:(NSString *)Type{
    NSString *str = [NSString stringWithFormat:@"?pagesize=%@&newstype=%@&page=%ld",Size,Type,page];
    return [self GetURL:@"queryTops" withParam:str];
}
+(NSString *)FeedBackUrl:(NSString *)mphone withFeedBack:(NSString *)feedBack{
    NSString *str = [NSString stringWithFormat:@"?contactinfo=%@&advice=%@",mphone,feedBack];
    return [self GetRadioHostURL:@"feedback" withParam:str];
    
}

+(NSString *)GetRadioHostURL:(NSString *)methodName withParam:(NSString *)param{
    NSString *str =[NSString stringWithFormat:@"%@/%@/ios/%@/%.1f%@",kHostAddr,methodName,kCURRENT_UUID,kCURRENT_APP_VERSION,param];
    return str;
}
@end

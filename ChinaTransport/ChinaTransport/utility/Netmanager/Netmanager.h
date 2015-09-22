//
//  Netmanager.h
//  ChinaTransport
//
//  Created by 王攀登 on 15/8/31.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import <Foundation/Foundation.h>
/*   封装网络请求的Block
 */
typedef void (^DownloadFinishedBlock)(id responseobj);
typedef void (^DownloadFailedBlock) (NSString *errorMsg);

@interface Netmanager : NSObject

//post请求
+(void)PostRequestWithUrlString:(NSString *)urlString parms:(NSDictionary *)dic finished:(DownloadFinishedBlock)finishedBlock failed:(DownloadFailedBlock)failedBlock;
//get请求
+(void)GetRequestWithUrlString:(NSString *)urlString  finished:(DownloadFinishedBlock)finishedBlock failed:(DownloadFailedBlock)failedBlock;
@end

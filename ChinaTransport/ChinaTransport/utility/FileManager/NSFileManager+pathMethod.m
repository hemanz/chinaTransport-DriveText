//
//  NSFileManager+pathMethod.m
//  RadioHost
//
//  Created by 王攀登 on 15/4/16.
//  Copyright (c) 2015年 国广高通（北京）传媒科技有限公司. All rights reserved.
//

#import "NSFileManager+pathMethod.h"

@implementation NSFileManager (pathMethod)

-(BOOL)isTimeOutWithPath:(NSString *)path time:(NSTimeInterval)time{
      //获取指定路径下文件的属性列表
     NSDictionary *infoDic = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    //拿到文件的修改时间
    NSDate *fileDate = [infoDic objectForKey:NSFileCreationDate];
    //系统当前时间
    NSDate *date = [NSDate date];
    // NSLog(@"date:%@fileDate%@",date,fileDate);
    //date与fileDate的时间差
    
    NSTimeInterval currentTime =[date timeIntervalSinceDate:fileDate];
    if (currentTime >time) {
        //超时
//        [self clearCache];
        return YES;
    }else{
        //没有超时
        return  NO;
    }

}
//-(void)clearCache
//{
//    NSString*path =[[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingFormat:@"/Caches"];
//    NSString*newpath =[NSString stringWithFormat:@"%@",[path stringByAppendingPathComponent:@"HttpCathes"]];
//    //获取这个文件夹下的所有的文件名
//    NSFileManager*manager=[NSFileManager defaultManager];
//    NSArray*array=[manager contentsOfDirectoryAtPath:newpath error:nil];
//    // 枚举遍历 使用block开辟一条线程，在线程中遍历  obj我们遍历的对象 idx第几位 stop是否停止
//    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        NSString*newPath2=[NSString stringWithFormat:@"%@/%@",newpath,obj];
//        [manager removeItemAtPath:newPath2 error:nil];
//    }];
//    
//}

@end

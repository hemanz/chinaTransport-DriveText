//
//  NSFileManager+pathMethod.h
//  RadioHost
//
//  Created by 王攀登 on 15/4/16.
//  Copyright (c) 2015年 国广高通（北京）传媒科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (pathMethod)

//      判断是否超时 
-(BOOL)isTimeOutWithPath:(NSString *)path time:(NSTimeInterval )time;

@end

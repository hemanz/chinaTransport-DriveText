//
//  BaseDataManager.h
//  ChinaTransport
//
//  Created by 王攀登 on 15/9/2.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoData.h"
@interface BaseDataManager : NSObject

+(instancetype)sharedBaseDataManager;

/**
 *  获取MineViewController的基础数据
 *
 *  @return NSMutableArray
 */
- (NSMutableArray *)getMineBaseData;
/**
 *  注册登录
 *
 *  @return NSMutableArray
 */
-(NSMutableArray *)getLoginBaseData;
/**
 *  手机注册
 */
-(NSMutableArray *)getFindPwdBaseData;
/**
 *  实时路况的选择省份和城市
 */
-(NSMutableArray *)getProvinceData;
-(NSMutableArray *)getProvinceAndCiteDatawithValue:(NSString *)value;
   //违章数据库的城市
-(NSMutableArray *)getWeizhangProvinceData;
-(NSMutableArray *)getWeizhangCityProvinceAndCiteDatawithValue:(NSString *)value;
@end

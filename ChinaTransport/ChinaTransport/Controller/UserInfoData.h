//
//  UserInfoData.h
//  ChinaTransport
//
//  Created by 王攀登 on 15/9/2.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  用户性别
 */
typedef NS_ENUM(NSInteger, UserInfoSexType) {
    UserInfoSexMale =1,
    UserInfoSexFamale =0,
    UserInfoSexNone =2,
};
/**
 *  注册类别
 */
typedef NS_ENUM(NSInteger, RegisterType){
//    新注册
    RegisterTypeAdd = 0,
//    微信登陆
    RegisterTypeBind = 1,
};
/**
 *  用户信息修改
 */
typedef NS_ENUM(NSInteger, InfoChangeType) {
//    名字修改
    InfoChangeTypeNickname = 0,
//    性别修改
    
    InfoChangeTypeSex = 1,

};
@interface UserInfoData : NSObject

@property (nonatomic,copy)NSString *nickname;
@property (nonatomic,copy)NSString *avatar;
@property(nonatomic,assign)BOOL isLogin;
@property(nonatomic,copy)NSString *wxid;
@property(nonatomic,copy)NSString *sex;
@property(nonatomic,copy)NSString *mphone;
@property(nonatomic,copy)NSString *groupid;
@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString *code;
/**
 *  UserinfoData类转换成Dictionary
 *   @return  Dictionary
 */
-(NSMutableDictionary *) toDictionary;
/**
 *  UserInfoData,使用Dictionary进行初始化
 *   @return  UserInfoData
 */
-(id)initWithDictionary:(NSDictionary *)dict;
/**
 *  将UserInfoData存入NSUserDefaults
 *  islogin 是否登录
 */
-(void)setUserDefault:(NSDictionary *)dic withLogin:(BOOL)isLogin;
/**
 *  从NSUserDefaults获取UserInfodata
 *    @return UserInfoData
 */
-(UserInfoData *) getUserDefault;
/**
 *  判断字符串是否为空
 */
+(BOOL)isBlankString:(NSString *)string;
/**
 *  32位MD5加密
 * @param srcString 带加密的字符串
 * @return MD5 加密后的字符串
 */
+(NSString *)getMD5_32Bit_String:(NSString *)srcString;
@end

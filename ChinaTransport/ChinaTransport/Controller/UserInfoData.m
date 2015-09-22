//
//  UserInfoData.m
//  ChinaTransport
//
//  Created by 王攀登 on 15/9/2.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "UserInfoData.h"
#import <CommonCrypto/CommonCrypto.h>
@implementation UserInfoData

#define Knickname        @"nickname"
#define Kavatar          @"avatar"
#define Kuid             @"uid"
#define Kmphone          @"mphone"
#define Kgroupid         @"groupid"
#define Ksex             @"sex"
#define Kwxid            @"wxid"
#define KisLogin         @"isLogin"

-(NSMutableDictionary *) toDictionary
{
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] init];
    if (self.nickname)[dataDic setObject:self.nickname forKey:Knickname];
    if (self.avatar)[dataDic setObject:self.avatar forKey:Kavatar];
    if (self.uid)[dataDic setObject:self.uid forKey:Kuid];
    if (self.mphone)[dataDic setObject:self.mphone forKey:Kmphone];
    if (self.groupid)[dataDic setObject:self.groupid forKey:Kgroupid];
    if (self.sex)[dataDic setObject:self.sex forKey:Ksex];
    if (self.wxid)[dataDic setObject:self.wxid forKey:Kwxid];
    if (self.isLogin)[dataDic setObject:[NSNumber numberWithBool:self.isLogin   ] forKey:KisLogin];
    return dataDic;
}
-(id)initWithDictionary:(NSDictionary *)dict
{
    if ((self = [super init])) {
        self.nickname = [dict objectForKey:Knickname];
        self.avatar = [dict objectForKey:Kavatar];
        self.uid = [dict objectForKey:Kuid];
        self.mphone = [dict objectForKey: Kmphone];
        self.groupid = [dict objectForKey:Kgroupid];
        self.sex = [dict objectForKey:Ksex];
        self.wxid = [dict objectForKey:Kwxid];
        self.isLogin=[[dict objectForKey:KisLogin] boolValue];
    }
    return self;
}
-(void) setUserDefault:(NSDictionary *)dic withLogin:(BOOL)isLogin{
    self.nickname = dic[Knickname];
    self.avatar = dic[Kavatar];
    self.uid = dic[Kuid];
    self.mphone = dic[Kmphone];
    self.groupid = dic[Kgroupid];
    self.sex = dic[Ksex];
    self.wxid = dic[Kwxid];
    self.isLogin = isLogin;
    [[NSUserDefaults standardUserDefaults] setObject:[self toDictionary] forKey:@"userInfo"];
    
}
-(UserInfoData *) getUserDefault{
    NSDictionary *userDic= [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    return [self initWithDictionary:userDic];
}
+(BOOL) isBlankString:(NSString *)string
{
    if (string == nil || string == NULL || [string isEqualToString:@"(null)"])
    {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0)
    {
        return YES;
    }
    return NO;
}
+(NSString *)getMD5_32Bit_String:(NSString *)srcString
{
    const char *cStr = [srcString UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr,strlen(cStr),digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i=0; i<CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x",digest[i]];
        
    return result;
    
}
@end

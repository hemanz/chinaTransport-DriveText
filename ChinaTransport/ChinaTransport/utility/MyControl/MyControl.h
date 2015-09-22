//
//  MyControl.h
//  ChinaTransport
//
//  Created by 王攀登 on 15/9/1.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyControl : NSObject
/**
 *  View
 */
+(UIView *)createUIViewWithFrame:(CGRect)frame color:(UIColor *)color;
/**
 *  Label
 */
+(UILabel *)createLabelWithFrame:(CGRect)frame text:(NSString *)text font:(float)font textcolor:(UIColor *)color textAlignment:(NSInteger)Alignment backgroundColor:(UIColor *)backgroundColor;
//label
+(UILabel *)createLabelWithtext:(NSString *)text font:(float)font textcolor:(UIColor *)color  backgroundColor:(UIColor *)backgroundColor;
/**
 *  Button
 */
+(UIButton*)createButtonWithType:(UIButtonType)ButtonType Frame:(CGRect)frame title:(NSString*)title titleColor:(UIColor *)color imageName:(NSString*)imageName bgImageName:(NSString*)bgImageName target:(id)target method:(SEL)select;
+(UIButton*)createButtontitle:(NSString*)title titleColor:(UIColor *)color target:(id)target method:(SEL)select;
/**
 *  UIImageView
 */
+(UIImageView*)createImageViewFrame:(CGRect)frame imageName:(NSString*)imageName;
/**
 *  UITextfield
 */
+(UITextField*)createTextFieldFrame:(CGRect)frame placeholder:(NSString*)placeholder bgImageName:(NSString*)imageName leftView:(UIView*)leftView rightView:(UIView*)rightView isPassWord:(BOOL)isPassWord;
@end

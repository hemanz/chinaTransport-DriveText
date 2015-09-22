//
//  MyControl.m
//  ChinaTransport
//
//  Created by 王攀登 on 15/9/1.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "MyControl.h"

@implementation MyControl

+(UIView *)createUIViewWithFrame:(CGRect)frame color:(UIColor *)color
{
    UIView *view =[[UIView alloc] initWithFrame:frame];
    if (color!=nil) {
        view.backgroundColor =color;
    }else{
        view.backgroundColor = [UIColor clearColor];
    }
    return view;
}
+(UILabel *)createLabelWithFrame:(CGRect)frame text:(NSString *)text font:(float)font textcolor:(UIColor *)color textAlignment:(NSInteger)Alignment backgroundColor:(UIColor *)backgroundColor
{
    UILabel*label=[[UILabel alloc]initWithFrame:frame];
    label.font=[UIFont systemFontOfSize:font];
    label.lineBreakMode=NSLineBreakByCharWrapping;
    label.numberOfLines=0;
    label.text=text;
    label.textColor =color;
    switch (Alignment) {
        case 0:
            label.textAlignment=NSTextAlignmentLeft;
            break;
        case 1:
            label.textAlignment=NSTextAlignmentCenter;
            break;
        case 2:
            label.textAlignment=NSTextAlignmentRight;
            break;
        default:
            break;
    }
    if (backgroundColor) {
        label.backgroundColor =backgroundColor;
    }
    else{
        label.backgroundColor =[UIColor clearColor];
    }
    
    return label;
}
+(UILabel *)createLabelWithtext:(NSString *)text font:(float)font textcolor:(UIColor *)color  backgroundColor:(UIColor *)backgroundColor{
    UILabel*label=[[UILabel alloc]init];
    label.font=[UIFont systemFontOfSize:font];
    label.lineBreakMode=NSLineBreakByCharWrapping;
    label.numberOfLines=0;
    label.text=text;
    label.textColor =color;
       if (backgroundColor) {
        label.backgroundColor =backgroundColor;
    }
    else{
        label.backgroundColor =[UIColor clearColor];
    }
    
    return label;

}

+(UIButton*)createButtonWithType:(UIButtonType)ButtonType Frame:(CGRect)frame title:(NSString*)title titleColor:(UIColor *)color imageName:(NSString*)imageName bgImageName:(NSString*)bgImageName target:(id)target method:(SEL)select
{
    UIButton*button=[UIButton buttonWithType:ButtonType];
    
    button.frame=frame;
    [button setTitleColor:color forState:UIControlStateNormal];
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (imageName) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (bgImageName) {
        [button setBackgroundImage:[UIImage imageNamed:bgImageName] forState:UIControlStateNormal];
    }
    [button addTarget:target action:select forControlEvents:UIControlEventTouchUpInside];
    return button;
}
+(UIButton*)createButtontitle:(NSString*)title titleColor:(UIColor *)color target:(id)target method:(SEL)select
{
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:color forState:UIControlStateNormal];
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    button.backgroundColor = [UIColor whiteColor];
    [button addTarget:target action:select forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+(UIImageView*)createImageViewFrame:(CGRect)frame imageName:(NSString*)imageName
{
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:frame];
    if (imageName) {
        imageView.image=[UIImage imageNamed:imageName];
    }
    imageView.userInteractionEnabled=YES;
    return imageView;
}
+(UITextField*)createTextFieldFrame:(CGRect)frame placeholder:(NSString*)placeholder bgImageName:(NSString*)imageName leftView:(UIView*)leftView rightView:(UIView*)rightView isPassWord:(BOOL)isPassWord
{
    UITextField*textField=[[UITextField alloc]initWithFrame:frame];
    if (placeholder) {
        textField.placeholder=placeholder;
        
    }
    if (imageName) {
        textField.background=[UIImage imageNamed:imageName];
    }
    if (leftView) {
        textField.leftView=leftView;
        textField.leftViewMode=UITextFieldViewModeAlways;
    }
    if (rightView) {
        textField.rightView=rightView;
        textField.rightViewMode=UITextFieldViewModeAlways;
    }
    if (isPassWord) {
        textField.secureTextEntry=YES;
    }
    return textField;
}

@end

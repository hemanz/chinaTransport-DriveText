//
//  UIToast.m
//  测试
//
//  Created by 王攀登 on 15/8/17.
//  Copyright (c) 2015年 Climb. All rights reserved.
//

/******************************************************************************
 文件名称 : UIToast.m
 版权声明 : Copyright(C) 2008-2011 ….. All Rights Reserved.
 文件描述 : toast
 修改记录 : 严道秋2012-01－10 1.00初始版本 原创声明！转载留名！
 修改内容 :
 Review记录: 姓名 时间
 ******************************************************************************/

#import "UIToast.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIToast

-(id)init{
    if (self = [super init]) {
        //无须参数
    }
    return self;
}

//开始动画
-(void)beginAnimationWithDuration:(CGFloat)duTime{
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:duTime];
}

//结束动画
- (void)commitModalAnimationsWithSelector:(SEL)seletor
{
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:seletor];
    [UIView commitAnimations];
}

//显示动画
-(void)animationStep{
    switch (animation++) {
        case 0:
        {
            //增加透明封面，截断触摸时间，remove时释放内存
            UIView *cover = [[UIView alloc] initWithFrame:self.bounds];
            [self addSubview:cover];
            [self beginAnimationWithDuration:0.2f];
            self.transform = CGAffineTransformMakeScale(1.15f, 1.15f);
            [self commitModalAnimationsWithSelector:@selector(animationStep)];
        }
            break;
        case 1:
        {
            [self beginAnimationWithDuration:0.1f];
            self.transform = CGAffineTransformMakeScale(0.999f, 0.999f);
            [self commitModalAnimationsWithSelector:@selector(animationStep)];
            
        }
            break;
        case 2:
        {
            CGFloat duTime = 1.0f;
            if (m_length == TOAST_LENGTH_LONG) {
                duTime = 3.0f;
            }
            [self beginAnimationWithDuration:duTime];
            self.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
            [self commitModalAnimationsWithSelector:@selector(animationStep)];
            
        }
            break;
        case 3:
        {
            [self beginAnimationWithDuration:1.0f];
            self.transform = CGAffineTransformMakeScale(1.1f, 0.01f);
            self.alpha = 0.0f;
            [self commitModalAnimationsWithSelector:@selector(animationStep)];
            
        }
            break;
        case 4:
        {
            NSInteger vLength = [self.subviews count];
            while (vLength-->0) {
                UIView *v = [self.subviews objectAtIndex:vLength];
                [v removeFromSuperview];
            }
            [self removeFromSuperview];
        }
            break;
        default:
            break;
    }
}

//初始化toast文字
-(void)initShowingText:(NSString*)content withFont:(UIFont*)font{
    UITextView *textview = [[UITextView alloc] initWithFrame:self.bounds];
    textview.backgroundColor = [UIColor colorWithRed:40.0f/255.0 green:40.0f/255.0 blue:40.0/255.0 alpha:0.85];
    textview.textColor = [UIColor whiteColor];
    textview.alpha = 1.0f;
    textview.font = font;
    [textview setText:content];
    textview.textAlignment = NSTextAlignmentCenter;
    textview.editable = NO;
    textview.layer.cornerRadius = 6;
    textview.layer.masksToBounds = YES;
    //取消该效果 20110112 elan
    //	[textview.layer setBorderWidth:3.0f];
    //	[textview.layer setBorderColor:[UIColor whiteColor].CGColor];
    textview.layer.shadowOffset = CGSizeMake(5, 3);
    textview.layer.shadowOpacity = 0.4;
    textview.layer.shadowRadius = 4;
    textview.layer.shadowColor = [UIColor blackColor].CGColor;
    [self addSubview:textview];
    animationView = textview;
}

-(void)show:(NSString*)content Gravity:(TOAST_GRAVITY)gravity Length:(TOAST_LENGTH)length{
    //初始化参数
    m_length = length;
    m_gravity = gravity;
    animation = 0;
    //获取窗口句柄
    UIWindow *rootView = [[UIApplication sharedApplication] keyWindow];
    CGRect rect = rootView.screen.bounds;
    UIFont *font = [UIFont fontWithName:@"Arial" size:15.0f];
//    CGSize labFrame = [content sizeWithFont:font  constrainedToSize:CGSizeMake(260, 300) lineBreakMode:NSLineBreakByWordWrapping];
     NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGSize labFrame =[content boundingRectWithSize:CGSizeMake(260,300) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading  attributes:dic context:nil].size;
    CGSize size = TOAST_BOUNDS;
    labFrame.width+=size.width;
    labFrame.height+=size.height;
    CGFloat dip;
    if (gravity == TOAST_GRAVITY_DOWN) {
        dip=0.75;
    }else if (gravity == TOAST_GRAVITY_CENTURE) {
        dip=0.5;
    }else {
        dip=0.25;
    }
    //设置view边框
    self.frame = CGRectMake((rect.size.width-labFrame.width)/2, rect.size.height*dip-labFrame.height/2, labFrame.width, labFrame.height);
    self.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    [rootView addSubview:self];
    //初始化显示的view
    [self initShowingText:content withFont:font];
    //开始动画展示
    [self animationStep];
}

//快速显示toast
-(void)show:(NSString*)content{
    [self show:content Gravity:TOAST_GRAVITY_DOWN Length:TOAST_LENGTH_SHORT];
}

//自定义toast展示view
-(void)showView:(UIView*)smallView WithGravity:(CGFloat)gravity Length:(TOAST_LENGTH)length{
    //初始化参数
    CGFloat dip = gravity;
    m_gravity = gravity;
    m_length = length;
    //获取窗口句柄
    UIWindow *rootView = [[UIApplication sharedApplication] keyWindow];
    CGRect rect = rootView.screen.bounds;
    CGRect oldFrame = smallView.frame;
    smallView.frame = CGRectMake(0, 0, oldFrame.size.width, oldFrame.size.height);
    //设置view边框
    self.frame = CGRectMake((rect.size.width-oldFrame.size.width)/2, rect.size.height*dip-oldFrame.size.height/2, oldFrame.size.width, oldFrame.size.height);
    self.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    [rootView addSubview:self];
    animationView = smallView;
    [self addSubview:animationView];
    //开始动画展示
    [self animationStep];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code.
 }
 */



@end

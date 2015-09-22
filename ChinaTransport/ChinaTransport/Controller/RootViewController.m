//
//  RootViewController.m
//  ChinaTransport
//
//  Created by 王攀登 on 15/9/1.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
//    创建Nav样式
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bgColor.png"] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor purpleColor]];
//    Controller的基调
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgColor"]];
    [self addimage:[UIImage imageNamed:@"back-icon"] title:nil selector:@selector(backClick) location:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
-(void)backClick{
    [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}
//      导航栏的title
-(void)addTiTle:(NSString *)title
{
    
    UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    label.text = title;
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = RGBCOLOR(51, 51, 51);
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    
}
//     导航栏的item
-(void)addimage:(UIImage *)image title:(NSString *)title selector:(SEL)selector location:(BOOL)isLeft
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn setImage:image forState:UIControlStateNormal];
    if (image) {
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    }
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item =[[UIBarButtonItem alloc] initWithCustomView:btn];
    if (isLeft == YES) {
        self.navigationItem.leftBarButtonItem = item;
    }else{
        self.navigationItem.rightBarButtonItem = item;
    }
    
}
//     警示框
-(void)alertView:(NSString *)message cancle:(NSString *)cancleMessage
{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
    
}

//     判断字符串是否为空  若为空就为0 加给数组  避免出现越界
-(NSObject *)judgeArrayEmpty:(NSString *)str
{
    if (str == nil || str == NULL||[str isEqualToString:@"(null)"])
    {
        return @"0";
    }
    if ([str isKindOfClass:[NSNull class]])
    {
        return @"0";
    }
    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
    {
        return @"0";
    }
    else{
        return str;
    }
}
//      判断字典里key对应的是否存在，不存在返回“”    避免出现越界
-(NSString *)judgeDicEmpty:(NSDictionary *)dic str:(NSString *)str{
    
    if (dic[str]) {
        return  dic[str];
    }else{
        return @"";
    }
}
- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  AppDelegate.m
//  ChinaTransport
//
//  Created by 王攀登 on 15/8/31.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeController.h"
#import "PPRevealSideViewController.h"
#import "LeftScrollController.h"
#import "UserInfoData.h"
#import "AFNetworkActivityIndicatorManager.h"

#define kNavigatPicWidth 100
#define kNavigatPicHeigh 35

@interface AppDelegate ()<UIScrollViewDelegate>
{
    BOOL isOut;
    BOOL isHasFile;
    PPRevealSideViewController *ppRevealSideVC;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [UIViewController new];
    [self initializeDb];
//    isOut =NO;
//    isHasFile =[[NSUserDefaults standardUserDefaults] boolForKey:@"key_login"];
//    if (isHasFile) {
        [self goHomeController];
        
//    }else{
//        [self pregoHomeController];
//    }
    
//        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
   
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (BOOL) initializeDb {
    //使用sqlite数据库，首先将supporting files里的sqlite放入bundle里
    //数据库存放位置为 finder->资源库->application support->iphone simulator里
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentFolderPath = [searchPaths objectAtIndex: 0];
    NSString *dbFilePath;
    dbFilePath = [documentFolderPath stringByAppendingPathComponent:@"chinatransport.db"];
    //如果document里没有该数据库，则需要进行初始化
    if (! [[NSFileManager defaultManager] fileExistsAtPath: dbFilePath]) {
        //获取bundle包里数据库
        NSString *backupDbPath = [[NSBundle mainBundle] pathForResource:@"chinatransport" ofType:@"db"];
        if (backupDbPath == nil) {
            return NO;
        } else {
            //开始复制
            BOOL copiedBackupDb = [[NSFileManager defaultManager] copyItemAtPath:backupDbPath toPath:dbFilePath error:nil];
            if (!copiedBackupDb) {
                return NO;
            }
        }
    }
    return YES;
}

//   进主页
-(void)goHomeController{
//    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"key_login"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    LeftScrollController *leftScrollVC =[[LeftScrollController alloc] init];
    HomeController *homeController =[[HomeController alloc] init];
    UINavigationController *nav =[[UINavigationController alloc] initWithRootViewController:homeController];
    ppRevealSideVC = [[PPRevealSideViewController alloc] initWithRootViewController:nav];
//    [ppRevealSideVC setPanInteractionsWhenClosed:PPRevealSideInteractionNavigationBar|PPRevealSideInteractionContentView];
    [ppRevealSideVC preloadViewController:leftScrollVC forSide:PPRevealSideDirectionLeft];
    self.window.rootViewController = ppRevealSideVC;
}
//   第一次 有导航图
//-(void)pregoHomeController{
//    NSArray *navigationPicArray =@[@"启动页640x960"];
////          滑动的scrollView
//    UIScrollView *navigationScrolView =[[UIScrollView alloc] initWithFrame:self.window.bounds];
//    navigationScrolView.contentSize =CGSizeMake(navigationPicArray.count*wid, 0);
//    navigationScrolView.pagingEnabled = YES;
//    navigationScrolView.tag = 201590116;
//    navigationScrolView.showsHorizontalScrollIndicator =NO;
//    navigationScrolView.delegate =self;
//    [self.window addSubview:navigationScrolView];
////         滑动的图片
//    for (NSInteger i; i<navigationPicArray.count; i++) {
//        UIImageView *navigatImgView =[MyControl createImageViewFrame:CGRectMake(wid*i, 0, wid, heigh) imageName:navigationPicArray[i]];
//        [navigationScrolView addSubview:navigatImgView];
//    }
////        可以直接点击进入的Button
//    UIButton *loginButton =[MyControl createButtonWithType:UIButtonTypeCustom Frame:CGRectMake((wid/2-kNavigatPicWidth/2), heigh-80, kNavigatPicWidth, 35) title:nil titleColor:nil imageName:nil bgImageName:@"立即体验" target:self method:@selector(loginBtnClick)] ;
//    [self.window addSubview:loginButton];
//    
//}
//-(void)loginBtnClick{
//    UIScrollView *scrView =(UIScrollView *)[self.window viewWithTag:201590116];
//    [scrView removeFromSuperview];
//    [self goHomeController];
//}
#pragma mark - scrollView
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if (scrollView.contentOffset.x>2*wid+30) {
//        isOut = YES;
//    }
//}
////停止滑动  调用方法
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    //判断isOut为真   就要进入主界面了
//    if (isOut) {
//        [UIView animateWithDuration:1.5 animations:^{   scrollView.alpha=0;   //让scrollView渐变消失
//        }completion:^(BOOL finished) {
//            [scrollView removeFromSuperview]; //将scrollView移除
//            [self goHomeController];  //进入主界面
//        }];
//    }
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

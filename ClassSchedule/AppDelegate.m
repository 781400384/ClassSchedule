//
//  AppDelegate.m
//  ClassSchedule
//
//  Created by 纪明 on 2019/12/2.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"
#import <UserNotifications/UserNotifications.h>
#import "CSBaseTabbarController.h"
#import "LoginViewController.h"
#import "LuanchViewController.h"
#import "SZLaunchAdPage.h"
#import "CSWebViewController.h"
@interface AppDelegate (){
    SZLaunchAdPage *_launchAd;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
     [[IQKeyboardManager sharedManager]setEnable:YES];
     [[IQKeyboardManager sharedManager]setEnableAutoToolbar:YES];
     [[IQKeyboardManager sharedManager]setShouldResignOnTouchOutside:YES];
     [self checkNotificationSwitchState];
     [self netWorkListener];
     [self registerWechat];
     [self loadDataImage];
    [UMConfigure initWithAppkey:@"5df20d063fc1959ca400002d" channel:@"App Store"];
           NSUserDefaults *useDef = [NSUserDefaults standardUserDefaults];
              if (![useDef boolForKey:@"notFirst"]) {
                  self.window.rootViewController = [[LuanchViewController alloc] init];
                   [self.window makeKeyAndVisible];
              }
              else{
                
                  [self loadUI];
              }
       

        if (@available(iOS 10.0,*)) {
               // iOS10 及以上
               UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
               [center requestAuthorizationWithOptions:UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
                   if (granted) {
                       // 注册成功
                   }else{
                       // 注册失败
                   }
               }];
           }else{
               // iOS8 及以上
               UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
               
               [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
               
           }
    return YES;
}
-(void)loadDataImage{
        [ClassHandle getImageWithId:@"1" success:^(id  _Nonnull obj) {
    
            NSDictionary  *  dic=(NSDictionary *)obj;
            
            if ([dic[@"code"] intValue]==1) {
                if ([dic[@"data"][@"url"] isEmpty]||[dic[@"data"][@"image"] isEmpty]) {
                    
                }else{
                     [self loadLaunchAdWithUrl:dic[@"data"][@"url"] img:dic[@"data"][@"image"]];
                }
               
            }
    
        } failed:^(id  _Nonnull obj) {
    
        }];
}

- (void)loadLaunchAdWithUrl:(NSString *)url img:(NSString *)img {
    _launchAd = [[SZLaunchAdPage alloc] init];
    _launchAd.ADduration = 5;
    _launchAd.timeoutDuration = 3;
    _launchAd.ADImageURL =img;
   
    _launchAd.skipButtonClickBlock = ^{

     
    };
    _launchAd.launchAdClosed = ^{

    };
    _launchAd.launchAdClickBlock = ^{
        CSWebViewController  *  vc=[[CSWebViewController alloc]init];
        vc.linkUrl=url;
        [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
    };
    _launchAd.launchAdLoadError = ^(NSError * _Nonnull error) {
 
    };
    [self.window addSubview:_launchAd.view];
    
}

-(void)loadUI{
    if ([UserInfoDefaults isLogin]) {
                           CSBaseTabbarController *  vc=[[CSBaseTabbarController alloc]init];
                            CSBaseNavigationViewController  *  nav=[[CSBaseNavigationViewController alloc]initWithRootViewController:vc];
                            self.window.rootViewController = nav;
                           
                           [self.window makeKeyAndVisible];
                     }else{
                    LoginViewController *  vc=[[LoginViewController alloc]init];
                            CSBaseNavigationViewController  *  nav=[[CSBaseNavigationViewController alloc]initWithRootViewController:vc];
                         self.window.rootViewController = nav;
                           [self.window makeKeyAndVisible];
                         
                     }
}
#pragma mark - UISceneSession lifecycle
#pragma mark -- 检测通知 开关状态
- (void)checkNotificationSwitchState{
    if (@available(iOS 10.0,*)) {
        UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            if (settings.notificationCenterSetting == UNNotificationSettingEnabled) {
                NSLog(@"通知权限开启");
            }else{
                NSLog(@"通知权限关闭");
            }
        }];
    }else{
        UIUserNotificationSettings * settings = [[UIApplication sharedApplication] currentUserNotificationSettings];
        
        if (settings.types == UIUserNotificationTypeNone) {
            NSLog(@"通知权限关闭");
        }else{
            NSLog(@"通知权限开启");
        }
        
    }
}


#pragma mark - UISceneSession lifecycle

#pragma mark - weChat

- (void)registerWechat {

    [WXApi registerApp:WX_APPID universalLink:@"https://kcb-api.qianr.com/ClassSchedule/"];
    
  
   
}

-(void)onReq:(BaseReq *)req{
    
}
-(void)onResp:(BaseResp *)resp{

    switch (resp.errCode) {
               case 0:
               {
                  
                   SendAuthResp *aresp = (SendAuthResp *)resp;
                   [[NSNotificationCenter defaultCenter] postNotificationName:CSWXLoginNotification object:self userInfo:@{@"code":aresp.code}];
                   
               }
                   break;
               case -4://用户拒绝授权
                   break;
               case -2://用户取消授权
                   break;
               default:
                   break;
           }
   
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRestoring>> * __nullable restorableObjects))restorationHandler {
return [WXApi handleOpenUniversalLink:userActivity delegate:self];
}
- (void)netWorkListener {
    
    
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                
                self.reachabilityStatus = AFNetworkReachabilityStatusUnknown;
                NSLog(@"未知网络");
                break;
                
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                
                self.reachabilityStatus = AFNetworkReachabilityStatusNotReachable;
                NSLog(@"没有网络(断网)");
                [self.window toast:@"当前无网络"];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                
                self.reachabilityStatus = AFNetworkReachabilityStatusReachableViaWWAN;
                NSLog(@"手机自带网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                
                self.reachabilityStatus = AFNetworkReachabilityStatusReachableViaWiFi;
                NSLog(@"WIFI");
                break;
        }
    }];
    
    // 3.开始监控
    [mgr startMonitoring];
}


//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//     // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//  
//}


@end

#import "SceneDelegate.h"
#import "CSBaseTabbarController.h"
#import "LoginViewController.h"
#import "LuanchViewController.h"
#import "SZLaunchAdPage.h"
#import "CSWebViewController.h"
@interface SceneDelegate (){
    SZLaunchAdPage *_launchAd;
}

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions  API_AVAILABLE(ios(13.0)){
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    if (@available(iOS 13.0, *)) {
           UIWindowScene *windowScene = (UIWindowScene *)scene;
           self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
           self.window.frame = windowScene.coordinateSpace.bounds;
       } else {
          
       }
     
       
       NSUserDefaults *useDef = [NSUserDefaults standardUserDefaults];
          if (![useDef boolForKey:@"notFirst"]) {
              self.window.rootViewController = [[LuanchViewController alloc] init];
          }
          else{
              if ([UserInfoDefaults isLogin]) {
                    CSBaseTabbarController *  vc=[[CSBaseTabbarController alloc]init];
                                  CSBaseNavigationViewController  *  nav=[[CSBaseNavigationViewController alloc]initWithRootViewController:vc];
                                  self.window.rootViewController = nav;
                    [self loadDatawithNav:nav];
                    [self.window makeKeyAndVisible];
              }else{
             LoginViewController *  vc=[[LoginViewController alloc]init];
                     CSBaseNavigationViewController  *  nav=[[CSBaseNavigationViewController alloc]initWithRootViewController:vc];
                  self.window.rootViewController = nav;
                    [self.window makeKeyAndVisible];
                  [self loadDatawithNav:nav];
              }
          }
   
}
-(void)loadDatawithNav:(UINavigationController *)nav{
        [ClassHandle getImageWithId:@"1" success:^(id  _Nonnull obj) {
    
            NSDictionary  *  dic=(NSDictionary *)obj;
            if ([dic[@"code"] intValue]==1) {
                [self loadLaunchAdWithUrl:dic[@"data"][@"url"] nav:nav imageUrl:dic[@"data"][@"image"]];
            }
    
        } failed:^(id  _Nonnull obj) {
    
        }];
}
- (void)loadLaunchAdWithUrl:(NSString *)url nav:(UINavigationController  *)nav imageUrl:(NSString *)imageUrl {
    _launchAd = [[SZLaunchAdPage alloc] init];
    _launchAd.ADduration = 10;
    _launchAd.timeoutDuration = 3;
    _launchAd.ADImageURL = imageUrl;
    _launchAd.skipButtonClickBlock = ^{
        NSLog(@"点击了跳过");
    };
    _launchAd.launchAdClosed = ^{
        NSLog(@"广告已关闭");
    };
    _launchAd.launchAdClickBlock = ^{
        NSLog(@"点击了广告");
        CSWebViewController   *  VC=[[CSWebViewController alloc]init];
        VC.linkUrl=url;
        [nav pushViewController:VC animated:NO];
    
    };
    _launchAd.launchAdLoadError = ^(NSError * _Nonnull error) {
        NSLog(@"广告加载失败 - %@", error);
    };
    [self.window addSubview:_launchAd.view];
    
}

- (void)sceneDidDisconnect:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end

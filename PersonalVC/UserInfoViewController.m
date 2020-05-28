//
//  UserInfoViewController.m
//  ClassSchedule
//
//  Created by Superme on 2019/10/30.
//  Copyright © 2019 Superme. All rights reserved.
//

#import "UserInfoViewController.h"
#import "LCActionAlertView.h"
#import "UniverdsityListViewController.h"
#import "YTTextViewAlertView.h"
@interface UserInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
@property (nonatomic, strong) UITableView       *    tableView;
@property (nonatomic, strong) NSMutableArray    *    dataList;
@property (nonatomic, strong) NSMutableArray    *    contentList;
@property (nonatomic, strong) UIImageView       *    headImgView;
@property (nonatomic, strong) NSMutableArray    *    uploadData;
@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.naviView.naviTitleLabel.text=@"个人信息";
    self.view.backgroundColor=RGB(247, 244, 249);
    self.naviView.image.image=[UIImage imageNamed:@"personal_center_bg"]; ;
    [self tableView];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UniverdsityListViewController   *  vc=[[UniverdsityListViewController alloc]init];
    if (indexPath.row==0) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        [LCActionAlertView showActionViewNames:@[@"照相机",@"本地相册"] completed:^(NSInteger index,NSString * name) {
            if (index==0) {
                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:imagePickerController animated:YES completion:nil];
            }else{
                imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:imagePickerController animated:YES completion:nil];
            }
        } canceled:^{

        }];
    }
    if (indexPath.row==1) {
         YTTextViewAlertView *alertView = [YTTextViewAlertView new];
           [alertView show];
        alertView.max_textCont_label.text=@"20个字以内";
        alertView.repulse_label.text=@"昵称";
        alertView.repulse_content_textView.text=@"请输入昵称";
           alertView.ytAlertViewMakeSureBlock = ^(NSString *repulse_evaluate_str) {
               if ([repulse_evaluate_str isEmpty]) {
                   [self.view toast:@"请输入昵称"];
                   return ;
               }
               
               [self.contentList replaceObjectAtIndex:1 withObject:repulse_evaluate_str];
               [self changeUserInfoWithNickName:repulse_evaluate_str sex:[UserInfoDefaults valueForKey:@"sex"] school_id:[UserInfoDefaults valueForKey:@"school_id"] Major_ID:[UserInfoDefaults valueForKey:@"major_id"] Major_Item:[UserInfoDefaults valueForKey:@"major_item"]];
[self.tableView reloadData];
           };
           
           alertView.ytAlertViewCloseBlock = ^{
               NSLog(@"取消了------VC");
           };
    }
    if (indexPath.row==2) {
        [LCActionAlertView showActionViewNames:@[@"男",@"女",@"保密"] completed:^(NSInteger index,NSString * name) {
            [self.contentList replaceObjectAtIndex:2 withObject:name];
            [self changeUserInfoWithNickName:[UserInfoDefaults userInfo].nickname sex:[NSString stringWithFormat:@"%ld",(long)index] school_id:[UserInfoDefaults valueForKey:@"school_id"] Major_ID:[UserInfoDefaults valueForKey:@"major_id"] Major_Item:[UserInfoDefaults valueForKey:@"major_item"]];
            [self.tableView reloadData];
        } canceled:^{

        }];
    }
    
    if (indexPath.row==3) {
//        vc.type=@"0";
        vc.SchoolBlock = ^(NSString * _Nonnull school_id, NSString * _Nonnull school_name, NSString * _Nonnull major_id, NSString * _Nonnull major_name) {
            [self.contentList replaceObjectAtIndex:3 withObject:school_name];
             [self.contentList replaceObjectAtIndex:4 withObject:major_name];
            [self changeUserInfoWithNickName:[UserInfoDefaults userInfo].nickname sex:[UserInfoDefaults valueForKey:@"sex"] school_id:school_id Major_ID:major_id Major_Item:[UserInfoDefaults valueForKey:@"major_item"]];
            [UserInfoDefaults saveValue:school_name forKey:@"school_id"];
            [UserInfoDefaults saveValue:major_name forKey:@"major_id"];
            [self.tableView reloadData];
        };
        [self.navigationController presentViewController:vc animated:YES completion:nil];
    }
    if (indexPath.row==4) {
//        vc.type=@"0";
        vc.SchoolBlock = ^(NSString * _Nonnull school_id, NSString * _Nonnull school_name, NSString * _Nonnull major_id, NSString * _Nonnull major_name) {
            [self.contentList replaceObjectAtIndex:3 withObject:school_name];
            [self.contentList replaceObjectAtIndex:4 withObject:major_name];
            [self changeUserInfoWithNickName:[UserInfoDefaults userInfo].nickname sex:[UserInfoDefaults valueForKey:@"sex"] school_id:school_id Major_ID:major_id Major_Item:[UserInfoDefaults valueForKey:@"major_item"]];
            [UserInfoDefaults saveValue:school_name forKey:@"school_id"];
                       [UserInfoDefaults saveValue:major_name forKey:@"major_id"];
            [self.tableView reloadData];
        };
        [self.navigationController presentViewController:vc animated:YES completion:nil];
       }
    if (indexPath.row==5) {
            YTTextViewAlertView *alertView = [YTTextViewAlertView new];
              [alertView show];
              alertView.max_textCont_label.text=@"20个字以内";
                     alertView.repulse_label.text=@"专业/班级";
                     alertView.repulse_content_textView.text=@"请输入专业/班级";
              alertView.ytAlertViewMakeSureBlock = ^(NSString *repulse_evaluate_str) {
                  if ([repulse_evaluate_str isEmpty]) {
                      [self.view toast:@"请输入专业/班级"];
                      return ;
                  }
                  NSLog(@"%@",repulse_evaluate_str);
                  [self changeUserInfoWithNickName:[UserInfoDefaults userInfo].nickname sex:[UserInfoDefaults valueForKey:@"sex"] school_id:[UserInfoDefaults valueForKey:@"school_id"] Major_ID:[UserInfoDefaults valueForKey:@"major_id"] Major_Item:repulse_evaluate_str];
         [self.contentList replaceObjectAtIndex:5 withObject:repulse_evaluate_str];
           [self.tableView reloadData];
              };
              
              alertView.ytAlertViewCloseBlock = ^{
                  NSLog(@"取消了------VC");
              };
       }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = self.dataList[indexPath.row];
    cell.detailTextLabel.text=self.contentList[indexPath.row];
    
    if (indexPath.row==0) {
        [self setHeadWithCell:cell];

    }
    
    
    return cell;
}
-(void)setHeadWithCell:(UITableViewCell *)cell{
    
    UIImageView *headImage = [[UIImageView alloc]init];
    [cell.contentView addSubview:headImage];
    [headImage sd_setImageWithURL:[NSURL URLWithString:[UserInfoDefaults userInfo].avatar] placeholderImage:[UIImage imageNamed:@"avatar_defau"]];
    [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(@(-10*KScaleH));
        make.top.equalTo(@(5*KScaleH));
        make.bottom.equalTo(@(-5*KScaleH));
        make.width.equalTo(headImage.mas_height);
    }];
    [headImage setRadius:(self.tableView.rowHeight-10*KScaleH)/2];
    self.headImgView = headImage;

    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    
    return 0.1  ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.dataList.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
    
}
- (UITableView *)tableView{
    
    if (!_tableView) {
       
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(30*KScaleW, self.naviView.bottom+8*KScaleH, SCREEN_WIDTH-60*KScaleW, 366*KScaleH) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 61*KScaleH;
//        tableView.separatorInset = UIEdgeInsetsZero;
        tableView.separatorColor=RGB(244, 244, 244);
        [tableView setRadius:34.5*KScaleW];
        tableView.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}
-(void)changeUserInfoWithNickName:(NSString *)nickName sex:(NSString *)sex school_id:(NSString *)School_ID Major_ID:(NSString *)Major_ID Major_Item:(NSString *)major_Item{
    NSDictionary * dic=@{
        @"token":[UserInfoDefaults userInfo].token,
        @"nickname":nickName,
        @"sex":sex,
        @"school_id":School_ID,
        @"major_id":Major_ID,
        @"major_item":major_Item,
        @"real_name":@""
        
    };
    UserInfoModel  *  model=[UserInfoDefaults userInfo];
    [HttpTools post:API_SAVE_USERINFO params:dic loading:NO success:^(id  _Nonnull json) {
        NSDictionary * dic=(NSDictionary *)json;
        NSLog(@"个人信息==%@",dic);
        if ([dic[@"code"] intValue]==1) {
            [self.view toast:@"修改成功"];
            model.nickname=nickName;
            [UserInfoDefaults saveUserInfo:model];
            [UserInfoDefaults saveValue:sex forKey:@"sex"];
            [UserInfoDefaults saveValue:major_Item forKey:@"major_item"];
                                                   
            [self.tableView reloadData];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList=[NSMutableArray arrayWithArray:@[@"头像",
                                                   @"昵称",
                                                   @"性别",
                                                   @"学校",
        @"院系",
        @"专业/班级"]];
        
    }
    return _dataList;
}
-(NSMutableArray *)contentList{
    
    if (!_contentList) {
        NSString *sex = @"";
               
               if ([[UserInfoDefaults valueForKey:@"sex"] intValue]==0) {
                   sex = @"女";
               }else if ([[UserInfoDefaults valueForKey:@"sex"] intValue] ==1){
                   
                   sex = @"男";
               }else{
                   sex = @"保密";
               }
        _contentList=[NSMutableArray arrayWithArray:@[@"",[UserInfoDefaults userInfo].nickname==nil?@"未填写":[UserInfoDefaults userInfo].nickname,sex==nil?@"未填写":sex,[UserInfoDefaults valueForKey:@"school"]==nil?@"未填写":[UserInfoDefaults valueForKey:@"school"],[UserInfoDefaults valueForKey:@"major_name"]==nil?@"未填写":[UserInfoDefaults valueForKey:@"major_name"],[UserInfoDefaults valueForKey:@"major_item"]==nil?@"未填写":[UserInfoDefaults valueForKey:@"major_item"]]]
        ;
        }
    
    

    return _contentList;
}

#pragma mark - 上传头像
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    UIImage *rightImage = [self fixOrientation:image];
    
    NSData *imgData = UIImageJPEGRepresentation([self fixOrientation:image], 0.5);
    UIImage *rightImage = [UIImage imageWithData:imgData];
    [self.headImgView setImage:rightImage];
    [ClassHandle uploadAvatarWithToken:[UserInfoDefaults userInfo].token image:rightImage success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        if ([dic[@"code"] intValue]==1) {
            UserInfoModel   *  model=[UserInfoDefaults userInfo];
            model.avatar=dic[@"data"][@"avatar"];
            [UserInfoDefaults saveUserInfo:model];
            [self.tableView reloadData];
        }
    } failed:^(id  _Nonnull obj) {
        
    }];
    
}


-(UIImage *)fixOrientation:(UIImage *)aImage {
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
@end

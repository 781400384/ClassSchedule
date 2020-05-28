//
//  APIConfig.h
//  ClassSchedule
//
//  Created by Superme on 2019/10/25.
//  Copyright © 2019 Superme. All rights reserved.
//

#ifndef APIConfig_h
#define APIConfig_h

#define  BaseURL          @""

//#define BaseURL                    @"http://ubase.qianr.com"
#define API_GET_SCHOOLIST          @"http://kcb-api.qianr.com/v1/site/home"  //获取学校列表
#define API_LOGIN                  @"https://ubase.qianr.com/api/public/?service=CommonLogin.userLogin" //登录接口
#define API_UPLOAD_AVATAR          @"https://ubase.qianr.com/api/public/?service=user.updateAvatar" //上传头像
#define API_ADD_TERMS              @"http://kcb-api.qianr.com/v1/terms/add"//添加学期
#define API_GET_TERMS_DETAIL       @"http://kcb-api.qianr.com/v1/terms/view" //查看学期
#define API_GET_TERMS_LIST         @"http://kcb-api.qianr.com/v1/terms/list" //获取学期列表
#define API_DELETE_TERMS           @"http://kcb-api.qianr.com/v1/terms/delete" //删除学期
#define API_UPDATE_TERMS           @"http://kcb-api.qianr.com/v1/terms/update" //修改学期
#define API_ADD_CLASS              @"http://kcb-api.qianr.com/v1/course/add" //添加课程
#define API_UPDATE_CLASS           @"http://kcb-api.qianr.com/v1/course/update" //修改课程
#define API_GET_CLASS_DETAIL       @"http://kcb-api.qianr.com/v1/course/view" //查看课程详情
#define API_FEEDBACK               @"http://kcb-api.qianr.com/v1/suggest/add" //意见反馈
#define API_USERINFO               @"http://kcb-api.qianr.com/v1/user/resume-view" //查看个人信息
#define API_COPY_CLASS             @"http://kcb-api.qianr.com/v1/course/copy" //复制课程表
#define API_SAVE_USERINFO          @"http://kcb-api.qianr.com/v1/user/resume" //保存个人信息
#define API__GET_CLASS_LIST        @"http://kcb-api.qianr.com/v1/course/list"//获取课程列表
#define API_GET_ADV                @"http://kcb-api.qianr.com/v1/imgurl/list" //获取图片列表





#define  Error_Code1001      @"1001"
#define  Error_Code1002      @"1002"
#define  Error_Code1003      @"1003"
#define  NET_CACHE           @"NetCache"
#endif /* APIConfig_h */

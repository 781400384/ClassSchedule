//
//  ClassHandle.h
//  ClassSchedule
//
//  Created by Superme on 2019/11/6.
//  Copyright © 2019 Superme. All rights reserved.
//

#import "CSBaseHandle.h"

NS_ASSUME_NONNULL_BEGIN

@interface ClassHandle : CSBaseHandle


/// 获取学校列表
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getSchoolListWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;

/// 登录接口
/// @param code <#code description#>
/// @param bundle_name <#bundle_name description#>
/// @param version <#version description#>
/// @param sys <#sys description#>
/// @param channel <#channel description#>
/// @param identification <#identification description#>
/// @param type <#type description#>
/// @param uuid <#uuid description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)loginWithCode:(NSString *)code bundle_name:(NSString *)bundle_name version:(NSString *)version sys:(NSString *)sys channel:(NSString *)channel identification:(NSString *)identification type:(NSString *)type uuid:(NSString *)uuid success:(SuccessBlock)success failed:(FailedBlock)failed;


/// 增加学期
/// @param token <#token description#>
/// @param start_year <#start_year description#>
/// @param end_year <#end_year description#>
/// @param num <#num description#>
/// @param max_section <#max_section description#>
/// @param times <#times description#>
/// @param week_start_day <#week_start_day description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)addTermsWithToken:(NSString *)token start_year:(NSString *)start_year end_year:(NSString *)end_year num:(NSString *)num week:(NSString *)week max_section:(NSString *)max_section times:(NSMutableArray *)times week_start_day:(NSString *)week_start_day success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 获取学期列表
/// @param token <#token description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getTermsListWithToken:(NSString *)token success:(SuccessBlock)success failed:(FailedBlock)failed;




/// 修改学期
/// @param ID <#ID description#>
/// @param token <#token description#>
/// @param start_year <#start_year description#>
/// @param end_year <#end_year description#>
/// @param num <#num description#>
/// @param week <#week description#>
/// @param max_section <#max_section description#>
/// @param times <#times description#>
/// @param week_start_day <#week_start_day description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)updateTermsWithID:(NSString *)ID token:(NSString *)token start_year:(NSString *)start_year end_year:(NSString *)end_year num:(NSString *)num week:(NSString *)week max_section:(NSString *)max_section times:(NSMutableArray *)times week_start_day:(NSString *)week_start_day success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 查看学期详情
/// @param ID <#ID description#>
/// @param token <#token description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getTermsDetailWithID:(NSString *)ID token:(NSString *)token success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 删除学期
/// @param ID <#ID description#>
/// @param token <#token description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)deleteTermsWithID:(NSString *)ID token:(NSString *)token success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 获取课程列表
/// @param ID <#ID description#>
/// @param token <#token description#>
/// @param week <#week description#>
/// @param term_id <#term_id description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getClassListWithtoken:(NSString *)token week:(NSString *)week term_id:(NSString *)term_id success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 复制课程
/// @param token <#token description#>
/// @param user_no <#user_no description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)copyClassWithToken:(NSString *)token user_no:(NSString *)user_no success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 查看个人信息
/// @param token <#token description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getUserInfoDetailWithToken:(NSString *)token success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 保存用户信息
/// @param token <#token description#>
/// @param real_name <#real_name description#>
/// @param nickName <#nickName description#>
/// @param sex <#sex description#>
/// @param schoolId <#schoolId description#>
/// @param majorid <#majorid description#>
/// @param major_term <#major_term description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)saveUserInfoWithToken:(NSString *)token real_name:(NSString *)real_name nickName:(NSString *)nickName sex:(NSString *)sex schoolId:(NSString *)schoolId major_id:(NSString *)majorid major_term:(NSString *)major_term success:(SuccessBlock)success faield:(FailedBlock)failed;

/// 意见反馈
/// @param token <#token description#>
/// @param info <#info description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)feedBackWithToken:(NSString *)token info:(NSString *)info success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 添加课程
/// @param token <#token description#>
/// @param term_id <#term_id description#>
/// @param title <#title description#>
/// @param room <#room description#>
/// @param week_start <#week_start description#>
/// @param week_end <#week_end description#>
/// @param section_week <#section_week description#>
/// @param section_from <#section_from description#>
/// @param section_to <#section_to description#>
/// @param teacher <#teacher description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)addClassWithToken:(NSString *)token term_id:(NSString *)term_id title:(NSString *)title room:(NSString *)room week_start:(NSString *)week_start week_end:(NSString *)week_end section_week:(NSString *)section_week section_from:(NSString *)section_from section_to:(NSString *)section_to teacher:(NSString *)teacher success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 修改课程
/// @param ID <#ID description#>
/// @param token <#token description#>
/// @param term_id <#term_id description#>
/// @param title <#title description#>
/// @param room <#room description#>
/// @param week_start <#week_start description#>
/// @param week_end <#week_end description#>
/// @param section_week <#section_week description#>
/// @param section_from <#section_from description#>
/// @param section_to <#section_to description#>
/// @param teacher <#teacher description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)updateClassWithID:(NSString *)ID token:(NSString *)token term_id:(NSString *)term_id title:(NSString *)title room:(NSString *)room week_start:(NSString *)week_start week_end:(NSString *)week_end section_week:(NSString *)section_week section_from:(NSString *)section_from section_to:(NSString *)section_to teacher:(NSString *)teacher success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 查看课程
/// @param ID <#ID description#>
/// @param token <#token description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getClassDetailWithID:(NSString *)ID token:(NSString *)token success:(SuccessBlock)success failed:(FailedBlock)failed;


/// 上传头像
/// @param token <#token description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)uploadAvatarWithToken:(NSString *)token image:(UIImage *)avatarImage success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 获取图片列表
/// @param ID <#ID description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getImageWithId:(NSString *)ID  success:(SuccessBlock)success failed:(FailedBlock)failed;


@end

NS_ASSUME_NONNULL_END

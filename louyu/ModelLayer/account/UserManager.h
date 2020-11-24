//
//  UserManager.h
//  Accountant
//
//  Created by aaa on 2017/2/27.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModuleProtocol.h"

@interface UserManager : NSObject

+ (instancetype)sharedManager;

#pragma mark - 个人中心
/**
 请求登陆接口

 @param userName 用户名
 @param pwd 密码
 @param object 请求成功后通知的对象
 */
- (void)loginWithUserName:(NSString *)userName
              andPassword:(NSString *)pwd
       withNotifiedObject:(id<UserModule_LoginProtocol>)object;



/**
 请求重置密码接口

 @param oldPwd 旧密码
 @param newPwd 新密码
 @param object 请求成功后通知的对象
 */
- (void)resetPasswordWithOldPassword:(NSString *)oldPwd andNewPwd:(NSString *)newPwd withNotifiedObject:(id<UserModule_ResetPwdProtocol>)object;


// 注册
- (void)registWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_RegistProtocol>)object;


// 忘记密码
- (void)forgetPsdWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ForgetPasswordProtocol>)object;

// 获取验证码
- (void)getVerifyCodeWithPhoneNumber:(NSString *)phoneNumber withNotifiedObject:(id<UserModule_VerifyCodeProtocol>)object;

// 绑定手机号
- (void)getBindPhoneNumber:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_BindPhoneNumber>)object;

- (void)didRequestBindJPushWithCID:(NSString *)cid withNotifiedObject:(id<UserModule_BindJPushProtocol>)object;

// 获取我的班级
- (void)didRequestMyClassroomInfoWithNotifiedObject:(id<UserModule_MyClassroomProtocol>)object;
- (NSArray *)getmyClassroom;

/**
 请求app版本信息

 @param object 请求成功后通知的对象
 */
- (void)didRequestAppVersionInfoWithNotifiedObject:(id<UserModule_AppInfoProtocol>)object;

/**
 退出登录
 */
- (void)logout;

/**
 判断是否已经登陆

 @return 是否登陆
 */
- (BOOL)isUserLogin;

/**
 获取用户id

 @return 用户id
 */
- (int)getUserId;
- (int)getDepartId;

- (NSString *)getWangyiToken;

/**
 获取用户类型
 
 @return 用户类型
 */
- (int)getUserType;

/**
 获取用户名

 @return 用户名
 */
- (NSString *)getUserName;

/**
 获取昵称
 
 @return 昵称
 */
- (NSString *)getUserNickName;

/**
 获取验证码
 
 @return 验证码
 */
- (NSString *)getVerifyCode;

/**
 获取绑定手机号
 
 @return 已绑定手机号
 */
- (NSString *)getVerifyPhoneNumber;

/**
 获取用户信息

 @return 用户信息
 */
- (NSDictionary *)getUserInfos;

- (void)refreshUserInfoWith:(NSDictionary *)infoDic;


- (NSDictionary *)getUpdateInfo;

- (void)encodeUserInfo;

- (int )getDayNum;
- (int )getWeekNum;
- (int )getMonthNum;
- (int )getSliceId;

#pragma mark - userData
- (void)didRequestNotifyListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_MyCollectiontextBook>)object;
- (void)didRequestRulerListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_MyQuestionlist>)object;

- (NSArray *)getNotifyArray;
- (NSArray *)getRulerArray;

- (void)didRequestSearchCompanyInfoWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_SearchMyCollectiontextBook>)object;
- (void)didRequestSearchBuildingInfoWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_MyBookMarkList>)object;
- (NSArray *)getCompanyArray;
- (NSArray *)getBuildArray;

- (void)didRequestAllBuildTypeListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_MyHeadQuestion>)object;
- (void)didRequestDepartmentListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_DeleteMyCollectiontextBook>)object;
- (NSArray *)getAllBuildTypeArray;
- (NSArray *)getDepartmentArray;
- (void)didRequestAllBuildLocationWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_DeleteMyBookmark>)object;
- (NSArray *)getAllBuildLocationArray;
- (void)didRequestNavigationEndPointWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_ClearnMyBookmark>)object;
- (NSDictionary * )getNavigationEndPoint;
- (void)didRequestBuildCompanyListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_MyQuestionDetail>)object;
- (NSArray *)getBuildCompanyArray;


- (void)didRequestbuildSaleWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_SetaHaveReadQuestion>)object;
- (NSArray *)getBuildSaleArray;

- (NSArray *)getSearchMyCollectionTextbookArray;
- (NSArray *)getMyBookmarkArray;
- (NSArray *)getMyQuestionDetailArray;


#pragma mark - 个人信息设置
- (void)didRequestChangeIconImageWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_changeIconImage>)object;
- (void)didRequestChangeIconImageFileWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_ChangeGender>)object;
- (void)didRequestChangeNickNameWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_ChangeNickName>)object;
- (void)didRequestChangePhoneNumberWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_BindPhoneNumber>)object;
- (void)didRequestChangeBirthdayWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_ChangeBirthday>)object;
- (void)didRequestChangeReceiveAddressWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_ChangeReceiveAddress>)object;
- (void)didRequestAddCompanyWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_NotificationNoDisturbConfig>)object;
- (void)didRequestlogoutWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_Logout>)object;

- (NSDictionary *)getChangeIconImageFile;

- (void)changeIconUrl:(NSString *)headImageUrl;
- (void)changeUserName:(NSString *)nikeName;
- (void)changeGender:(NSString *)nikeName;
- (void)changeBirthday:(NSString *)nikeName;
- (void)changeRecieveAddress:(NSDictionary *)infoDic;
- (void)changeNotificationNoDisturb:(NSString *)notifyStr;
- (void)changePhone:(NSString *)phoneNumber;

#pragma mark -个人中心
- (void)didRequestMyProductWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyProduct>)object;
- (void)didRequestDeleteMyProductWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_DeleteMyProduct>)object;
- (void)didRequestShareMyProductWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_ShareMyProduct>)object;
- (void)didRequestMyHeadTaskListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyHeadTaskList>)object;
- (void)didRequestMyEveryDayTaskDetailListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyEveryDayTaskDetailList>)object;
- (void)didRequestMyEveryDayTaskWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyEveryDayTask>)object;
- (void)didRequestMyCourseListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyCourseList>)object;
- (void)didRequestMyAttendanceListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyAttendanceList>)object;
- (void)didRequestMyCourseCostWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyCourseCost>)object;
- (void)didRequestBuyCourseRecordWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_BuyCourseRecord>)object;
- (void)didRequestMyAchievementListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyAchievementList>)object;
- (void)didRequestMyStudyTimeLengthListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyStudyTimeLengthList>)object;
- (void)didRequestMyStudyTimeLengthDetailListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyStudyTimeLengthDetailList>)object;
- (void)didRequestPunchCardListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_PunchCardList>)object;

- (void)didRequestMyCourse_BigCourseListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyCourse_BigCourseList>)object;
- (void)didRequestCurrentWeekCourseListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_CurrentWeekCourseList>)object;
- (NSArray *)getMyCourse_BigCourseList;
- (NSArray *)getCurrentWeekCourseList;

- (NSMutableArray *)getMyProductInfoDic;
- (NSMutableArray *)getMyProduct_shareInfoDic;
- (NSMutableArray *)getMyRecordProductInfoDic;
- (NSMutableArray*)getMyCreatProductInfoDic;

- (NSMutableArray *)getMyCreatProduct_shareInfoDic;
- (NSMutableArray *)getMyTaskRecordProduct_shareInfoDic;

- (NSMutableArray *)getMyTaskRecordProductInfoDic;
- (NSMutableArray*)getMyTaskCreatProductInfoDic;

- (int)getMyProductNoReadCount;

- (NSArray *)getMyHeadTaskList;
- (NSArray *)getMyEveryDayTaskDetailList;
- (NSArray *)getMyEveryDayTaskList;
- (NSArray *)getMyEveryDayTaskListNoClassify;

- (NSArray *)getMyCourseList;
- (NSDictionary *)getMyAttendanceInfoDic;
- (NSArray *)getMyCourseCost;
- (NSArray *)getMyBuyCourseRecordList;
- (NSDictionary *)getMyAchievementList;
- (NSDictionary *)getMyStudyTimeLengthList;
- (NSArray *)getMyStudyTimeLengthDetailList;
- (NSDictionary *)getMyPunchCardList;
- (NSDictionary *)getShareMyproductInfo;

@end

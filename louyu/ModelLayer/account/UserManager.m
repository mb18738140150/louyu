//
//  UserManager.m
//  Accountant
//
//  Created by aaa on 2017/2/27.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "UserManager.h"
#import "UserModuleModels.h"
#import "ResetPwdOperation.h"
#import "AppInfoOperation.h"

#import "LoginStatusOperation.h"
#import "VerifyCodeOperation.h"
#import "RegistOperation.h"
#import "ForgetPsdOperation.h"

#import "PathUtility.h"
#import "BindPhoneNumberOperation.h"
#import "BindJPushOperation.h"
#import "UserInfoOperation.h"
@interface UserManager()

@property (nonatomic,strong) UserModuleModels           *userModuleModels;
@property (nonatomic,strong) LoginStatusOperation       *loginOperation;
@property (nonatomic,strong) AppInfoOperation           *infoOperation;
@property (nonatomic, strong)VerifyCodeOperation         *verifyCodeOperation;
@property (nonatomic, strong)RegistOperation         *registOperation;
@property (nonatomic, strong)ForgetPsdOperation         *forgetPsdOperation;
@property (nonatomic,strong) ResetPwdOperation          *resetOperation;

@property (nonatomic, strong)UserInfoOperation * userInfoOperation;
@property (nonatomic, strong)BindPhoneNumberOperation       *bindPhoneNumberOperation;
@property (nonatomic, strong)BindJPushOperation *bindJPushOperation;

@end

@implementation UserManager

+ (instancetype)sharedManager
{
    static UserManager *__manager__;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __manager__ = [[UserManager alloc] init];
    });
    return __manager__;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.userModuleModels = [[UserModuleModels alloc] init];
        self.loginOperation = [[LoginStatusOperation alloc] init];
        [self.loginOperation setCurrentUser:self.userModuleModels.currentUserModel];
        self.resetOperation = [[ResetPwdOperation alloc] init];
        
        self.infoOperation = [[AppInfoOperation alloc] init];
        self.infoOperation.appInfoModel = self.userModuleModels.appInfoModel;
        self.verifyCodeOperation = [[VerifyCodeOperation alloc]init];
        self.registOperation = [[RegistOperation alloc]init];
        self.forgetPsdOperation = [[ForgetPsdOperation alloc]init];
        self.bindPhoneNumberOperation = [[BindPhoneNumberOperation alloc]init];
        self.bindJPushOperation = [[BindJPushOperation alloc]init];
        self.userInfoOperation = [[UserInfoOperation alloc]init];
    }
    return self;
}

- (void)loginWithUserName:(NSString *)userName andPassword:(NSString *)pwd withNotifiedObject:(id<UserModule_LoginProtocol>)object
{
    [self.loginOperation didLoginWithUserName:userName andPassword:pwd withNotifiedObject:object];
}

- (void)resetPasswordWithOldPassword:(NSString *)oldPwd andNewPwd:(NSString *)newPwd withNotifiedObject:(id<UserModule_ResetPwdProtocol>)object
{
    [self.resetOperation didRequestResetPwdWithOldPwd:oldPwd andNewPwd:newPwd withNotifiedObject:object];
}

- (void)registWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_RegistProtocol>)object
{
    [self.registOperation didRequestRegistWithWithDic:infoDic withNotifiedObject:object];
}

- (void)forgetPsdWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ForgetPasswordProtocol>)object
{
    [self.forgetPsdOperation didRequestForgetPsdWithWithDic:infoDic withNotifiedObject:object];
}

- (void)getBindPhoneNumber:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_BindPhoneNumber>)object
{
    [self.bindPhoneNumberOperation didRequestBindPhoneNumber:infoDic withNotifiedObject:object];
}

- (void)getVerifyCodeWithPhoneNumber:(NSString *)phoneNumber withNotifiedObject:(id<UserModule_VerifyCodeProtocol>)object
{
    [self.verifyCodeOperation didRequestVerifyCodeWithWithPhoneNumber:phoneNumber withNotifiedObject:object];
}

- (void)didRequestAppVersionInfoWithNotifiedObject:(id<UserModule_AppInfoProtocol>)object
{
    [self.infoOperation didRequestAppInfoWithNotifedObject:object];
}

- (void)didRequestBindJPushWithCID:(NSString *)cid withNotifiedObject:(id<UserModule_BindJPushProtocol>)object
{
    [self.bindJPushOperation didRequestBindJPushWithCID:cid withNotifiedObject:object];
}

- (void)logout
{
    [self.loginOperation clearLoginUserInfo];
}

- (int)getUserId
{
    return self.userModuleModels.currentUserModel.userID;
}
- (int)getDepartId
{
    return self.userModuleModels.currentUserModel.departId;
}

- (NSString *)getWangyiToken
{
    return self.userModuleModels.currentUserModel.wangYiToken;
}

- (BOOL)isUserLogin
{
    return self.userModuleModels.currentUserModel.isLogin;
}

- (int)getUserType
{
    return self.userModuleModels.currentUserModel.type;
}

- (NSDictionary *)getUserInfos
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.userModuleModels.currentUserModel.userName forKey:kUserName];
    [dic setObject:@(self.userModuleModels.currentUserModel.userID) forKey:kUserId];
    [dic setObject:self.userModuleModels.currentUserModel.headImageUrl forKey:kUserHeaderImageUrl];
    
    return dic;
}

- (NSString *)getUserName
{
    return self.userModuleModels.currentUserModel.userName;
}
- (NSString *)getUserNickName
{
    return self.userModuleModels.currentUserModel.userNickName;
}

- (NSString *)getVerifyCode
{
    return self.verifyCodeOperation.verifyCode;
}

- (NSString *)getWangYiToken
{
    return self.userModuleModels.currentUserModel.wangYiToken;
}
- (NSString *)getIconUrl
{
    return self.userModuleModels.currentUserModel.headImageUrl;
}

- (int )getDayNum
{
    return self.userModuleModels.currentUserModel.dayNum;
}
- (int )getWeekNum
{
    return self.userModuleModels.currentUserModel.weekNum;
}
- (int )getMonthNum
{
    return self.userModuleModels.currentUserModel.MonthNum;
}

- (int )getSliceId
{
    return self.userModuleModels.currentUserModel.sliceId;
}

- (void)encodeUserInfo
{
    NSString *dataPath = [[PathUtility getDocumentPath] stringByAppendingPathComponent:@"user.data"];
    [NSKeyedArchiver archiveRootObject:self.userModuleModels.currentUserModel toFile:dataPath];
}


#pragma mark - 个人信息设置
- (void)didRequestChangeIconImageWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_changeIconImage>)object
{
    [self.userInfoOperation didRequestChangeIconImageWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestChangeIconImageFileWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_ChangeGender>)object
{
    [self.userInfoOperation didRequestChangeGenderWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestChangeNickNameWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_ChangeNickName>)object
{
    [self.userInfoOperation didRequestChangeNickNameWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestChangePhoneNumberWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_BindPhoneNumber>)object
{
    [self.userInfoOperation didRequestChangePhoneNumberWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestChangeBirthdayWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_ChangeBirthday>)object
{
    [self.userInfoOperation didRequestChangeBirthdayWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestChangeReceiveAddressWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_ChangeReceiveAddress>)object
{
    [self.userInfoOperation didRequestChangeReceiveAddressWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestAddCompanyWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_NotificationNoDisturbConfig>)object
{
    [self.userInfoOperation didRequestAddCompanyWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestlogoutWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_Logout>)object
{
    [self.userInfoOperation didRequestlogoutWithWithDic:infoDic withNotifiedObject:object];
}

- (NSDictionary *)getChangeIconImageFile
{
    return self.userInfoOperation.changeImageFileInfo;
}

- (void)changeIconUrl:(NSString *)headImageUrl
{
    if (headImageUrl == nil) {
        return;
    }
    self.userModuleModels.currentUserModel.headImageUrl = headImageUrl;
    [self encodeUserInfo];
}

- (void)changeUserName:(NSString *)nikeName
{
    if (nikeName == nil) {
        return;
    }
    self.userModuleModels.currentUserModel.userNickName = nikeName;
    [self encodeUserInfo];
}

- (void)changePhone:(NSString *)phoneNumber
{
    if (phoneNumber == nil) {
        return;
    }
    self.userModuleModels.currentUserModel.telephone = phoneNumber;
    [self encodeUserInfo];
}

- (void)changeGender:(NSString *)nikeName
{
    if (nikeName == nil) {
        return;
    }
    self.userModuleModels.currentUserModel.gender = nikeName;
    [self encodeUserInfo];
}
- (void)changeBirthday:(NSString *)nikeName
{
    if (nikeName == nil) {
        return;
    }
    self.userModuleModels.currentUserModel.birthday = nikeName;
    [self encodeUserInfo];
}
- (void)changeRecieveAddress:(NSDictionary *)infoDic
{
    self.userModuleModels.currentUserModel.receiveAddress = [infoDic objectForKey:kreceiveAddress];
    self.userModuleModels.currentUserModel.receiveName = [infoDic objectForKey:kreceiveName];
    self.userModuleModels.currentUserModel.receivePhoneNumber = [infoDic objectForKey:kreceivePhoneNumber];
    [self encodeUserInfo];
}

- (void)changeNotificationNoDisturb:(NSString *)notifyStr
{
    int notificationNoDisturb = 0;
    if ([notifyStr isEqualToString:@"关闭"]) {
        notificationNoDisturb = 0;
    }else
    {
        notificationNoDisturb = 1;
    }
    self.userModuleModels.currentUserModel.notificationNoDisturb = notificationNoDisturb;
    [self encodeUserInfo];
}



#pragma mark - userData
- (void)didRequestNotifyListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_MyCollectiontextBook>)object
{
    [self.userInfoOperation didRequestMyCollectionTextBookWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestRulerListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_MyQuestionlist>)object
{
    [self.userInfoOperation didRequestMyQuestionListWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestSearchCompanyInfoWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_SearchMyCollectiontextBook>)object
{
    [self.userInfoOperation didRequestSearchMyCollectionTextBookWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestSearchBuildingInfoWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_MyBookMarkList>)object
{
    [self.userInfoOperation didRequestMyBookmarkListWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestAllBuildTypeListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_MyHeadQuestion>)object
{
    [self.userInfoOperation didRequestAllBuildTypeListWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestDepartmentListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_DeleteMyCollectiontextBook>)object
{
    [self.userInfoOperation didRequestDepartmentListWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestAllBuildLocationWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_DeleteMyBookmark>)object
{
    [self.userInfoOperation didRequestAllBuildLocationWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestNavigationEndPointWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_ClearnMyBookmark>)object
{
    [self.userInfoOperation didRequestNavigationEndPointWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestBuildCompanyListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_MyQuestionDetail>)object
{
    [self.userInfoOperation didRequestBuildCompanyListWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestbuildSaleWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_SetaHaveReadQuestion>)object
{
    [self.userInfoOperation didRequestbuildSaleWithWithDic:infoDic withNotifiedObject:object];
}









- (NSArray *)getNotifyArray
{
    return self.userInfoOperation.myCollectionTextbookArray;
}
- (NSArray *)getRulerArray
{
    return self.userInfoOperation.myQuestionArray;
}

- (NSArray *)getCompanyArray
{
    return self.userInfoOperation.companyList;
}
- (NSArray *)getBuildArray
{
    return self.userInfoOperation.buildList;
}
- (NSDictionary * )getNavigationEndPoint
{
    return self.userInfoOperation.navigationEndPoint;
}
- (NSArray *)getBuildCompanyArray
{
    return self.userInfoOperation.buildCompantyList;
}

- (NSArray *)getBuildSaleArray
{
    return self.userInfoOperation.buildSaleList;
}

- (NSArray *)getSearchMyCollectionTextbookArray
{
    return self.userInfoOperation.searchCollectionTextbookArray;
}
- (NSArray *)getMyBookmarkArray
{
    return self.userInfoOperation.myBookmarkArray;
}
- (NSArray *)getAllBuildTypeArray
{
    return self.userInfoOperation.myHeadQuestionArray;
}
- (NSArray *)getDepartmentArray
{
    return self.userInfoOperation.departmentList;
}
- (NSArray *)getAllBuildLocationArray
{
    return self.userInfoOperation.allBuildLocationList;
}

- (NSArray *)getMyQuestionDetailArray
{
    return self.userInfoOperation.myQuestionDetailArray;
}


@end

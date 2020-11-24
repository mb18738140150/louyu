//
//  UserInfoOperation.m
//  qianshutang
//
//  Created by aaa on 2018/9/1.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "UserInfoOperation.h"

@interface UserInfoOperation()<HttpRequestProtocol>

@property (nonatomic,weak) id<UserInfo_changeIconImage>          changeIconImageNotifiedObject;
@property (nonatomic,weak) id<UserInfo_ChangeNickName>          ChangeNickNameNotifiedObject;
@property (nonatomic,weak) id<UserInfo_BindPhoneNumber>          BindPhoneNumberRequestNotifiedObject;
@property (nonatomic,weak) id<UserInfo_ChangeGender>          ChangeGenderNotifiedObject;
@property (nonatomic,weak) id<UserInfo_ChangeBirthday>          ChangeBirthdayNotifiedObject;
@property (nonatomic,weak) id<UserInfo_ChangeReceiveAddress>          ChangeReceiveAddressNotifiedObject;
@property (nonatomic,weak) id<UserInfo_NotificationNoDisturbConfig>          NotificationNoDisturbConfigNotifiedObject;
@property (nonatomic,weak) id<UserInfo_Logout>          LogoutNotifiedObject;


@property (nonatomic,weak) id<UserData_MyCollectiontextBook>          MyCollectiontextBookNotifiedObject;
@property (nonatomic,weak) id<UserData_SearchMyCollectiontextBook>          SearchMyCollectiontextBookNotifiedObject;
@property (nonatomic,weak) id<UserData_DeleteMyCollectiontextBook>          DeleteMyCollectiontextBookNotifiedObject;
@property (nonatomic,weak) id<UserData_MyBookMarkList>          MyBookMarkListNotifiedObject;
@property (nonatomic,weak) id<UserData_DeleteMyBookmark>          DeleteMyBookmarkNotifiedObject;
@property (nonatomic,weak) id<UserData_ClearnMyBookmark>          ClearnMyBookmarkNotifiedObject;
@property (nonatomic,weak) id<UserData_MyHeadQuestion>          MyHeadQuestionNotifiedObject;
@property (nonatomic,weak) id<UserData_MyQuestionlist>          MyQuestionlistNotifiedObject;
@property (nonatomic,weak) id<UserData_MyQuestionDetail>          MyQuestionDetailNotifiedObject;
@property (nonatomic,weak) id<UserData_SetaHaveReadQuestion>          SetaHaveReadQuestionNotifiedObject;

@property (nonatomic, strong)NSDictionary * infoDic;

@property (nonatomic, strong)NSDictionary * buildSaleRequestInfo;
@property (nonatomic, strong)NSDictionary * buildCompanyRequestInfo;
@property (nonatomic, strong)NSDictionary * companyListRequestInfo;

@end

@implementation UserInfoOperation

- (NSMutableArray *)companyList
{
    if (!_companyList) {
        _companyList = [NSMutableArray array];
    }
    return _companyList;
}

- (NSMutableArray *)buildSaleList
{
    if (!_buildSaleList) {
        _buildSaleList = [NSMutableArray array];
    }
    return _buildSaleList;
}

- (NSMutableArray *)buildCompantyList
{
    if (!_buildCompantyList) {
        _buildCompantyList = [NSMutableArray array];
    }
    return _buildCompantyList;
}

- (void)didRequestChangeIconImageWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_changeIconImage>)object
{
    self.changeIconImageNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustChangeIconImageWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestChangeNickNameWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_ChangeNickName>)object
{
    self.ChangeNickNameNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustChangeNickNameWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestChangePhoneNumberWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_BindPhoneNumber>)object
{
    self.BindPhoneNumberRequestNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustChangePhoneNumberWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestChangeGenderWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_ChangeGender>)object
{
    self.ChangeGenderNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustChangeGenderWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestChangeBirthdayWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_ChangeBirthday>)object
{
    self.ChangeBirthdayNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustChangeBirthdayWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestChangeReceiveAddressWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_ChangeReceiveAddress>)object
{
    self.ChangeReceiveAddressNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustChangeReceiveAddressWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestAddCompanyWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_NotificationNoDisturbConfig>)object
{
    self.NotificationNoDisturbConfigNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustNotificationNoDisturWithDic:infoDic andProcessDelegate:self];
    
}
- (void)didRequestlogoutWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_Logout>)object
{
    self.LogoutNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustLogoutWithDic:infoDic andProcessDelegate:self];
}

#pragma mark - userData
- (void)didRequestMyQuestionListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_MyQuestionlist>)object
{
    self.MyQuestionlistNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustMyQuestionListWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestMyCollectionTextBookWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_MyCollectiontextBook>)object
{
    self.infoDic = infoDic;
    self.MyCollectiontextBookNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustMyCollectionTextBookWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestSearchMyCollectionTextBookWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_SearchMyCollectiontextBook>)object
{
    self.companyListRequestInfo = infoDic;
    self.SearchMyCollectiontextBookNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustSearchMyCollectionTextBookWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestAllBuildTypeListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_MyHeadQuestion>)object
{
    self.MyHeadQuestionNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustMyHeadQuestionListWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestMyBookmarkListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_MyBookMarkList>)object
{
    self.MyBookMarkListNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustMyBookmarkListWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestDepartmentListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_DeleteMyCollectiontextBook>)object
{
    self.DeleteMyCollectiontextBookNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustDeleteMyCollectionTextBookWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestAllBuildLocationWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_DeleteMyBookmark>)object
{
    self.DeleteMyBookmarkNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustDeleteMyBookmarkWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestNavigationEndPointWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_ClearnMyBookmark>)object
{
    self.ClearnMyBookmarkNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustClearnMyBookmarkListWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestBuildCompanyListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_MyQuestionDetail>)object
{
    self.buildCompanyRequestInfo = infoDic;
    self.MyQuestionDetailNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustMyQuestionDetailWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestbuildSaleWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_SetaHaveReadQuestion>)object
{
    self.buildSaleRequestInfo = infoDic;
    self.SetaHaveReadQuestionNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustSetHaveReadQuestionWithDic:infoDic andProcessDelegate:self];
}







#pragma mark - httpdelegate
- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    switch ([[successInfo objectForKey:@"command"] intValue]) {
        case 5:
        {
//            self.companyList = [successInfo objectForKey:@"CompanyList"];
            
            if ([[self.companyListRequestInfo objectForKey:@"page"] intValue] > 1) {
                for (NSDictionary * infoDic in [successInfo objectForKey:@"CompanyList"]) {
                    [self.companyList addObject:infoDic];
                }
            }else
            {
                [self.companyList removeAllObjects];
                for (NSDictionary * infoDic in [successInfo objectForKey:@"CompanyList"]) {
                    [self.companyList addObject:infoDic];
                }
            }
            
            if (isObjectNotNil(self.SearchMyCollectiontextBookNotifiedObject)) {
                [self.SearchMyCollectiontextBookNotifiedObject didRequestSearchMyCollectiontextBookSuccessed];
            }
        }
            break;
        case 6:
        {
            self.buildList = [successInfo objectForKey:@"buildList"];
            if (isObjectNotNil(self.MyBookMarkListNotifiedObject)) {
                [self.MyBookMarkListNotifiedObject didRequestMyBookMarkListSuccessed];
            }
        }
            break;
            
        case 8:
        {
            self.changeImageFileInfo = successInfo;
            if (isObjectNotNil(self.ChangeGenderNotifiedObject)) {
                [self.ChangeGenderNotifiedObject didRequestChangeGenderSuccessed];
            }
        }
            break;
        case 9:
        {
            if (isObjectNotNil(self.changeIconImageNotifiedObject)) {
                [self.changeIconImageNotifiedObject didRequestchangeIconImageSuccessed];
            }
        }
            break;
        case 4:
        {
            if (isObjectNotNil(self.NotificationNoDisturbConfigNotifiedObject)) {
                [self.NotificationNoDisturbConfigNotifiedObject didRequestNotificationNoDisturbConfigSuccessed];
            }
        }
            break;
        case 11:
        {
            self.myHeadQuestionArray = [successInfo objectForKey:@"industryList"];
            if (isObjectNotNil(self.MyHeadQuestionNotifiedObject)) {
                [self.MyHeadQuestionNotifiedObject didRequestMyHeadQuestionSuccessed];
            }
        }
            break;
        case 2:
        {
            self.myCollectionTextbookArray = [successInfo objectForKey:@"noticeList"];
            if (isObjectNotNil(self.MyCollectiontextBookNotifiedObject)) {
                [self.MyCollectiontextBookNotifiedObject didRequestMyCollectiontextBookSuccessed];
            }
        }
            break;
        case 3:
        {
            self.myQuestionArray = [successInfo objectForKey:@"policyList"];
            if (isObjectNotNil(self.MyQuestionlistNotifiedObject)) {
                [self.MyQuestionlistNotifiedObject didRequestMyQuestionlistSuccessed];
            }
        }
            break;
        case 12:
        {
            self.allBuildLocationList = [successInfo objectForKey:@"buildList"];
            if (isObjectNotNil(self.DeleteMyBookmarkNotifiedObject)) {
                [self.DeleteMyBookmarkNotifiedObject didRequestDeleteMyBookmarkSuccessed];
            }
        }
            break;
            
        case 13:
        {
            if ([[self.buildCompanyRequestInfo objectForKey:@"page"] intValue] > 1) {
                for (NSDictionary * infoDic in [successInfo objectForKey:@"companyList"]) {
                    [self.buildCompantyList addObject:infoDic];
                }
            }else
            {
                [self.buildCompantyList removeAllObjects];
                for (NSDictionary * infoDic in [successInfo objectForKey:@"companyList"]) {
                    [self.buildCompantyList addObject:infoDic];
                }
            }
            if (isObjectNotNil(self.MyQuestionDetailNotifiedObject)) {
                [self.MyQuestionDetailNotifiedObject didRequestMyQuestionDetailSuccessed];
            }
        }
            break;
            
        case 14:
        {
            if ([[self.buildSaleRequestInfo objectForKey:@"page"] intValue] > 1) {
                for (NSDictionary * infoDic in [successInfo objectForKey:@"msgList"]) {
                    [self.buildSaleList addObject:infoDic];
                }
            }else
            {
                [self.buildSaleList removeAllObjects];
                for (NSDictionary * infoDic in [successInfo objectForKey:@"msgList"]) {
                    [self.buildSaleList addObject:infoDic];
                }
            }
            if (isObjectNotNil(self.SetaHaveReadQuestionNotifiedObject)) {
                [self.SetaHaveReadQuestionNotifiedObject didRequestSetaHaveReadQuestionSuccessed];
            }
        }
            break;
        case 15:
        {
            self.navigationEndPoint = successInfo;
            if (isObjectNotNil(self.ClearnMyBookmarkNotifiedObject)) {
                [self.ClearnMyBookmarkNotifiedObject didRequestClearnMyBookmarkSuccessed];
            }
        }
            break;
        case 16:
        {
            self.departmentList = [successInfo objectForKey:@"sliceList"];
            if (isObjectNotNil(self.DeleteMyCollectiontextBookNotifiedObject)) {
                [self.DeleteMyCollectiontextBookNotifiedObject didRequestDeleteMyCollectiontextBookSuccessed];
            }
        }
            break;
            
            
            
            
            
        
        case 20:
        {
            if (isObjectNotNil(self.ChangeNickNameNotifiedObject)) {
                [self.ChangeNickNameNotifiedObject didRequestChangeNickNameSuccessed];
            }
        }
            break;
        case 22:
        {
            if (isObjectNotNil(self.BindPhoneNumberRequestNotifiedObject)) {
                [self.BindPhoneNumberRequestNotifiedObject didRequestBindPhoneNumberSuccessed];
            }
        }
            break;
        
        case 24:
        {
            if (isObjectNotNil(self.ChangeBirthdayNotifiedObject)) {
                [self.ChangeBirthdayNotifiedObject didRequestChangeBirthdaySuccessed];
            }
        }
            break;
        case 25:
        {
            if (isObjectNotNil(self.ChangeReceiveAddressNotifiedObject)) {
                [self.ChangeReceiveAddressNotifiedObject didRequestChangeReceiveAddressSuccessed];
            }
        }
            break;
        
        case 27:
        {
            if (isObjectNotNil(self.LogoutNotifiedObject)) {
                [self.LogoutNotifiedObject didRequestLogoutSuccessed];
            }
        }
            break;
        case 51:
        {
            self.myCollectionTextbookArray = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.MyCollectiontextBookNotifiedObject)) {
                [self.MyCollectiontextBookNotifiedObject didRequestMyCollectiontextBookSuccessed];
            }
        }
            break;
      
            
        default:
            break;
    }
    
}

- (void)didRequestFailedWithInfo:(NSDictionary *)failedInfo
{
    switch ([[failedInfo objectForKey:@"command"] intValue]) {
        case 2:
        {
            if (isObjectNotNil(self.MyCollectiontextBookNotifiedObject)) {
                [self.MyCollectiontextBookNotifiedObject didRequestMyCollectiontextBookFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
            
        case 5:
        {
            if (isObjectNotNil(self.SearchMyCollectiontextBookNotifiedObject)) {
                [self.SearchMyCollectiontextBookNotifiedObject didRequestSearchMyCollectiontextBookFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 6:
        {
            if (isObjectNotNil(self.MyBookMarkListNotifiedObject)) {
                [self.MyBookMarkListNotifiedObject didRequestMyBookMarkListFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 8:
        {
            if (isObjectNotNil(self.ChangeGenderNotifiedObject)) {
                [self.ChangeGenderNotifiedObject didRequestChangeGenderFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 9:
        {
            if (isObjectNotNil(self.changeIconImageNotifiedObject)) {
                [self.changeIconImageNotifiedObject didRequestchangeIconImageFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 3:
        {
            if (isObjectNotNil(self.MyQuestionlistNotifiedObject)) {
                [self.MyQuestionlistNotifiedObject didRequestMyQuestionlistFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 4:
        {
            if (isObjectNotNil(self.NotificationNoDisturbConfigNotifiedObject)) {
                [self.NotificationNoDisturbConfigNotifiedObject didRequestNotificationNoDisturbConfigFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 11:
        {
            if (isObjectNotNil(self.MyHeadQuestionNotifiedObject)) {
                [self.MyHeadQuestionNotifiedObject didRequestMyHeadQuestionFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 12:
        {
            if (isObjectNotNil(self.DeleteMyBookmarkNotifiedObject)) {
                [self.DeleteMyBookmarkNotifiedObject didRequestDeleteMyBookmarkFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 13:
        {
            if (isObjectNotNil(self.MyQuestionDetailNotifiedObject)) {
                [self.MyQuestionDetailNotifiedObject didRequestMyQuestionDetailFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 14:
        {
            if (isObjectNotNil(self.SetaHaveReadQuestionNotifiedObject)) {
                [self.SetaHaveReadQuestionNotifiedObject didRequestSetaHaveReadQuestionFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 15:
        {
            if (isObjectNotNil(self.ClearnMyBookmarkNotifiedObject)) {
                [self.ClearnMyBookmarkNotifiedObject didRequestClearnMyBookmarkFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 16:
        {
            if (isObjectNotNil(self.DeleteMyCollectiontextBookNotifiedObject)) {
                [self.DeleteMyCollectiontextBookNotifiedObject didRequestDeleteMyCollectiontextBookFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
            
            
            
        
        case 20:
        {
            if (isObjectNotNil(self.ChangeNickNameNotifiedObject)) {
                [self.ChangeNickNameNotifiedObject didRequestChangeNickNameFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 22:
        {
            if (isObjectNotNil(self.BindPhoneNumberRequestNotifiedObject)) {
                [self.BindPhoneNumberRequestNotifiedObject didRequestBindPhoneNumberFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        
        case 24:
        {
            if (isObjectNotNil(self.ChangeBirthdayNotifiedObject)) {
                [self.ChangeBirthdayNotifiedObject didRequestChangeBirthdayFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 25:
        {
            if (isObjectNotNil(self.ChangeReceiveAddressNotifiedObject)) {
                [self.ChangeReceiveAddressNotifiedObject didRequestChangeReceiveAddressFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        
        case 27:
        {
            if (isObjectNotNil(self.LogoutNotifiedObject)) {
                [self.LogoutNotifiedObject didRequestLogoutFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 51:
        {
            if (isObjectNotNil(self.MyCollectiontextBookNotifiedObject)) {
                [self.MyCollectiontextBookNotifiedObject didRequestMyCollectiontextBookFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 52:
        {
            if (isObjectNotNil(self.SearchMyCollectiontextBookNotifiedObject)) {
                [self.SearchMyCollectiontextBookNotifiedObject didRequestSearchMyCollectiontextBookFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 58:
        {
            if (isObjectNotNil(self.MyQuestionlistNotifiedObject)) {
                [self.MyQuestionlistNotifiedObject didRequestMyQuestionlistFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 53:
        {
            if (isObjectNotNil(self.DeleteMyCollectiontextBookNotifiedObject)) {
                [self.DeleteMyCollectiontextBookNotifiedObject didRequestDeleteMyCollectiontextBookFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 54:
        {
            if (isObjectNotNil(self.MyBookMarkListNotifiedObject)) {
                [self.MyBookMarkListNotifiedObject didRequestMyBookMarkListFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        default:
            break;
    }
    
}



@end

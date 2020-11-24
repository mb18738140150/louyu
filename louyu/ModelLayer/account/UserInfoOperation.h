//
//  UserInfoOperation.h
//  qianshutang
//
//  Created by aaa on 2018/9/1.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoOperation : NSObject

- (void)didRequestChangeIconImageWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_changeIconImage>)object;
- (void)didRequestChangeNickNameWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_ChangeNickName>)object;
- (void)didRequestChangePhoneNumberWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_BindPhoneNumber>)object;
- (void)didRequestChangeGenderWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_ChangeGender>)object;
- (void)didRequestChangeBirthdayWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_ChangeBirthday>)object;
- (void)didRequestChangeReceiveAddressWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_ChangeReceiveAddress>)object;
- (void)didRequestAddCompanyWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_NotificationNoDisturbConfig>)object;
- (void)didRequestlogoutWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_Logout>)object;

#pragma mark - userData
- (void)didRequestMyQuestionListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_MyQuestionlist>)object;
- (void)didRequestMyCollectionTextBookWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_MyCollectiontextBook>)object;
- (void)didRequestSearchMyCollectionTextBookWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_SearchMyCollectiontextBook>)object;
- (void)didRequestMyBookmarkListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_MyBookMarkList>)object;
- (void)didRequestAllBuildTypeListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_MyHeadQuestion>)object;
- (void)didRequestDepartmentListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_DeleteMyCollectiontextBook>)object;
- (void)didRequestAllBuildLocationWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_DeleteMyBookmark>)object;
- (void)didRequestNavigationEndPointWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_ClearnMyBookmark>)object;
- (void)didRequestBuildCompanyListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_MyQuestionDetail>)object;
- (void)didRequestbuildSaleWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_SetaHaveReadQuestion>)object;



@property (nonatomic, strong)NSArray  * myCollectionTextbookArray;
@property (nonatomic, strong)NSArray * searchCollectionTextbookArray;
@property (nonatomic, strong)NSArray * myBookmarkArray;
@property (nonatomic, strong)NSArray * myHeadQuestionArray;
@property (nonatomic, strong)NSArray * myQuestionArray;
@property (nonatomic, strong)NSArray * myQuestionDetailArray;

@property (nonatomic, strong)NSDictionary * changeImageFileInfo;

@property (nonatomic, strong)NSMutableArray * companyList;
@property (nonatomic, strong)NSArray * buildList;
@property (nonatomic, strong)NSArray * departmentList;
@property (nonatomic, strong)NSArray *allBuildLocationList;
@property (nonatomic, strong)NSDictionary * navigationEndPoint;
@property (nonatomic, strong)NSMutableArray *buildCompantyList;
@property (nonatomic, strong)NSMutableArray   *buildSaleList;


@end

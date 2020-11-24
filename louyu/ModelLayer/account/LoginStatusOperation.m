//
//  LoginStatusOperation.m
//  Accountant
//
//  Created by aaa on 2017/2/28.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "LoginStatusOperation.h"
#import "HttpRequestManager.h"
#import "PathUtility.h"
@interface LoginStatusOperation ()

@property (nonatomic,weak) id<UserModule_LoginProtocol>          loginNotifiedObject;

@property (nonatomic,weak) UserModel                            *userModel;

@end

@implementation LoginStatusOperation

- (void)clearLoginUserInfo
{
    self.userModel.userID = 0;
    self.userModel.departId = 0;
    self.userModel.userName = @"";
    self.userModel.isLogin = NO;
    self.userModel.userNickName = @"";
    self.userModel.headImageUrl = @"";
    self.userModel.telephone = @"";
    self.userModel.wangYiToken = @"";
    self.userModel.notificationNoDisturb = 0;
    self.userModel.starCount = 0;
    self.userModel.flowerCount = 0;
    self.userModel.prizeCount = 0;
    self.userModel.validityTime = @"";
    self.userModel.gender = @"";
    self.userModel.birthday = @"";
    self.userModel.city = @"";
    self.userModel.receivePhoneNumber = @"";
    self.userModel.receiveAddress = @"";
    self.userModel.receiveName = @"";
    self.userModel.type = 0;
    
    self.userModel.sliceId = 0;
    self.userModel.dayNum = 0;
    self.userModel.weekNum = 0;
    self.userModel.MonthNum = 0;
    
    [self encodeUserInfo];
}

- (void)setCurrentUser:(UserModel *)user
{
    self.userModel = user;
}

- (void)didLoginWithUserName:(NSString *)userName andPassword:(NSString *)password withNotifiedObject:(id<UserModule_LoginProtocol>)object
{
//    self.userModel.userName = userName;
    self.loginNotifiedObject = object;
    [[HttpRequestManager sharedManager] requestLoginWithUserName:userName andPassword:password andProcessDelegate:self];
}

- (void)encodeUserInfo
{
    NSString *dataPath = [[PathUtility getDocumentPath] stringByAppendingPathComponent:@"user.data"];
    [NSKeyedArchiver archiveRootObject:self.userModel toFile:dataPath];
}

#pragma mark - request delegate
- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    NSLog(@"successInfo = %@", successInfo);
    self.userModel.userID = [[successInfo objectForKey:@"userId"] intValue];
    
    if ([[successInfo objectForKey:@"roleName"] class] == [NSNull class] || [successInfo objectForKey:@"roleName"] == nil || [[successInfo objectForKey:@"roleName"] isEqualToString:@""]) {
        self.userModel.userName = @"";
    }else{
        self.userModel.userName = [successInfo objectForKey:@"roleName"];
    }
    
    if ([[successInfo objectForKey:@"headImg"] class] == [NSNull class] || [successInfo objectForKey:@"headImg"] == nil || [[successInfo objectForKey:@"headImg"] isEqualToString:@""]) {
        self.userModel.headImageUrl = @"";
    }else{
        self.userModel.headImageUrl = [successInfo objectForKey:@"headImg"];
    }
    
    self.userModel.MonthNum = [[successInfo objectForKey:@"MonthNum"] intValue];
    self.userModel.dayNum = [[successInfo objectForKey:@"dayNum"] intValue];
    self.userModel.sliceId = [[successInfo objectForKey:@"sliceId"] intValue];
    self.userModel.weekNum = [[successInfo objectForKey:@"weekNum"] intValue];
    
    self.userModel.isLogin = YES;
    
    if (self.loginNotifiedObject != nil) {
        [self.loginNotifiedObject didUserLoginSuccessed];
    }
    
    [self encodeUserInfo];
}

- (void)didRequestFailed:(NSString *)failInfo
{
    if (self.loginNotifiedObject != nil) {
        [self.loginNotifiedObject didUserLoginFailed:failInfo];
    }
}

- (void)didRequestFailedWithInfo:(NSDictionary *)failedInfo
{
    if (self.loginNotifiedObject != nil) {
        [self.loginNotifiedObject didUserLoginFailed:[failedInfo objectForKey:kErrorMsg]];
    }
}

@end

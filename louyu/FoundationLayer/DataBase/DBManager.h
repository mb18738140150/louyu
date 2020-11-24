//
//  DBManager.h
//  Accountant
//
//  Created by aaa on 2017/2/27.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"

@interface DBManager : NSObject

+ (instancetype)sharedManager;

- (void)intialDB;

- (void)saveDownloadAudioInfo:(NSDictionary *)dic;

- (NSArray *)getDownloadAudios;

- (BOOL)deleteAllAudios;

- (BOOL)deleteAudioWith:(NSDictionary *)audioInfo;

- (NSArray *)getDownloadAudioList;
- (void)saveDownloadAudioListInfo:(NSDictionary *)dic;
- (BOOL)deleteAudioListWith:(NSDictionary *)audioInfo;
- (BOOL)deleteAllAudioList;

- (NSArray *)getDownloadAudioInfosWith:(NSDictionary *)infoDic;// 获取某个课文下全部音频


@end

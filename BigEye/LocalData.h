//
//  LocalData.h
//  CRWB
//
//  Created by CR-IOS on 16/3/8.
//  Copyright © 2016年 CR-IOS. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "UserInfoModel.h"
//#import "ContactsModel.h"
@interface LocalData : NSObject<NSCoding>

#pragma mark -- 用户信息

@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *userHeadImgUrl;
@property (nonatomic,strong) NSString *userIsLogin;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *position;
@property (nonatomic,strong) NSString *can_control;
@property (nonatomic,strong) NSString *projectAuthority;
@property (nonatomic,strong) NSString *onlineAuthority;
//@property (nonatomic,strong) companyModel *companyModel;
//@property (nonatomic,strong) ContactObjModel *userModel;



+ (id)  shareInstance;
- (void)setUserDataNil;
- (void)localDataSave;/*保存localData到pfile文件中*/
- (BOOL)initFromUserDefaults;


@end

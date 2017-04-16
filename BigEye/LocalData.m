//
//  LocalData.m
//  CRWB
//
//  Created by CR-IOS on 16/3/8.
//  Copyright © 2016年 CR-IOS. All rights reserved.
//

#import "LocalData.h"
//userId userHeadImgUrl userIsLogin
@implementation LocalData
+ (id)shareInstance{
    static LocalData *localData = nil;
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken,^{
        localData = [[self alloc] init];
    });
    return localData;
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_userId forKey:@"userId"];
    [aCoder encodeObject:_userHeadImgUrl forKey:@"userHeadImgUrl"];
    [aCoder encodeObject:_userIsLogin forKey:@"userIsLogin"];
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_position forKey:@"position"];
//    [aCoder encodeObject:_companyModel forKey:@"companyModel"];
//    [aCoder encodeObject:_userModel forKey:@"userModel"];
    [aCoder encodeObject:_projectAuthority forKey:@"projectAuthority"];//项目管理权限
    [aCoder encodeObject:_onlineAuthority forKey:@"onlineAuthority"]; //在线权限
    [aCoder encodeObject:_can_control forKey:@"can_control"]; //是否可控  1可控

}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.userId = [aDecoder decodeObjectForKey:@"userId"];
        self.userHeadImgUrl = [aDecoder decodeObjectForKey:@"userHeadImgUrl"];
        self.userIsLogin = [aDecoder decodeObjectForKey:@"userIsLogin"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.position = [aDecoder decodeObjectForKey:@"position"];
//        self.companyModel = [aDecoder decodeObjectForKey:@"companyModel"];
//        self.userModel = [aDecoder decodeObjectForKey:@"userModel"];
        self.projectAuthority = [aDecoder decodeObjectForKey:@"projectAuthority"];
        self.onlineAuthority = [aDecoder decodeObjectForKey:@"onlineAuthority"];
        self.can_control = [aDecoder decodeObjectForKey:@"can_control"];
    }
    return self;
}
- (void)setUserDataNil{
    self.userId = nil;
    self.userHeadImgUrl = nil;
    self.userIsLogin = nil;
    self.name = nil;
    self.position = nil;
//    self.companyModel = nil;
//    self.userModel = nil;
    self.projectAuthority = nil;
    self.onlineAuthority = nil;
    self.can_control = nil;
}
#pragma mark - 客户数据本地存储
- (void)localDataSave {
    NSData *userLocalData = [NSKeyedArchiver archivedDataWithRootObject:self];
    [[NSUserDefaults standardUserDefaults]setObject:userLocalData forKey:@"userLocalData"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
- (BOOL)initFromUserDefaults{

    NSData *localDataClientele = [[NSUserDefaults standardUserDefaults] objectForKey:@"userLocalData"];
    LocalData *localDataOld = nil;
    
    if(localDataClientele)
    {
        localDataOld=[NSKeyedUnarchiver unarchiveObjectWithData:localDataClientele];
    }
    else
    {
        NSLog(@"配置文件未找到key的值，初始化失败");
        return FALSE;
    }
    /* 用户信息 */
    if(localDataOld)
    {
        self.userId = localDataOld.userId;
        self.userHeadImgUrl = localDataOld.userHeadImgUrl;
        self.userIsLogin = localDataOld.userIsLogin;
        self.name = localDataOld.name;
        self.position = localDataOld.position;
//        self.companyModel = localDataOld.companyModel;
//        self.userModel = localDataOld.userModel;
        self.projectAuthority = localDataOld.projectAuthority;
        self.onlineAuthority = localDataOld.onlineAuthority;
        self.can_control = localDataOld.can_control;
    }else{
        NSLog(@"解析失败，初始化失败");
        return FALSE;
    }
    NSLog(@"LocalData 初始化成功");
    return TRUE;

}

@end

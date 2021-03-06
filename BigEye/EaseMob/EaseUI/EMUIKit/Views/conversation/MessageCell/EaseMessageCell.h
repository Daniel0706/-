/************************************************************
 *  * Hyphenate CONFIDENTIAL
 * __________________
 * Copyright (C) 2016 Hyphenate Inc. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of Hyphenate Inc.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Hyphenate Inc.
 */

#import <UIKit/UIKit.h>

#import "IModelChatCell.h"
#import "IMessageModel.h"
//#import "FMDB.h"

#import "EaseBubbleView.h"

#define kEMMessageImageSizeWidth 120
#define kEMMessageImageSizeHeight 120
#define kEMMessageLocationHeight 95
#define kEMMessageVoiceHeight 23

extern CGFloat const EaseMessageCellPadding;

typedef enum{
    EaseMessageCellEvenVideoBubbleTap,
    EaseMessageCellEventLocationBubbleTap,
    EaseMessageCellEventImageBubbleTap,
    EaseMessageCellEventAudioBubbleTap,
    EaseMessageCellEventFileBubbleTap,
    EaseMessageCellEventCustomBubbleTap,
}EaseMessageCellTapEventType;

@protocol EaseMessageCellDelegate;
@interface EaseMessageCell : UITableViewCell<IModelChatCell>
{
    UIButton *_statusButton;
    UIButton *_messageStatus;
//    UILabel *_hasRead;
    EaseBubbleView *_bubbleView;
    UIActivityIndicatorView *_activity;
    
    
    NSLayoutConstraint *_statusWidthConstraint;
}


//@property (nonatomic,strong) FMDatabase *dataBase;


@property (weak, nonatomic) id<EaseMessageCellDelegate> delegate;

@property (nonatomic, strong) UIActivityIndicatorView *activity;

@property (strong, nonatomic) UIImageView *avatarView;

@property (strong, nonatomic) UILabel *nameLabel;

@property (strong, nonatomic) UIButton *statusButton;

//@property (strong, nonatomic) UIButton *hasRead;
@property (strong, nonatomic) UIButton *messageStatus;


@property (strong, nonatomic) EaseBubbleView *bubbleView;

@property (strong, nonatomic) id<IMessageModel> model;

@property (strong, nonatomic) NSMutableArray *modelArray;
@property (nonatomic,assign) NSInteger reloadTag;

/*
 *  状态按钮尺寸
 */
@property (nonatomic) CGFloat statusSize UI_APPEARANCE_SELECTOR; //default 20;

/*
 *  加载尺寸
 */
@property (nonatomic) CGFloat activitySize UI_APPEARANCE_SELECTOR; //default 20;

/*
 *  聊天气泡的最大宽度
 */
@property (nonatomic) CGFloat messageStatusSize;  // default 20;
/*!
 @property
 @brief 气泡最大宽度
 */
@property (nonatomic) CGFloat bubbleMaxWidth UI_APPEARANCE_SELECTOR; //default 200;

@property (nonatomic) UIEdgeInsets bubbleMargin UI_APPEARANCE_SELECTOR; //default UIEdgeInsetsMake(8, 0, 8, 0);

@property (nonatomic) UIEdgeInsets leftBubbleMargin UI_APPEARANCE_SELECTOR; //default UIEdgeInsetsMake(8, 15, 8, 10);

@property (nonatomic) UIEdgeInsets rightBubbleMargin UI_APPEARANCE_SELECTOR; //default UIEdgeInsetsMake(8, 10, 8, 15);

/*
 *  发送者气泡图片
 */
@property (strong, nonatomic) UIImage *sendBubbleBackgroundImage UI_APPEARANCE_SELECTOR;

/*
 *  接收者气泡图片
 */
@property (strong, nonatomic) UIImage *recvBubbleBackgroundImage UI_APPEARANCE_SELECTOR;

/*
 *  消息显示字体
 */
@property (nonatomic) UIFont *messageTextFont UI_APPEARANCE_SELECTOR; //default [UIFont systemFontOfSize:15];

/*
 *  消息显示颜色
 */
@property (nonatomic) UIColor *messageTextColor UI_APPEARANCE_SELECTOR; //default [UIColor blackColor];

/*
 *  位置消息显示字体
 */
@property (nonatomic) UIFont *messageLocationFont UI_APPEARANCE_SELECTOR; //default [UIFont systemFontOfSize:12];

/*
 *  位置消息显示颜色
 */
@property (nonatomic) UIColor *messageLocationColor UI_APPEARANCE_SELECTOR; //default [UIColor whiteColor];

/*
 *  发送者语音消息播放图片
 */
@property (nonatomic) NSArray *sendMessageVoiceAnimationImages UI_APPEARANCE_SELECTOR;

/*
 *  接收者语音消息播放图片
 */
@property (nonatomic) NSArray *recvMessageVoiceAnimationImages UI_APPEARANCE_SELECTOR;

/*
 *  语音消息显示颜色
 */
@property (nonatomic) UIColor *messageVoiceDurationColor UI_APPEARANCE_SELECTOR; //default [UIColor grayColor];

/*
 *  语音消息显示字体
 */
@property (nonatomic) UIFont *messageVoiceDurationFont UI_APPEARANCE_SELECTOR; //default [UIFont systemFontOfSize:12];

/*
 *  文件消息名称显示字体
 */
@property (nonatomic) UIFont *messageFileNameFont UI_APPEARANCE_SELECTOR; //default [UIFont systemFontOfSize:13];

/*
 *  文件消息名称显示颜色
 */
@property (nonatomic) UIColor *messageFileNameColor UI_APPEARANCE_SELECTOR; //default [UIColor blackColor];

/*
 *  文件消息显示字体
 */
@property (nonatomic) UIFont *messageFileSizeFont UI_APPEARANCE_SELECTOR; //default [UIFont systemFontOfSize:11];

/*
 *  文件消息显示颜色
 */
@property (nonatomic) UIColor *messageFileSizeColor UI_APPEARANCE_SELECTOR; //default [UIColor grayColor];

/*
 *  @param  cell
 *  @param  
 *  @param  消息model
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                        model:(id<IMessageModel>)model;

/*
 *  
 *
 *  @param  消息model
 *
 *  @result
 */
+ (NSString *)cellIdentifierWithModel:(id<IMessageModel>)model;

/*
 *
 *
 *  @param  消息model
 *
 *  @result cell高度
 */
+ (CGFloat)cellHeightWithModel:(id<IMessageModel>)model;

@end

@protocol EaseMessageCellDelegate <NSObject>

@optional

/*
 *  消息点击回调
 *
 *  @param  消息model
 */
- (void)messageCellSelected:(id<IMessageModel>)model;

/*
 *  状态按钮点击回调
 *
 *  @param  消息model
 *  @param  当前cell
 */
- (void)statusButtonSelcted:(id<IMessageModel>)model withMessageCell:(EaseMessageCell*)messageCell;

/*
 *  头像点击回调
 *
 *  @param  消息model
 */
- (void)avatarViewSelcted:(id<IMessageModel>)model;

@end


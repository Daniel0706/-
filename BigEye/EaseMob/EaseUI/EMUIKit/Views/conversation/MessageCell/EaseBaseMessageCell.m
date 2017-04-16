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

#import "EaseBaseMessageCell.h"

#import "UIImageView+WebCache.h"
//#import "ChatModel.h"
@interface EaseBaseMessageCell()

@property (strong, nonatomic) UILabel *nameLabel;

@property (nonatomic) NSLayoutConstraint *avatarWidthConstraint;
@property (nonatomic) NSLayoutConstraint *nameHeightConstraint;

@property (nonatomic) NSLayoutConstraint *bubbleWithAvatarRightConstraint;
@property (nonatomic) NSLayoutConstraint *bubbleWithoutAvatarRightConstraint;

@property (nonatomic) NSLayoutConstraint *bubbleWithNameTopConstraint;
@property (nonatomic) NSLayoutConstraint *bubbleWithoutNameTopConstraint;
@property (nonatomic) NSLayoutConstraint *bubbleWithImageConstraint;

@end

@implementation EaseBaseMessageCell

@synthesize nameLabel = _nameLabel;

+ (void)initialize
{
    // UIAppearance Proxy Defaults
    EaseBaseMessageCell *cell = [self appearance];
    cell.avatarSize = 30;
    cell.avatarCornerRadius = 0;
    
    cell.messageNameColor = [UIColor grayColor];
    cell.messageNameFont = [UIFont systemFontOfSize:10];
    cell.messageNameHeight = 15;
//    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
//        cell.messageNameIsHidden = NO;
//    }
    
//    cell.bubbleMargin = UIEdgeInsetsMake(8, 15, 8, 10);
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                        model:(id<IMessageModel>)model
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier model:model];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.font = [UIFont systemFontOfSize:13];
        _nameLabel.textColor = RGB(51, 51, 51);
        [self.contentView addSubview:_nameLabel];
        
        [self configureLayoutConstraintsWithModel:model];
        
        if ([UIDevice currentDevice].systemVersion.floatValue == 7.0) {
            self.messageNameHeight = 15;
        }
        // 是否是当前登录者发送的消息  设置姓名是否显示
        if (model.isSender) {
            _nameLabel.hidden = YES;
        }else{
            _nameLabel.hidden = NO;
        }
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _bubbleView.backgroundImageView.image = self.model.isSender ? self.sendBubbleBackgroundImage : self.recvBubbleBackgroundImage;
    switch (self.model.bodyType) {
        case EMMessageBodyTypeText:
        {
        }
            break;
        case EMMessageBodyTypeImage:
        {
            CGSize retSize = self.model.thumbnailImageSize;
            if (retSize.width == 0 || retSize.height == 0) {
                retSize.width = kEMMessageImageSizeWidth;
                retSize.height = kEMMessageImageSizeHeight;
            }
            else if (retSize.width > retSize.height) {
                CGFloat height =  kEMMessageImageSizeWidth / retSize.width * retSize.height;
                retSize.height = height;
                retSize.width = kEMMessageImageSizeWidth;
            }
            else {
                CGFloat width = kEMMessageImageSizeHeight / retSize.height * retSize.width;
                retSize.width = width;
                retSize.height = kEMMessageImageSizeHeight;
            }
            [self removeConstraint:self.bubbleWithImageConstraint];
            
            CGFloat margin = [EaseMessageCell appearance].leftBubbleMargin.left + [EaseMessageCell appearance].leftBubbleMargin.right;
            self.bubbleWithImageConstraint = [NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:retSize.width + margin];
            
            [self addConstraint:self.bubbleWithImageConstraint];
        }
            break;
        case EMMessageBodyTypeLocation:
        {
        }
            break;
        case EMMessageBodyTypeVoice:
        {
        }
            break;
        case EMMessageBodyTypeVideo:
        {
        }
            break;
        case EMMessageBodyTypeFile:
        {
        }
            break;
        default:
            break;
    }
}

- (void)configureLayoutConstraintsWithModel:(id<IMessageModel>)model
{
    if (model.isSender) {
        [self configureSendLayoutConstraints];
    } else {
        [self configureRecvLayoutConstraints];
    }
}

- (void)configureSendLayoutConstraints
{
    //avatar view
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:EaseMessageCellPadding]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-EaseMessageCellPadding]];
    
    self.avatarWidthConstraint = [NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.avatarSize];
    [self addConstraint:self.avatarWidthConstraint];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.avatarView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    
    //name label
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.avatarView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-EaseMessageCellPadding]];
    
    self.nameHeightConstraint = [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.messageNameHeight];
    [self addConstraint:self.nameHeightConstraint];
    
    //bubble view
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.avatarView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-EaseMessageCellPadding]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.nameLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    
    //status button
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.messageStatus attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bubbleView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-EaseMessageCellPadding]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.statusButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bubbleView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-EaseMessageCellPadding]];
    // 同步附件
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.statusButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bubbleView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10]];
    //activity
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.activity attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bubbleView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-EaseMessageCellPadding]];
    
    //hasRead
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.hasRead attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bubbleView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-EaseMessageCellPadding]];
}

- (void)configureRecvLayoutConstraints
{
    //avatar view
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:EaseMessageCellPadding]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:EaseMessageCellPadding]];
    
    self.avatarWidthConstraint = [NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.avatarSize];
    [self addConstraint:self.avatarWidthConstraint];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.avatarView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    
    //name label
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:15]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.avatarView attribute:NSLayoutAttributeRight multiplier:1.0 constant:EaseMessageCellPadding]];
    
    self.nameHeightConstraint = [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.messageNameHeight];
    [self addConstraint:self.nameHeightConstraint];
    
    //bubble view
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.avatarView attribute:NSLayoutAttributeRight multiplier:1.0 constant:EaseMessageCellPadding]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.nameLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10]];}

#pragma mark - Update Constraint

- (void)_updateAvatarViewWidthConstraint
{
    if (self.avatarView) {
        [self removeConstraint:self.avatarWidthConstraint];
        
        self.avatarWidthConstraint = [NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:self.avatarSize];
        [self addConstraint:self.avatarWidthConstraint];
    }
}

- (void)_updateNameHeightConstraint
{
    if (_nameLabel) {
        [self removeConstraint:self.nameHeightConstraint];
        
        self.nameHeightConstraint = [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.messageNameHeight];
        [self addConstraint:self.nameHeightConstraint];
    }
}

#pragma mark - setter

- (void)setModel:(id<IMessageModel>)model
{
        [super setModel:model];
        
        if (model.avatarURLPath) {
            [self.avatarView sd_setImageWithURL:[NSURL URLWithString:model.avatarURLPath] placeholderImage:model.avatarImage];
        } else {
            self.avatarView.image = model.avatarImage;
        }
        _nameLabel.text = model.nickname;
        
        if (self.model.isSender) {
            if (model.bodyType == EMMessageBodyTypeFile) {
                if (model.message.chatType == EMChatTypeGroupChat) {
                    EMGroup *group = [EMGroup groupWithId:model.message.conversationId];
                    if (group.description.length) {
//                        NSDictionary *jsonDic = [NSString dictionaryWithJsonString:group.description];
//                        ChatModel *emGroupDic = [[ChatModel alloc] initWithDictionary:jsonDic error:nil];
                        // 仅添加在线任务群聊
//                        if ([emGroupDic.desc isEqualToString:@"1"]) {
//                            _statusButton.hidden = NO;
//                            EMFileMessageBody *fileMessageBody = (EMFileMessageBody *)model.message.body;
//                            BOOL isHaveSyn = [[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"%@%@",fileMessageBody.displayName,model.messageId]];
//                            if (isHaveSyn) {
//                                [_statusButton setTitle:@"已同步" forState:UIControlStateNormal];
//                                _statusButton.userInteractionEnabled = NO;
//                            }
//                        }
                    }
                }
            }
            switch (self.model.messageStatus) {
                case EMMessageStatusDelivering:
                {
                    //                _messageStatus.hidden = NO;
                    [_activity setHidden:NO];
                    [_activity startAnimating];
                }
                    break;
                case EMMessageStatusSuccessed:
                {
                    //                _messageStatus.hidden = NO;
                    [_activity stopAnimating];
                    if (self.model.isMessageRead) {
                        //                    _hasRead.hidden = NO;
                    }
                }
                    break;
                case EMMessageStatusPending:
                case EMMessageStatusFailed:
                {
                    [_activity stopAnimating];
                    [_activity setHidden:YES];
                    _messageStatus.hidden = NO;
                }
                    break;
                default:
                    break;
            }
        }
//    [super setModel:model];
//    
//    if (model.avatarURLPath) {
//        [self.avatarView sd_setImageWithURL:[NSURL URLWithString:model.avatarURLPath] placeholderImage:model.avatarImage];
//    } else {
//        self.avatarView.image = model.avatarImage;
//    }
//    _nameLabel.text = model.nickname;
//    
//    if (self.model.isSender) {
//        _hasRead.hidden = YES;
//        switch (self.model.messageStatus) {
//            case EMMessageStatusDelivering:
//            {
//                _statusButton.hidden = YES;
//                [_activity setHidden:NO];
//                [_activity startAnimating];
//            }
//                break;
//            case EMMessageStatusSuccessed:
//            {
//                _statusButton.hidden = YES;
//                [_activity stopAnimating];
//                if (self.model.isMessageRead) {
//                    _hasRead.hidden = NO;
//                }
//            }
//                break;
//            case EMMessageStatusPending:
//            case EMMessageStatusFailed:
//            {
//                [_activity stopAnimating];
//                [_activity setHidden:YES];
//                _statusButton.hidden = NO;
//            }
//                break;
//            default:
//                break;
//        }
//    }
}

- (void)setMessageNameFont:(UIFont *)messageNameFont
{
    _messageNameFont = messageNameFont;
    if (_nameLabel) {
        _nameLabel.font = [UIFont systemFontOfSize:13];
    }
}

- (void)setMessageNameColor:(UIColor *)messageNameColor
{
    _messageNameColor = messageNameColor;
    if (_nameLabel) {
        _nameLabel.textColor = RGB(51, 51, 51);;
    }
}

- (void)setMessageNameHeight:(CGFloat)messageNameHeight
{
    _messageNameHeight = messageNameHeight;
    if (_nameLabel) {
        [self _updateNameHeightConstraint];
    }
}

- (void)setAvatarSize:(CGFloat)avatarSize
{
    _avatarSize = avatarSize;
    if (self.avatarView) {
        [self _updateAvatarViewWidthConstraint];
    }
}

- (void)setAvatarCornerRadius:(CGFloat)avatarCornerRadius
{
    _avatarCornerRadius = avatarCornerRadius;
    if (self.avatarView){
        self.avatarView.layer.cornerRadius = avatarCornerRadius;
    }
}

//- (void)setMessageNameIsHidden:(BOOL)messageNameIsHidden
//{
//    _messageNameIsHidden = messageNameIsHidden;
//    if (_nameLabel) {
//        _nameLabel.hidden = messageNameIsHidden;
//    }
//}

#pragma mark - public

+ (CGFloat)cellHeightWithModel:(id<IMessageModel>)model
{
    EaseBaseMessageCell *cell = [self appearance];
    
    CGFloat minHeight = cell.avatarSize + EaseMessageCellPadding * 2;
    CGFloat height = cell.messageNameHeight;
    if ([UIDevice currentDevice].systemVersion.floatValue == 7.0) {
        height = 15;
    }
    height += - EaseMessageCellPadding + [EaseMessageCell cellHeightWithModel:model];
    height = height > minHeight ? height : minHeight;
//    return height;
    
    if (model.isSender) {
        return height + 25;
    } else {
        return height + 50;
    }
}

@end

//
//  UIImage+Helper.m
//  CRWB
//
//  Created by CR-IOS on 16/9/9.
//  Copyright © 2016年 CR-IOS. All rights reserved.
//

#import "UIImage+Helper.h"

@implementation UIImage (Helper)

+ (UIImage *) chooseFileImageWithFileName : (NSString *)nameStr{
    UIImage *fileImage;
    if ([nameStr isEqualToString:@"doc"] ) {
        fileImage = [UIImage imageNamed:@"word"];
    }else if ([nameStr isEqualToString:@"docx"]){
        fileImage = [UIImage imageNamed:@"word"];
    }else if ([nameStr isEqualToString:@"xlsx"]){
        fileImage = [UIImage imageNamed:@"xsl"];
    }else if ([nameStr isEqualToString:@"xls"]){
        fileImage = [UIImage imageNamed:@"xsl"];
    }else if ([nameStr isEqualToString:@"pdf"]){
        fileImage = [UIImage imageNamed:@"pdf"];
    }else if ([nameStr isEqualToString:@"jpg"] || [nameStr isEqualToString:@"jpeg"] || [nameStr isEqualToString:@"bmp"] || [nameStr isEqualToString:@"gif"] || [nameStr isEqualToString:@"png"]){
        fileImage = [UIImage imageNamed:@"img"];
    }else if ([nameStr isEqualToString:@"txt"] ||[nameStr isEqualToString:@"c"]||[nameStr isEqualToString:@"conf"]||[nameStr isEqualToString:@"cpp"]||[nameStr isEqualToString:@"h"]||[nameStr isEqualToString:@"htm"] || [nameStr isEqualToString:@"html"]||[nameStr isEqualToString:@"java"]||[nameStr isEqualToString:@"log"] || [nameStr isEqualToString:@"prop"] || [nameStr isEqualToString:@"rc"]||[nameStr isEqualToString:@"xml"]){
        fileImage = [UIImage imageNamed:@"text"];
    }else if ([nameStr isEqualToString:@"ppt"] || [nameStr isEqualToString:@"pptx"]){
        fileImage = [UIImage imageNamed:@"ppt"];
    }else if ([nameStr isEqualToString:@"avi"]||[nameStr isEqualToString:@"mp4"]||[nameStr isEqualToString:@"mpe"]||[nameStr isEqualToString:@"mpeg"]||[nameStr isEqualToString:@"mpg"]||[nameStr isEqualToString:@"mpg4"]||[nameStr isEqualToString:@"rmvb"]||[nameStr isEqualToString:@"sgp"]||[nameStr isEqualToString:@"vod"]||[nameStr isEqualToString:@"mkv"]||[nameStr isEqualToString:@"wmv"]){
        
        fileImage = [UIImage imageNamed:@"vedio"];
        
    }else if ([nameStr isEqualToString:@"dwg"]||[nameStr isEqualToString:@"dxf"]||[nameStr isEqualToString:@"dwt"]||[nameStr isEqualToString:@"dws"]){
        fileImage = [UIImage imageNamed:@"工程文件"];
    }else if ([nameStr isEqualToString:@"m3u"]||[nameStr isEqualToString:@"m4a"]||[nameStr isEqualToString:@"m4b"]||[nameStr isEqualToString:@"m4p"]||[nameStr isEqualToString:@"mp2"]||[nameStr isEqualToString:@"mp3"]||[nameStr isEqualToString:@"mpga"]||[nameStr isEqualToString:@"ogg"]||[nameStr isEqualToString:@"wav"]||[nameStr isEqualToString:@"wma"]){
        fileImage = [UIImage imageNamed:@"music"];
    }else{
        fileImage = [UIImage imageNamed:@"未知"];
    }

    return fileImage;
}
@end

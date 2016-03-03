//
//  PinYinForObjc.m
//  Search
//
//  Created by LYZ on 14-1-24.
//  Copyright (c) 2014年 LYZ. All rights reserved.
//

#import "PinYinForObjc.h"

@implementation PinYinForObjc

//+ (NSString*)chineseConvertToPinYin:(NSString*)chinese {
//    NSString *sourceText = chinese;
//   
//    
//    return outputPinyin;
//    
//    
//}
//
//+ (NSString*)chineseConvertToPinYinHead:(NSString *)chinese {
//   
//    NSMutableString *outputPinyin = [[NSMutableString alloc] init];
//    for (int i=0;i <chinese.length;i++) {
//        NSString *mainPinyinStrOfChar = [PinyinHelper getFirstHanyuPinyinStringWithChar:[chinese characterAtIndex:i] withHanyuPinyinOutputFormat:outputFormat];
//        if (nil!=mainPinyinStrOfChar) {
//            [outputPinyin appendString:[mainPinyinStrOfChar substringToIndex:1]];
//        } else {
//            break;
//        }
//    }
//    return outputPinyin;
//}

+(NSString *)firstCharacter:(NSString *)string
{
    NSMutableString *str = [NSMutableString stringWithString:string];
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pinyin = [str capitalizedString];

    return [pinyin substringToIndex:1];
}



@end

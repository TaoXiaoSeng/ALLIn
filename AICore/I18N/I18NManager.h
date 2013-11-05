//
//  I18NManager.h
//  testI18n
//
//  Created by xiaoseng on 10/21/13.
//  Copyright (c) 2013 xiaoseng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class I18NManager;

//例如这样访问字符串
#define I18NLocalString(str)             NSLocalizedStringFromTableInBundle(str, nil ,[I18NManager getBundle], str)

// 发送通知多语言环境变更通知
#define kNotificationAppLanguageDidChange       @"kNotificationAppLanguageDidChange"


typedef enum tagI18NLanguage
{
    I18N_BEGIN  = -1,
    I18N_cn     = 0,//简体中文
    I18N_tw,        //繁体中文
    I18N_en,        //英语
    I18N_fr,        //法语
    I18N_de,        //德语
    I18N_ja,        //
    I18N_nl,        //
    I18N_it,        //
    I18N_es,        //
    I18N_ko,        //
    I18N_pt,        //
    I18N_pt_PT,     //
    I18N_da,        //
    I18N_fi,        //
    I18N_nb,        //
    I18N_sv,        //
    I18N_ru,        //
    I18N_pl,        //
    I18N_tr,        //
    I18N_uk,        //
    I18N_ar,        //
    I18N_hr,        //
    I18N_cs,        //
    I18N_el,        //
    I18N_he,        //
    I18N_ro,        //
    I18N_sk,        //
    I18N_th,        //
    I18N_id,        //
    I18N_ms,        //
    I18N_en_GB,     //
    I18N_ca,        //
    I18N_hu,        //
    I18N_vi,        //
    I18N_END,
}I18NLanguage;



// 如果如果用户当前设置语言不支持，则暂时默认使用中文
static const I18NLanguage kDefaultI18NLanguage = I18N_cn;

@interface I18NManager : NSObject
{
    
}

/**
 *  获取当前语言的bundle对象
 *
 *  @return
 */
+ (NSBundle *)getBundle;

/**
 *  判断当前app是否支持某种语言
 *
 *  @param i18nLang 语言的枚举值
 *
 *  @return 支持返回YES，否则返回NO
 */
+ (BOOL)isLangSupport:(I18NLanguage)i18nLang;

/**
 *  设置app的语言环境
 *
 *  @param i18nLang
 */
+ (void)setAppLanguage:(I18NLanguage )language;

/**
 *  获取当前app的语言的枚举值
 *
 *  @return
 */
+ (I18NLanguage)getAppLanguage;


/**
 *  返回当前系统支持的语言的I18NLanguage的数组
 *
 *  @return
 */
+ (NSArray *)getAppSupportLanguages;

@end

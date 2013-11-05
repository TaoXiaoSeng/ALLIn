//
//  I18NManager.m
//  testI18n
//
//  Created by xiaoseng on 10/21/13.
//  Copyright (c) 2013 xiaoseng. All rights reserved.
//

#import "I18NManager.h"

static NSString* const  kDefaultLanguageName = @"zh-Hans";

static NSBundle* I18NBundle = nil;

@interface I18NManager ()
{
    
}
+ (void) setAppLanguageWithLangName:(NSString*)language;
@end

@implementation I18NManager

+ (BOOL)isLangSupport:(I18NLanguage)i18nLang
{
    NSDictionary *map = [self getSupportLangNameMap];
    if ([map objectForKey:@(i18nLang)]) {
        return YES;
    }
    return NO;
}

/**
 *  设置app的语言环境
 *
 *  @param i18nLang
 */
+ (void)setAppLanguage:(I18NLanguage )i18nLang
{
    NSString *langName = [self getLanguageName:i18nLang];
    if (!langName) {
#ifdef DEBUG
        NSLog(@"你设置的语言暂不支持");
#endif
        return ;
    }
    [self setAppLanguageWithLangName:langName];
    [self resetBundle];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationAppLanguageDidChange object:nil userInfo:@{@"I18NLanguage": @([self getAppLanguage])}];
}

+ (I18NLanguage)getAppLanguage
{
    NSString *langName = [self getCurrentAppLanguageName];
    if (!langName) {
        langName = [self getDefualtLanguageName];
    }
    
    __block I18NLanguage i18nLang = I18N_cn;
    NSDictionary *map = [self getLangNameMap];
    [map enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSString class]] && [obj isEqualToString:langName]) {
            i18nLang = [(NSNumber *)key intValue];
            *stop = YES;
        }
    }];
    
    return i18nLang;
}

+ (NSArray *)getAppSupportLanguages
{
    NSDictionary *map = [self getSupportLangNameMap];
    return map.allKeys;
}

+ (NSBundle *)getBundle
{
    if (!I18NBundle) {
        return [NSBundle mainBundle];
    }
    return I18NBundle;
    
}

#pragma mark - private Methods
+ (NSString *)getDefualtLanguageName
{
    NSString *langName = [self getLanguageName:kDefaultI18NLanguage];
    if (!langName) {
        langName = kDefaultLanguageName;  //实在没辙就用这个
#ifdef DEBUG
        NSLog(@"这是什么坑爹的行为啊，设置一个自己系统都不支持的语言作为预发语言？？？？？");
#endif
    }
    return langName;
}

+ (NSDictionary *)getLangNameMap
{
    static NSDictionary* langIdentiferMap = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!langIdentiferMap) {
            langIdentiferMap = @{@(I18N_cn): @"zh-Hans",
                                 @(I18N_tw): @"zh-Hant",
                                 @(I18N_en): @"en",
                                 @(I18N_fr): @"fr",
                                 @(I18N_de): @"de",
                                 @(I18N_ja): @"ja",
                                 @(I18N_nl): @"nl",
                                 @(I18N_it): @"it",
                                 @(I18N_es): @"es",
                                 @(I18N_ko): @"ko",
                                 @(I18N_pt_PT): @"pt_PT",
                                 @(I18N_da): @"da",
                                 @(I18N_fi): @"fi",
                                 @(I18N_nb): @"nb",
                                 @(I18N_sv): @"sv",
                                 @(I18N_ru): @"ru",
                                 @(I18N_pl): @"pl",
                                 @(I18N_tr): @"tr",
                                 @(I18N_uk): @"uk",
                                 @(I18N_ar): @"ar",
                                 @(I18N_hr): @"hr",
                                 @(I18N_cs): @"cs",
                                 @(I18N_el): @"el",
                                 @(I18N_he): @"he",
                                 @(I18N_ro): @"ro",
                                 @(I18N_sk): @"sk",
                                 @(I18N_th): @"th",
                                 @(I18N_id): @"id",
                                 @(I18N_ms): @"ms",
                                 @(I18N_en_GB): @"en_GB",
                                 @(I18N_ca): @"ca",
                                 @(I18N_hu): @"hu",
                                 @(I18N_vi): @"vi"};
            [langIdentiferMap retain];
        }
    });
    return langIdentiferMap;
}


+ (NSDictionary *)getSupportLangNameMap
{
    static NSDictionary* langIdentiferMap = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!langIdentiferMap) {
            NSArray *supportLangNames = [[NSBundle mainBundle] localizations];
            NSDictionary *allLangNameMap = [self getLangNameMap];
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            for (NSString *langName in supportLangNames) {
                [allLangNameMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                    if (langName && obj && [langName isEqualToString:obj]) {
                        [dic setObject:obj forKey:key];
                        *stop = YES;
                    }
                }];
            }
            langIdentiferMap = [dic retain];
        }
    });
    return langIdentiferMap;
}



/**
 *  获取相应语言枚举值相对应的语言名称，如果传入的I18NLanguage不支持，返回nil
 *
 *  @param i18nLang
 *
 *  @return
 */
+ (NSString *)getLanguageName:(I18NLanguage)i18nLang
{
    NSDictionary *map = [self getLangNameMap];
    NSString* langBundleName = [map objectForKey:@(i18nLang)];
    return langBundleName;
}


+ (void)resetBundle
{
    if (I18NBundle && I18NBundle != [NSBundle mainBundle]) {
        I18NBundle = nil;
    }
    
    NSBundle* bundle = nil;
    NSString *langBundlePath = [self getLanguageBundlePath];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if (langBundlePath && [fileManager fileExistsAtPath:langBundlePath]) {
        bundle = [NSBundle bundleWithPath:[self getLanguageBundlePath]];
    }
    
    if (bundle) {
        I18NBundle = bundle;
    }
    else {
        I18NBundle = [NSBundle mainBundle];
    }
}


+ (NSString *)getLanguageBundleName
{
    I18NLanguage i18nLang = [I18NManager getAppLanguage];
    
    NSDictionary *langIdentiferMap = [self getLangNameMap];
    __block NSString* langBundleName = [langIdentiferMap objectForKey:@(i18nLang)];
    if (!langBundleName) {
        NSDictionary *supportLangNameMap = [self getSupportLangNameMap];
        [supportLangNameMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            langBundleName = (NSString *)obj;
        }];
        //langBundleName = [supportLangNameMap objectForKey:@(I18N_cn)];
    }
    
    return langBundleName;
}

+ (NSString *)getLanguageBundlePath
{
    NSString *langBundleName = [NSString stringWithFormat:@"%@.lproj", [[self class] getLanguageBundleName]];
    NSString *bundlePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:langBundleName];
    return bundlePath;
}


+ (NSArray *)getAllLanguageNames
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //contains the device's supported language. The first one is the language configured in the system.
    NSArray* languages = [defaults objectForKey:@"AppleLanguages"];
    
    return languages;
}

/**
 *  自适应找到当前app支持最佳语言，理论上当前使用的语言应该位于数组的0索引的位置,如果不存在，则使用默认简体中文语言。
 *
 *  @return 语言名称
 */
+ (NSString *)getCurrentAppLanguageName
{
    NSString *langName = [self getBestAppLanguage];
    
    if (!langName) { // 还找不到就不正常了，选择默认的简体中文
        langName = [self getDefualtLanguageName];
    }
    
    return langName;
}

/**
 *  自适应找到当前app支持最佳语言，找不到返回nil
 *
 *  @return
 */
+ (NSString *)getBestAppLanguage
{
    NSArray* langNameArray = [self getAllLanguageNames];
    NSArray *localizationLanguage = [[NSBundle mainBundle] localizations];
    NSString *langName = nil;
    
    int i = 0;
    while (i < langNameArray.count) {
        NSString *langTemp = [langNameArray objectAtIndex:i];
        if (langTemp && [localizationLanguage containsObject:langTemp]) {
            langName = langTemp;
            break;
        }
        i++;
    }
    return langName;
}


/**
 *  黑魔法，通过这个可以影响app启动的时候语言的选择
 *
 *  @param language
 */
+ (void) setAppLanguageWithLangName:(NSString*)language {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defaults objectForKey:@"AppleLanguages"];
    
    NSMutableArray* newLanguagesOrder = [NSMutableArray arrayWithArray:languages];
    [newLanguagesOrder removeObject:language];
    [newLanguagesOrder insertObject:language atIndex:0];
    
    [defaults setObject:newLanguagesOrder forKey:@"AppleLanguages"];
    [defaults synchronize];
}
@end

//
//  FirstViewController.m
//  testI18N
//
//  Created by xiaoseng on 10/29/13.
//  Copyright (c) 2013 xiaoseng. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize label;
- (void)viewDidLoad
{

    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidChangeLanguage:) name:kNotificationAppLanguageDidChange object:nil];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)appDidChangeLanguage:(NSNotification *)ntf
{
    self.label.text = I18NLocalString(@"标题");
}

-(IBAction)clickButton:(id)sender
{
    static BOOL is = YES;
    if (is) {
        [I18NManager setAppLanguage:I18N_en];
        
    }else {
        [I18NManager setAppLanguage:I18N_cn];
    }
    is=!is;
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationAppLanguageDidChange object:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

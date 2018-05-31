//
//  RongCloudModule.m
//  UZApp
//
//  Created by xugang on 14/12/17.
//  Copyright (c) 2014年 APICloud. All rights reserved.
//

#import "ImKit.h"
#import <AudioToolbox/AudioToolbox.h>
#import <RongIMKit/RongIMKit.h>
#import "RIChatViewController.h"
#import "RongImUtls.h"

@interface ImKit()
    @property(nonatomic, strong) RongImUtls *rongimUtls;
    @end

@implementation ImKit
    
    @synthesize hasPendingOperation;
    
- (instancetype)initWithWebView:(UIWebView*)theWebView {
    NSLog(@"RongCloudLibPlugin initWithWebView");
#ifdef __CORDOVA_4_0_0
    self = [super init];
#else
    if ([super respondsToSelector:@selector(initWithWebView:)]) {
        self = [super initWithWebView:theWebView];
    } else {
        self = [super init];
    }
#endif
    return self;
}
    
- (instancetype)init {
    self = [super init];
    return self;
}
    
# pragma mark Public methods
    /**
     * initialize & connection
     */
    
    void recvFunc(NSString *content) {
        CDVPluginResult *pluginResult=nil;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:content];
        [pluginResult setKeepCallbackAsBool:true];
        [delegate sendPluginResult:pluginResult callbackId:cmd.callbackId];
    }
    
    void backFunc(NSString *content) {
        if (bcmd == NULL) {
            return;
        }
        CDVPluginResult *pluginResult=nil;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:content];
        [pluginResult setKeepCallbackAsBool:true];
        [delegate sendPluginResult:pluginResult callbackId:bcmd.callbackId];
        bcmd = NULL;
    }
    
- (void)Init:(CDVInvokedUrlCommand *)command
    {
        //1
        NSLog(@"%s", __FUNCTION__);
        delegate = self.commandDelegate;
        cmd = command;
        
        _rongimUtls = [[RongImUtls alloc] init];
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"RCConfig" ofType:@"plist"];
        if (plistPath != nil) {
            NSMutableDictionary *plistData = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
            NSString *appkey       = [plistData valueForKey:@"RONGC_APP_KEY"];
            [_rongimUtls init: appkey andSuccessFunc: recvFunc];
        }
    }
    
- (void)Connect:(CDVInvokedUrlCommand *)command {
    NSString *imtoken = [command argumentAtIndex:0 withDefault:nil];
    NSString *htoken = [command argumentAtIndex:1 withDefault:nil];
    NSString *userUrl = [command argumentAtIndex:2 withDefault:nil];
    [_rongimUtls connect:htoken andImToken:imtoken andGetUserUrl:userUrl success:^(NSString *content) {
        CDVPluginResult *pluginResult=nil;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:content];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
    
}
    

- (void)LaunchCustomer:(CDVInvokedUrlCommand *)command {
    bcmd = command;
    NSString *userId = [command argumentAtIndex:0 withDefault:nil];
    [_rongimUtls LaunchCustomer:userId success: backFunc];
}

@end

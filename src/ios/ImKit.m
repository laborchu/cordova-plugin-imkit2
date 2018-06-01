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
#import "RCDCustomerServiceViewController.h"

@interface ImKit()
@end

@implementation ImKit
    
@synthesize hasPendingOperation;
    
- (instancetype)initWithWebView:(UIWebView*)theWebView {
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

-(void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left {
    recvFunc(@"msg");
}

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
    
- (void)init:(CDVInvokedUrlCommand *)command{
    delegate = self.commandDelegate;
    cmd = command;
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"RCConfig" ofType:@"plist"];
    if (plistPath != nil) {
        NSMutableDictionary *plistData = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        NSString *appkey       = [plistData valueForKey:@"RONGC_APP_KEY"];
        [[RCIM sharedRCIM] initWithAppKey:appkey];
        [[RCIM sharedRCIM] setReceiveMessageDelegate:self];
        recvFunc(@"init");
    }
}
    
- (void)connect:(CDVInvokedUrlCommand *)command {
    NSString *imtoken = [command argumentAtIndex:0 withDefault:nil];
    [[RCIM sharedRCIM] connectWithToken:imtoken success:^(NSString *userId) {
    } error:^(RCConnectErrorCode status) {
    } tokenIncorrect:^{
    }];
}
    

- (void)launchCustomer:(CDVInvokedUrlCommand *)command {
    NSString *userId = [command argumentAtIndex:0 withDefault:nil];
    RCDCustomerServiceViewController *chat = [[RCDCustomerServiceViewController alloc] init];
    chat.conversationType = ConversationType_CUSTOMERSERVICE;
    chat.targetId = userId;
    chat.title = @"镜易购客服";
    [self.viewController.navigationController pushViewController:chat animated:YES];
}

@end

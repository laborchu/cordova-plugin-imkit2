//
//  RongCloudModule.h
//  UZApp
//
//  Created by xugang on 14/12/17.
//  Copyright (c) 2014年 APICloud. All rights reserved.
//

#import <Cordova/CDVPlugin.h>
#import <RongIMLib/RongIMLib.h>
#import <RongIMKit/RongIMKit.h>

id<CDVCommandDelegate> delegate;
CDVInvokedUrlCommand *cmd;
CDVInvokedUrlCommand *bcmd;
void recvFunc(NSString *content);
void backFunc(NSString *content);

@interface ImKit : CDVPlugin <RCIMClientReceiveMessageDelegate, RCConnectionStatusChangeDelegate, RCIMUserInfoDataSource,RCIMReceiveMessageDelegate>
    
    //@property(nonatomic, assign) id<CDVCommandDelegate> delegate;
    //@property(nonatomic, retain) CDVInvokedUrlCommand *cmd;
    
    
- (void)init:(CDVInvokedUrlCommand *)command;
- (void)connect:(CDVInvokedUrlCommand *)command;
- (void)launchCustomer:(CDVInvokedUrlCommand *)command;

@end

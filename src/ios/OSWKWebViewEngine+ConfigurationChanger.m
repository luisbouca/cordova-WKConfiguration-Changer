//
//  OSWKWebViewEngine+ConfigurationChanger.m
//  OpenWith Sample app
//
//  Created by Luis Bouça on 03/02/2022.
//

#import "OSWKWebViewEngine+ConfigurationChanger.h"

#import <objc/message.h>

#import "OSCustomSchemeHandler.h"
#import "OSLoggerProtocol.h"
#import <Cordova/NSDictionary+CordovaPreferences.h>

@implementation OSWKWebViewEngine (ConfigurationChanger)

- (WKWebViewConfiguration*) createConfigurationFromSettings:(NSDictionary*)settings{
    WKWebViewConfiguration *configuration = [super createConfigurationFromSettings:settings];
    
    NSString* localBaseUserAgent;
    NSString* userAgent;
    NSString* OS_URL_SCHEME_CC = @"outsystems";
    
    if ([self.commandDelegate.settings cordovaSettingForKey:@"OverrideUserAgent"] != nil) {
        localBaseUserAgent = [self.commandDelegate.settings cordovaSettingForKey:@"OverrideUserAgent"];
    } else {
        NSString* appendUserAgent = [self.commandDelegate.settings cordovaSettingForKey:@"AppendUserAgent"];
        if (appendUserAgent) {
            userAgent = [NSString stringWithFormat:@"%@ %@", localBaseUserAgent, appendUserAgent];
        } else {
            userAgent = localBaseUserAgent;
        }
    }
    
    NSString * defaultHostname = [self.commandDelegate.settings objectForKey:[@"DefaultHostname" lowercaseString]];
    
    OSCustomSchemeHandler * handler = [[OSCustomSchemeHandler alloc] init];
    
    NSString *enableRefererHeaderCustomScheme = [self.commandDelegate.settings objectForKey:[@"EnableRefererHeaderCustomScheme" lowercaseString]];
    [handler setReferrerHeaderEnabled: [enableRefererHeaderCustomScheme isEqualToString:@"true"]];
    [handler setReferrer:defaultHostname];
    
    
    if (@available(iOS 11.0, *)) {
        [configuration setURLSchemeHandler:handler forURLScheme:OS_URL_SCHEME_CC];
    } else {
        @throw ([NSException exceptionWithName:@"InvalidTarget" reason:@"The target iOS version is not supported" userInfo:nil]);
    }
    
    /**
     * There are two properties where the user-agent can be configured for a given WKWebView instance:
     * a) the applicationNameForUserAgent property of the WKWebViewConfiguration instance
     * b) the customUserAgent property of the WKWebView instance
     **/
    configuration.allowsInlineMediaPlayback = $allowsInlineMediaPlayback;
    configuration.mediaTypesRequiringUserActionForPlayback = $mediaTypesRequiringUserActionForPlayback;
    
    configuration.applicationNameForUserAgent = userAgent;
    
    return configuration;
}

@end

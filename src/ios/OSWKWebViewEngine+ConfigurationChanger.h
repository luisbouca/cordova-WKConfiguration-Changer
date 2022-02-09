//
//  OSWKWebViewEngine+ConfigurationChanger.h
//  OpenWith Sample app
//
//  Created by Luis Bouça on 03/02/2022.
//

#ifndef OSWKWebviewEngine_ConfigurationChanger_h
#define OSWKWebviewEngine_ConfigurationChanger_h
#import "OSWKWebViewEngine.h"

@interface OSWKWebViewEngine (ConfigurationChanger)

- (WKWebViewConfiguration*) createConfigurationFromSettings:(NSDictionary*)settings;

@end

#endif /* OSWKWebViewEngine_ConfigurationChanger_h */

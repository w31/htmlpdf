//
//  main.m
//  htmlpdf
//
//  Created by Wei on 12/21/13.
//  Copyright (c) 2013 Wei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "WebViewDelegate.h"

#define APP_NAME "htmlpdf"
#define APP_VERSION "0.1"

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        printf("%s %s\n", APP_NAME, APP_VERSION);

        [NSApplication sharedApplication];
        
        
        Options *options = [[Options alloc]initWithArgc:argc argv:argv];
        
        if ([options hasValidOptions] == NO) {
            printf("Usage: %s --url input --output output --media mediastyle\n", APP_NAME);
            return 1;
        }
        
        
        WebView *webView = [[WebView alloc] initWithFrame:NSMakeRect(0, 0, 1, 1)
                                                frameName:[NSString stringWithFormat:@"%sFrame", APP_NAME]
                                                groupName:[NSString stringWithFormat:@"%sGroup", APP_NAME]];
        
        NSWindow *window = [[NSWindow alloc] initWithContentRect:NSMakeRect(0, 0, 1, 1)
                                                       styleMask:NSBorderlessWindowMask
                                                         backing:NSBackingStoreNonretained defer:NO];
        [window setContentView:webView];
        
        
        WebPreferences *prefs = [WebPreferences standardPreferences];
        
        [prefs setAutosaves:NO];
        [prefs setLoadsImagesAutomatically:YES];
        [prefs setAllowsAnimatedImages:YES];
        [prefs setAllowsAnimatedImageLooping:NO];
        [prefs setJavaEnabled:NO];
        [prefs setPlugInsEnabled:NO];
        [prefs setJavaScriptEnabled:YES];
        [prefs setJavaScriptCanOpenWindowsAutomatically:NO];
        prefs.shouldPrintBackgrounds = NO;
        prefs.userStyleSheetEnabled = YES;
        
        
        WebViewDelegate *webViewDelegate = [[WebViewDelegate alloc] initWithOptions:options];
        [webView setFrameLoadDelegate:webViewDelegate];
        [webView setUIDelegate:webViewDelegate];
        [webView setApplicationNameForUserAgent:[NSString stringWithFormat:@"%s/%s", APP_NAME, APP_VERSION]];
        [webView setPreferences:prefs];
        [webView setMaintainsBackForwardList:NO];
        [webView setMediaStyle:options.media];
        
        NSURL *url = [NSURL fileURLWithPath:options.url];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        [[webView mainFrame] loadRequest:urlRequest];
        
        
        [[NSRunLoop currentRunLoop] run];
    }
    return 0;
}


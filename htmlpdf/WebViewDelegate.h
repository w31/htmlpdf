//
//  WebViewDelegate.h
//  htmlpdf
//
//  Created by Wei on 12/30/13.
//  Copyright (c) 2013 Wei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "Options.h"

@interface WebViewDelegate : NSObject
{
    Options *cmdOptions;
}

- (id)initWithOptions:(Options *)options;
- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame;

@end

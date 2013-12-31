//
//  WebViewDelegate.m
//  htmlpdf
//
//  Created by Wei on 12/30/13.
//  Copyright (c) 2013 Wei. All rights reserved.
//

#import "WebViewDelegate.h"

@implementation WebViewDelegate

- (id)initWithOptions:(Options *)options
{
    self = [super init];
    
    if (self) {
        cmdOptions = options;
    }
    
    return self;
}

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame
{
    NSMutableDictionary *sharedDict = [[NSPrintInfo sharedPrintInfo] dictionary];
    NSMutableDictionary *printInfoDict = [NSMutableDictionary dictionaryWithDictionary:sharedDict];
    [printInfoDict setObject:NSPrintSaveJob forKey:NSPrintJobDisposition];
    [printInfoDict setObject:cmdOptions.output forKey:NSPrintSavePath];
    
    NSPrintInfo *printInfo = [[NSPrintInfo alloc] initWithDictionary:printInfoDict];
    [printInfo setHorizontallyCentered:YES];
    [printInfo setVerticallyCentered:YES];
    printInfo.horizontalPagination = NSAutoPagination;
    printInfo.verticalPagination = NSAutoPagination;
    
    printInfo.paperSize = NSMakeSize(612, 792); // US Letter
    printInfo.orientation = NSPaperOrientationPortrait;
    [printInfo setTopMargin:cmdOptions.topMargin];
    [printInfo setBottomMargin:cmdOptions.topMargin];
    [printInfo setLeftMargin:cmdOptions.leftMargin];
    [printInfo setRightMargin:cmdOptions.leftMargin];
    
    NSPrintOperation *printOp = [NSPrintOperation printOperationWithView:sender.mainFrame.frameView.documentView printInfo:printInfo];
    [printOp setShowsPrintPanel:NO];
    [printOp setShowsProgressPanel:NO];
    [printOp runOperation];
    
    [[NSApplication sharedApplication] terminate:0];
}

@end

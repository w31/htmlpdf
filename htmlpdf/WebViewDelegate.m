//
//  WebViewDelegate.m
//  htmlpdf
//
//  Created by Wei on 12/30/13.
//  Copyright (c) 2013 Wei. All rights reserved.
//

#import "WebViewDelegate.h"

@interface WebViewDelegate()
{
    NSString *documentTitle;
    int pageNumber;
}
@end

@implementation WebViewDelegate

- (id)initWithOptions:(Options *)options
{
    self = [super init];
    
    if (self) {
        cmdOptions = options;
    }
    
    return self;
}

#pragma mark - WebFrameLoadDelegate

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame
{
    documentTitle = [sender stringByEvaluatingJavaScriptFromString:@"document.title"];
    pageNumber = 0;

    NSMutableDictionary *sharedDict = [[NSPrintInfo sharedPrintInfo] dictionary];
    NSMutableDictionary *printInfoDict = [NSMutableDictionary dictionaryWithDictionary:sharedDict];
    [printInfoDict setObject:NSPrintSaveJob forKey:NSPrintJobDisposition];
    [printInfoDict setObject:[NSURL URLWithString:cmdOptions.output] forKey:NSPrintJobSavingURL];
    [printInfoDict setObject:@YES forKey:NSPrintHeaderAndFooter];
    
    NSPrintInfo *printInfo = [[NSPrintInfo alloc] initWithDictionary:printInfoDict];
    [printInfo setHorizontallyCentered:YES];
    [printInfo setVerticallyCentered:YES];
    printInfo.horizontalPagination = NSAutoPagination;
    printInfo.verticalPagination = NSAutoPagination;
    
    printInfo.paperSize = cmdOptions.paperSize;
    printInfo.orientation = NSPaperOrientationPortrait;
    printInfo.topMargin = 0;
    printInfo.bottomMargin = 0;
    [printInfo setLeftMargin:cmdOptions.leftMargin];
    [printInfo setRightMargin:cmdOptions.leftMargin];
    
    NSPrintOperation *printOp = [NSPrintOperation printOperationWithView:sender.mainFrame.frameView.documentView printInfo:printInfo];
    [printOp setShowsPrintPanel:NO];
    [printOp setShowsProgressPanel:NO];
    [printOp runOperation];
    
    [[NSApplication sharedApplication] terminate:0];
}

#pragma mark - WebUIDelegate

- (float)webViewHeaderHeight:(WebView *)sender
{
    return cmdOptions.topMargin;
}

- (float)webViewFooterHeight:(WebView *)sender
{
    return cmdOptions.topMargin;
}

- (void)webView:(WebView *)sender drawHeaderInRect:(NSRect)rect
{
    if (!cmdOptions.printTitle) {
        return;
    }


    pageNumber++;


    WebPreferences *prefs = [sender preferences];
    NSFont *font = [NSFont fontWithName:[prefs sansSerifFontFamily] size:8];

    NSColor *color = [NSColor darkGrayColor];
    
    NSDictionary *attributes = @{ NSFontAttributeName: font, NSForegroundColorAttributeName: color };


    NSSize titleSize = [documentTitle sizeWithAttributes:attributes];
    NSPoint titleOrigin;
    titleOrigin.x = rect.origin.x;
    titleOrigin.y = rect.origin.y + (rect.size.height * 0.8 - titleSize.height);
    
    [documentTitle drawAtPoint:titleOrigin withAttributes:attributes];
    

    NSString *pageString = [NSString stringWithFormat:@"Page %d", pageNumber];

    NSSize pageStringSize = [pageString sizeWithAttributes:attributes];
    NSPoint pageStringOrigin;
    pageStringOrigin.x = rect.origin.x + (rect.size.width - pageStringSize.width);
    pageStringOrigin.y = rect.origin.y + (rect.size.height * 0.8 - pageStringSize.height);
    
    [pageString drawAtPoint:pageStringOrigin withAttributes:attributes];
}

@end

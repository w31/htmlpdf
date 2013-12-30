//
//  Options.m
//  htmlpdf
//
//  Created by Wei on 12/30/13.
//  Copyright (c) 2013 Wei. All rights reserved.
//

#import <unistd.h>
#import "Options.h"

@implementation Options

@synthesize url = _url;
@synthesize output = _output;
@synthesize topMargin = _topMargin;
@synthesize leftMargin = _leftMargin;

- (id)initWithArgc:(int)argc argv:(const char **)argv
{
    _topMargin = _leftMargin = 72.0;
    
    int c;
    while ((c = getopt(argc, argv, "i:o:")) != -1) {
        switch (c) {
            case 'i':
                _url = [[NSString alloc] initWithCString:optarg encoding:NSASCIIStringEncoding];
                break;
            case 'o':
                _output = [[NSString alloc] initWithCString:optarg encoding:NSASCIIStringEncoding];
                break;
                
            default:
                break;
        }
    }
    
    return self;
}

- (BOOL)hasValidOptions
{
    if (_url == nil) {
        return NO;
    }
    
    if (_output == nil) {
        return NO;
    }
    
    return YES;
}

@end
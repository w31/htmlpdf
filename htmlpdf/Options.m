//
//  Options.m
//  htmlpdf
//
//  Created by Wei on 12/30/13.
//  Copyright (c) 2013 Wei. All rights reserved.
//

#import <getopt.h>
#import "Options.h"

@implementation Options

@synthesize url = _url;
@synthesize output = _output;
@synthesize media = _media;
@synthesize topMargin = _topMargin;
@synthesize leftMargin = _leftMargin;

- (id)initWithArgc:(int)argc argv:(const char **)argv
{
    _media = @"print";
    _topMargin = _leftMargin = 72.0;
    
    static struct option longopts[] =
    {
        { "url", required_argument, NULL, 'i' },
        { "output", required_argument, NULL, 'o' },
        { "media", required_argument, NULL, 'm' },
        { NULL, 0, NULL, 0 }
    };
    int c;

    while ((c = getopt_long(argc, argv, "i:o:m:", longopts, NULL)) != -1) {
        switch (c) {
            case 'i':
                _url = [[NSString alloc] initWithCString:optarg encoding:NSASCIIStringEncoding];
                break;
            case 'o':
                _output = [[NSString alloc] initWithCString:optarg encoding:NSASCIIStringEncoding];
                break;
            case 'm':
                _media = [[NSString alloc] initWithCString:optarg encoding:NSASCIIStringEncoding];
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

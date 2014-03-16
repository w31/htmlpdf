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
@synthesize paperSize = _paperSize;
@synthesize printTitle = _printTitle;

- (id)initWithArgc:(int)argc argv:(const char **)argv
{
    NSDictionary *paperSizes = [NSDictionary dictionaryWithObjectsAndKeys:
                                NSStringFromSize(NSMakeSize(597, 842)), @"a4",
                                NSStringFromSize(NSMakeSize(612, 792)), @"letter",
                                nil];

    _media = @"print";
    _paperSize = NSSizeFromString([paperSizes objectForKey:@"letter"]);
    _topMargin = _leftMargin = 72.0;
    _printTitle = NO;
    
    static struct option longopts[] =
    {
        { "url", required_argument, NULL, 'i' },
        { "output", required_argument, NULL, 'o' },
        { "media", required_argument, NULL, 'm' },
        { "paper", required_argument, NULL, 'p' },
        { "title", no_argument, NULL, 't' },
        { NULL, 0, NULL, 0 }
    };
    int c;

    NSString *paperSizeString;

    while ((c = getopt_long(argc, argv, "i:o:m:p:", longopts, NULL)) != -1) {
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
            case 'p':
                paperSizeString = [paperSizes objectForKey:[NSString stringWithUTF8String:optarg]];
                if (paperSizeString != nil) {
                    _paperSize = NSSizeFromString(paperSizeString);
                }
                break;
            case 't':
                _printTitle = YES;
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

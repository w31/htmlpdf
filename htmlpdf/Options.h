//
//  Options.h
//  htmlpdf
//
//  Created by Wei on 12/30/13.
//  Copyright (c) 2013 Wei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Options : NSObject

@property(readonly) NSString *url;
@property(readonly) NSString *output;
@property(readonly) NSString *media;
@property(readonly) CGFloat topMargin;
@property(readonly) CGFloat leftMargin;
@property(readonly) NSSize paperSize;

- (id)initWithArgc:(int)argc argv:(const char **)argv;
- (BOOL)hasValidOptions;

@end

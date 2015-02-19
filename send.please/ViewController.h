//
//  ViewController.h
//  send.please
//
//  Created by Aaron Friedman on 2/18/15.
//  Copyright (c) 2015 Aaron Friedman. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef enum {
    spLinkTypeMailto,
    spLinkTypeGmail
} spLinkType;

@interface ViewController : NSViewController <NSTextFieldDelegate, NSTextViewDelegate>

@property (strong) IBOutlet NSTokenField *toField;
@property (strong) IBOutlet NSTokenField *ccField;
@property (strong) IBOutlet NSTokenField *bccField;
@property (strong) IBOutlet NSTextField *subjectField;
@property (strong) IBOutlet NSTextView *bodyTextView;
@property (strong) IBOutlet NSTextField *linkPreviewField;

@property (strong) IBOutlet NSMatrix *linkTypeControl;

- (IBAction)tcopyButtonAction:(id)sender;
- (IBAction)linkTypeMatrixAction:(id)sender;

@end


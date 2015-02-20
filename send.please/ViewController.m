//
//  ViewController.m
//  send.please
//
//  Created by Aaron Friedman on 2/18/15.
//  Copyright (c) 2015 Aaron Friedman. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Extras.h"

@implementation ViewController

@synthesize toField = _toField;
@synthesize ccField = _ccField;
@synthesize bccField = _bccField;
@synthesize subjectField = _subjectField;
@synthesize bodyTextView = _bodyTextView;
@synthesize linkPreviewField = _linkPreviewField;
@synthesize linkTypeControl = _linkTypeControl;

- (void)tcopyButtonAction:(id)sender {
    [[NSPasteboard generalPasteboard] clearContents];
    [[NSPasteboard generalPasteboard] setString:_linkPreviewField.stringValue forType:NSStringPboardType];
}

# pragma mark helper methods

- (void)previewLinkForCurrentValues {
    spLinkType type = spLinkTypeMailto;
    if (_linkTypeControl.selectedRow == 1) type = spLinkTypeGmail;
    
    _linkPreviewField.stringValue = [self linkOfType:type to:_toField.objectValue cc:_ccField.objectValue bcc:_bccField.objectValue withSubject:_subjectField.stringValue andBody:_bodyTextView.textStorage.string];
}

- (NSString *)linkOfType:(spLinkType)type to:(NSArray *)toAddresses cc:(NSArray *)ccAddresses bcc:(NSArray *)bccAddresses withSubject:(NSString *)subject andBody:(NSString *)body {
    
    if (!toAddresses) toAddresses = @[];
    if (!ccAddresses) ccAddresses = @[];
    if (!bccAddresses) bccAddresses = @[];
    
    switch (type) {
        case spLinkTypeMailto:
            return [self mailtoLinkTo:toAddresses cc:ccAddresses bcc:bccAddresses withSubject:subject andBody:body];
        
        case spLinkTypeGmail:
            return [self gmailLinkTo:toAddresses cc:ccAddresses bcc:bccAddresses withSubject:subject andBody:body];
        default:
            break;
    }
}

- (NSString *)mailtoLinkTo:(NSArray *)toAddresses cc:(NSArray *)ccAddresses bcc:(NSArray *)bccAddresses withSubject:(NSString *)subject andBody:(NSString *)body  {
    
    NSMutableString *mailtoLink = [[NSMutableString alloc] initWithString:@"mailto:"];
    if (toAddresses.count) [mailtoLink appendString:[toAddresses componentsJoinedByString:@","]];
    if (ccAddresses.count) [mailtoLink appendString:[NSString stringWithFormat:@"?cc=%@", [ccAddresses componentsJoinedByString:@"," ]]];
    if (bccAddresses.count) [mailtoLink appendString:[NSString stringWithFormat:@"?bcc=%@", [bccAddresses componentsJoinedByString:@"," ]]];
    
    if (subject.length) [mailtoLink appendString:[NSString stringWithFormat:@"?subject=%@", [subject urlencode]]];
    if (body.length) [mailtoLink appendString:[NSString stringWithFormat:@"&body=%@", [body urlencode]]];
    
    return mailtoLink;
}

- (NSString *)gmailLinkTo:(NSArray *)toAddresses cc:(NSArray *)ccAddresses bcc:(NSArray *)bccAddresses withSubject:(NSString *)subject andBody:(NSString *)body  {
    
    NSMutableString *gmailLink = [[NSMutableString alloc] initWithString:@"https://mail.google.com/mail/?view=cm&fs=1"];
    if (toAddresses.count) [gmailLink appendString:[NSString stringWithFormat:@"&to=%@", [toAddresses componentsJoinedByString:@","]]];
    if (ccAddresses.count) [gmailLink appendString:[NSString stringWithFormat:@"&cc=%@", [ccAddresses componentsJoinedByString:@"," ]]];
    if (bccAddresses.count) [gmailLink appendString:[NSString stringWithFormat:@"&bcc=%@", [bccAddresses componentsJoinedByString:@"," ]]];
    
    if (subject.length) [gmailLink appendString:[NSString stringWithFormat:@"&su=%@", [subject urlencode]]];
    if (body.length) [gmailLink appendString:[NSString stringWithFormat:@"&body=%@", [body urlencode]]];
    
    return gmailLink;
}

# pragma mark interface actions

- (IBAction)linkTypeMatrixAction:(id)sender {
    [self previewLinkForCurrentValues];
}

- (void)controlTextDidChange:(NSNotification *)notification {
    [self previewLinkForCurrentValues];
}

- (void)textDidChange:(NSNotification *)notification {
    [self previewLinkForCurrentValues];
}

# pragma mark lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_async(dispatch_get_current_queue(), ^{
        [self.toField becomeFirstResponder];
        [self.bodyTextView setFont:[NSFont systemFontOfSize:13]];
        [self previewLinkForCurrentValues];
    });
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}

@end

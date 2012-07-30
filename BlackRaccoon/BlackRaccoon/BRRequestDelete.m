//----------
//
//				BRRequestDelete.m
//
// filename:	BRRequestDelete.m
//
// author:		Created by Valentin Radu on 8/23/11.
//              Copyright 2011 Valentin Radu. All rights reserved.
//
//              Modified and/or redesigned by Lloyd Sargent to be ARC compliant.
//              Copyright 2012 Lloyd Sargent. All rights reserved.
//
// created:		Jul 04, 2012
//
// description:	
//
// notes:		none
//
// revisions:	
//
// license:     Permission is hereby granted, free of charge, to any person obtaining a copy
//              of this software and associated documentation files (the "Software"), to deal
//              in the Software without restriction, including without limitation the rights
//              to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//              copies of the Software, and to permit persons to whom the Software is
//              furnished to do so, subject to the following conditions:
//
//              The above copyright notice and this permission notice shall be included in
//              all copies or substantial portions of the Software.
//
//              THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//              IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//              FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//              AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//              LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//              OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//              THE SOFTWARE.
//



//---------- pragmas



//---------- include files
#import "BRRequestDelete.h"



//---------- enumerated data types



//---------- typedefs



//---------- definitions



//---------- structs



//---------- external functions



//---------- external variables



//---------- global functions



//---------- local functions



//---------- global variables



//---------- local variables



//---------- protocols



//---------- classes

@implementation BRRequestDelete

+ (BRRequestDelete *) initWithDelegate: (id) inDelegate
{
    BRRequestDelete *deleteFileDir = [[BRRequestDelete alloc] init];
    if (deleteFileDir)
        deleteFileDir.delegate = inDelegate;
    
    return deleteFileDir;
}

- (BRRequestTypes) type 
{
    return kBRDeleteRequest;
}

-(NSString *) path 
{
    NSString * lastCharacter = [path substringFromIndex:[path length] - 1];
    isDirectory = ([lastCharacter isEqualToString:@"/"]);
    
    if (!isDirectory) 
        return [super path];
    
    NSString * directoryPath = [super path];
    if (![directoryPath isEqualToString:@""]) 
    {
        directoryPath = [directoryPath stringByAppendingString:@"/"];
    }
    
    return directoryPath;
}

-(void) start
{
    SInt32 errorcode;
    
    if (self.hostname==nil) 
    {
        InfoLog(@"The host name is nil!");
        self.error = [[BRRequestError alloc] init];
        self.error.errorCode = kBRFTPClientHostnameIsNil;
        [self.delegate requestFailed:self];
        return;
    }
    
    if (CFURLDestroyResource(( __bridge CFURLRef) self.fullURLWithEscape, &errorcode))
    {
        //----- successful
        [self.delegate requestCompleted:self];
        [self destroy];
    }
    
    else 
    {
        //----- unsuccessful        
        self.error = [[BRRequestError alloc] init];
        self.error.errorCode = kBRFTPClientCantDeleteFileOrDirectory;
        [self.delegate requestFailed:self];
        [self destroy];
    }


}

-(void) destroy
{
    [super destroy];  
}

@end

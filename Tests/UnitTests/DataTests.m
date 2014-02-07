//
//  DataTests.m
//
//  Created by Nick Lockwood on 12/01/2012.
//  Copyright (c) 2012 Charcoal Design. All rights reserved.
//

#import "DataTests.h"
#import "Base64.h"


@implementation DataTests

- (void)testOutputEqualsInput
{
    //set up data
    NSString *inputString = @"Hello World!";
    NSData *inputData = [inputString dataUsingEncoding:NSUTF8StringEncoding];
    
    //encode
    NSString *encodedString = [inputData base64EncodedString];
    NSAssert([encodedString isEqualToString:@"SGVsbG8gV29ybGQh"], @"OutputEqualsInput test failed");
    
    //decode
    NSData *outputData = [NSData dataWithBase64EncodedString:encodedString];
    NSString *outputString = [[NSString alloc] initWithData:outputData encoding:NSUTF8StringEncoding]; 
    NSAssert([outputString isEqualToString:inputString], @"OutputEqualsInput test failed");
}

- (void)testWrappedInput
{
    NSUInteger wrapWidth = 8; // must be multiple of 4
    
    //set up data
    NSString *inputString = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque ac quam non ipsum vestibulum porta ac id ipsum. Morbi sed enim purus. Fusce elementum dui sed nisi tincidunt feugiat interdum felis malesuada. Sed ipsum enim, mollis id adipiscing eu, eleifend eget neque. Nulla quis nunc a nunc pellentesque adipiscing nec non leo. Morbi ut nisi sem, in cursus erat. Praesent eu nibh justo, nec suscipit nisl. Suspendisse eget elit tellus, at rhoncus urna. Quisque imperdiet lobortis sagittis. Duis congue venenatis faucibus. Sed fermentum, ligula venenatis molestie mattis, sem justo ultrices turpis, mattis condimentum quam nunc eu purus. Nulla facilisi. Donec sodales nulla sed diam iaculis quis suscipit quam rhoncus. Nam tincidunt dui sit amet tortor posuere non interdum felis venenatis. In sollicitudin cursus felis vitae convallis. Etiam justo elit, vestibulum sit amet fringilla vel, vestibulum et ante.";
    
    NSData *inputData = [inputString dataUsingEncoding:NSUTF8StringEncoding];
    
    //encode
    NSString *encodedString = [inputData base64EncodedStringWithWrapWidth:wrapWidth];
    
    //wrap width
    NSArray *lines = [encodedString componentsSeparatedByString:@"\r\n"];
    NSAssert([[lines valueForKeyPath:@"@max.length"] unsignedIntegerValue] == wrapWidth, @"WrappedInput test failed");
    
    //decode
    NSData *outputData = [NSData dataWithBase64EncodedString:encodedString];
    NSString *outputString = [[NSString alloc] initWithData:outputData encoding:NSUTF8StringEncoding]; 
    NSAssert([outputString isEqualToString:inputString], @"WrappedInput test failed");
}

- (void)testZeroWrapWidth
{
    //set up data
    NSString *inputString = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit.";
    NSData *inputData = [inputString dataUsingEncoding:NSUTF8StringEncoding];
    
    //encode
    NSString *encodedString = [inputData base64EncodedStringWithWrapWidth:0];
    
    //decode
    NSData *outputData = [NSData dataWithBase64EncodedString:encodedString];
    NSString *outputString = [[NSString alloc] initWithData:outputData encoding:NSUTF8StringEncoding];
    NSAssert([outputString isEqualToString:inputString], @"WrappedInput test failed");
}

- (void)testNilInput
{
    NSData *data = [NSData dataWithBase64EncodedString:nil];
    NSAssert(data == nil, @"NilInput test failed");
}

- (void)testZeroLengthInput
{
    NSData *data = [NSData dataWithBase64EncodedString:@""];
    NSAssert(data == nil, @"ZeroLengthInput test failed");
    
    NSString *output = [[NSMutableData data] base64EncodedString];
    NSAssert(output == nil, @"ZeroLengthInput test failed");
}

- (void)testInvalidInput
{
    NSData *data = [NSData dataWithBase64EncodedString:@"!!!!!!"];
    NSAssert(data == nil, @"InvalidInput test failed");
}

- (void)testShortInput
{
    NSString *string = [[@"" dataUsingEncoding:NSUTF8StringEncoding] base64EncodedString];
    NSAssert(string == nil, @"InvalidInput test failed");
    
    string = [[@"A" dataUsingEncoding:NSUTF8StringEncoding] base64EncodedString];
    NSAssert([string isEqualToString:@"QQ=="], @"InvalidInput test failed");
    
    string = [[@"AB" dataUsingEncoding:NSUTF8StringEncoding] base64EncodedString];
    NSAssert([string isEqualToString:@"QUI="], @"InvalidInput test failed");
}

- (void)testEdgeCase1
{
    //set up data (11 chars)
    NSString *inputString = @"Hello World";
    NSData *inputData = [inputString dataUsingEncoding:NSUTF8StringEncoding];
    
    //encode
    NSString *encodedString = [inputData base64EncodedString];
    NSAssert([encodedString isEqualToString:@"SGVsbG8gV29ybGQ="], @"EdgeCase1 test failed");
    
    //decode
    NSData *outputData = [NSData dataWithBase64EncodedString:encodedString];
    NSString *outputString = [[NSString alloc] initWithData:outputData encoding:NSUTF8StringEncoding]; 
    NSAssert([outputString isEqualToString:inputString], @"EdgeCase1 test failed");
}

- (void)testEdgeCase2
{
    //set up data (10 chars)
    NSString *inputString = @"Hello Worl";
    NSData *inputData = [inputString dataUsingEncoding:NSUTF8StringEncoding];
    
    //encode
    NSString *encodedString = [inputData base64EncodedString];
    NSAssert([encodedString isEqualToString:@"SGVsbG8gV29ybA=="], @"EdgeCase2 test failed");
    
    //decode
    NSData *outputData = [NSData dataWithBase64EncodedString:encodedString];
    NSString *outputString = [[NSString alloc] initWithData:outputData encoding:NSUTF8StringEncoding]; 
    NSAssert([outputString isEqualToString:inputString], @"EdgeCase2 test failed");
}

- (void)testEdgeCase3
{
    //set up data (10 chars)
    NSString *inputString = @"VEVTVCBCSUM=";
    NSString *outputString = [NSString stringWithBase64EncodedString:inputString];
    NSAssert([outputString isEqualToString:@"TEST BIC"], @"EdgeCase3 test failed");
}


@end

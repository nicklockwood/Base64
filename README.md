NOTE: As of iOS 7 and Mac OS 10.9, this library is not longer needed
----------------------------------------------------------------------

In the iOS 7 and Mac OS 10.9 SDKs, Apple introduced new base64 methods on NSData that make it unnecessary to use a 3rd party base 64 decoding library. What's more, they exposed access to private base64 methods that are retrospectively available back as far as IOS 4 and Mac OS 6.

Although use of this library is no longer required, you may still find it useful, as it abstracts the complexity of supporting the deprecated Base64 methods for older OS versions, and also provides some additional utility functions, such as arbitrary wrap widths and NSString encoding.


Purpose
--------------

Base64 is a set of categories that provide methods to encode and decode data as a base-64-encoded string.


Supported OS & SDK Versions
-----------------------------

* Supported build target - iOS 7.0 / Mac OS 10.9 (Xcode 5.0, Apple LLVM compiler 5.0)
* Earliest supported deployment target - iOS 5.0 / Mac OS 10.7
* Earliest compatible deployment target - iOS 4.3 / Mac OS 10.6

NOTE: 'Supported' means that the library has been tested with this version. 'Compatible' means that the library should work on this iOS version (i.e. it doesn't rely on any unavailable SDK features) but is no longer being tested for compatibility and may require tweaking or bug fixes to run correctly.


ARC Compatibility
------------------

As of version 1.1, Base64 requires ARC. If you wish to use Base64 in a non-ARC project, just add the -fobjc-arc compiler flag to the Base64.m file. To do this, go to the Build Phases tab in your target settings, open the Compile Sources group, double-click Base64.m in the list and type -fobjc-arc into the popover.

If you wish to convert your whole project to ARC, comment out the #error line in Base64.m, then run the Edit > Refactor > Convert to Objective-C ARC... tool in Xcode and make sure all files that you wish to use ARC for (including Base64.m) are checked.


Thread Safety
--------------

All the Base64 methods should be safe to call from multiple threads concurrently.


Installation
--------------

To use the Base64 category in an app, just drag the category files (demo files and assets are not needed) into your project and import the header file into any class where you wish to make use of the Base64 functionality.


NSData Extensions
----------------------

Base64 extends NSData with the following methods:

    + (NSData *)dataWithBase64EncodedString:(NSString *)string;
    
Takes a base-64-encoded string and returns an autoreleased NSData object containing the decoded data. Any non-base-64 characters in the string are ignored, so it is safe to pass a string containing line breaks or other delimiters.

    - (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
    
Encodes the data as a base-64-encoded string and returns it. The wrapWidth argument allows you to specify the number of characters at which the output should wrap onto a new line. The value of wrapWidth must be a multiple of four. Values that are not a multiple of four will be truncated to the nearest multiple. A value of zero indicates that the data should not wrap.
    
    - (NSString *)base64EncodedString;
    
Encodes the data as a base-64-encoded string without any wrapping (line breaks).


NSString Extensions
----------------------

Base64 extends NSString with the following methods:

    + (NSString *)stringWithBase64EncodedString:(NSString *)string;
    
Takes a base-64-encoded string and returns an autoreleased NSString object containing the decoded data, interpreted using UTF8 encoding. The vast majority of use cases for Base64 encoding use Ascii or UTF8 strings, so this should be sufficient for most purposes. If you do need to decode string data in an encoding other than UTF8, convert your string to an NSData object first and then use the NSData dataWithBase64EncodedString: method instead.

    - (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
    
Converts the string data to UTF8 data and then encodes the data as a base-64-encoded string and returns it. The wrapWidth argument allows you to specify the number of characters at which the output should wrap onto a new line. The value of wrapWidth must be a multiple of four. Values that are not a multiple of four will be truncated to the nearest multiple. A value of zero indicates that the data should not wrap.
    
    - (NSString *)base64EncodedString;
    
Encodes the string as UTF8 data and then encodes that as a base-64-encoded string without any wrapping (line breaks).

    - (NSString *)base64DecodedString;
    
Treats the string as a base-64-encoded string and returns an autoreleased NSString object containing the decoded data, interpreted using UTF8 encoding. Any non-base-64 characters in the string are ignored, so it is safe to use a string containing line breaks or other delimiters.

    - (NSData *)base64DecodedData;

Treats the string as base-64-encoded data and returns an autoreleased NSData object containing the decoded data. Any non-base-64 characters in the string are ignored, so it is safe to use a string containing line breaks or other delimiters.
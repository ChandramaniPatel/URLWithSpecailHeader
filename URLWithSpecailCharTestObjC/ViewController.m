//
//  ViewController.m
//  URLWithSpecailCharTestObjC
//
//  Created by Chandramani on 07/01/19.
//  Copyright © 2019 Chandramani. All rights reserved.
//

#import "ViewController.h"

@implementation NSString (URLEncoding)
- (nullable NSString *)stringByAddingPercentEncodingForRFC3986 {
    //    NSString *unreserved = @"-._~/?#";
    NSString *unreserved = @"-._~/?";
    NSMutableCharacterSet *allowed = [NSMutableCharacterSet
                                      alphanumericCharacterSet];
    
    [allowed addCharactersInString:unreserved];
    
    return [self
            stringByAddingPercentEncodingWithAllowedCharacters:
            allowed];
}

- (nullable NSString *)stringByRemovingPercentEncodingForAllowedChar {
    NSString *unreserved = @"#";
    NSMutableCharacterSet *allowed = [NSMutableCharacterSet
                                      alphanumericCharacterSet];
    
    [allowed addCharactersInString:unreserved];
    return [self
            stringByRemovingPercentEncoding];
}

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *filePath =[[NSBundle mainBundle]pathForResource:@"ExceptionCharacterList" ofType:@"plist"];
    NSDictionary* dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    NSDictionary *specialCharDict = [dict objectForKey:@"Special Character Dict"];
    NSLog(@"%@", specialCharDict);
    /*  NSString *query = @"one&two =three#:";
     NSString *encoded = [query stringByAddingPercentEncodingForRFC3986];
     NSLog(@"encoded %@",encoded);
     encoded = [encoded stringByRemovingPercentEncoding];
     NSLog(@"encoded %@",encoded);*/
    
    [self checkSpecialCharOnURL:filePath WithDict:specialCharDict];
}

- (void)checkSpecialCharOnURL :(NSString*) filePath WithDict:(NSDictionary*) charDict {
    
    NSURL *newURL = [NSURL fileURLWithPath:filePath];
    
//    NSString *myString = newURL.absoluteString;
    
    NSString *myString = @"https://stackoverflow.com/questions/47131350/is-there-a-way-to-loop-through-nsdictionary-in-objective-c-where-key-values-are?rq%28%30";
    // A
    
    NSString *stringUrl = myString;
    for(id key in charDict) {
        NSLog(@"key=%@ value=%@", key, [charDict objectForKey:key]);
      
        if ([stringUrl containsString:key]) {
            NSLog(@"string contains Key!");
            
//            stringUrl = [stringUrl stringByReplacingOccurrencesOfString:@"%23"
//                                                             withString:@"#"];
            
            stringUrl = [stringUrl stringByReplacingOccurrencesOfString:key
                                                             withString:[charDict objectForKey:key]];
            
//
            newURL = [NSURL URLWithString:stringUrl];
            
            NSLog(@"URL");
            
        } else {
            NSLog(@"string does not contain any key");
        }
    }
}
@end

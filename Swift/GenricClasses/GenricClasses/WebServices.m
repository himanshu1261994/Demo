//
//  WebServices.m
//  GenricClasses
//
//  Created by indianic on 13/06/16.
//  Copyright © 2016 indianic. All rights reserved.
//

#import "WebServices.h"

@implementation WebServices
static WebServices *WSOBJ;

+(WebServices *)classInstance{
    if(WSOBJ!=nil)
        return WSOBJ;
    else
        WSOBJ = [[WebServices alloc] init];
    
    return WSOBJ;
}

-(void)callWSWithURL:(NSString *)aStrURL withParams:(NSMutableDictionary *)aDict showConnectionError:(BOOL)aBoolVal withCompletionBlock:(void(^)(NSMutableDictionary * responseData))completionBlock withFailureBlock:(void(^)(NSError * error))failureBlock
{
    
    NSMutableString *browserRequest = [NSMutableString stringWithFormat:@"%@?",aStrURL];
    for (int i =0; i<aDict.allKeys.count  ; i++) {
        NSString *strToAppend = [NSString stringWithFormat:@"&%@=%@",[aDict allKeys][i],[aDict objectForKey:[aDict allKeys][i]]];
        [browserRequest appendString:strToAppend];
    }
    NSLog(@"******************\nBrowser request \n%@",browserRequest);
    
    if ([WebServices checkForInternetConnection]) {
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager POST:aStrURL parameters:aDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [CoinActivityView removeView];
            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            NSMutableDictionary *mutDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            completionBlock((NSMutableDictionary *)mutDict);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            failureBlock(error);
            [CoinActivityView removeView];
        }];
        
    }
    else
    {
       
        if(aBoolVal)
        {
            [self showConnectionErrorAlert];
        }
    }
    //  [operation start];
    
}

-(void)callWebserviceWithURL:(NSString *)aStrURL withParams:(NSDictionary *)aDict showConnectionError:(BOOL)aBoolVal withCompletionBlock:(void(^)(NSDictionary * responseData))completionBlock withFailureBlock:(void(^)(NSError * error))failureBlock
{
    
    NSMutableString *browserRequest = [NSMutableString stringWithFormat:@"%@?",aStrURL];
    for (int i =0; i<aDict.allKeys.count  ; i++) {
        NSString *strToAppend = [NSString stringWithFormat:@"&%@=%@",[aDict allKeys][i],[aDict objectForKey:[aDict allKeys][i]]];
        [browserRequest appendString:strToAppend];
    }
    NSLog(@"******************\nBrowser request \n%@",browserRequest);
    if ([WebServices checkForInternetConnection]) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager POST:aStrURL parameters:aDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [CoinActivityView removeView];
            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            NSMutableDictionary *mutDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            completionBlock((NSMutableDictionary *)mutDict);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [CoinActivityView removeView];
            failureBlock(error);
        }];
    }
    else
    {
        [CoinActivityView removeView];
        if(aBoolVal)
        {
            [self showConnectionErrorAlert];
        }
    }
    //  [operation start];
    
}
-(void)callWebserviceToUploadImageWithURL:(NSString *)aStrURL withParams:(NSMutableDictionary *)aDict showConnectionError:(BOOL)aBoolVal withCompletionBlock:(void(^)(NSDictionary * responseData))completionBlock withFailureBlock:(void(^)(NSError * error))failureBlock
{
    
    NSMutableString *browserRequest = [NSMutableString stringWithFormat:@"%@?",aStrURL];
    for (int i =0; i<aDict.allKeys.count  ; i++) {
        NSString *strToAppend = [NSString stringWithFormat:@"&%@=%@",[aDict allKeys][i],[aDict objectForKey:[aDict allKeys][i]]];
        [browserRequest appendString:strToAppend];
    }
    NSLog(@"******************\nBrowser request \n%@",browserRequest);
    
    if ([Webservice checkForInternetConnection]) {
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        
        NSData *imageData;
        NSString *aStrParamName;
        
        if(aDict[@"Image"])
        {
            imageData = UIImageJPEGRepresentation(aDict[@"Image"], 0.5);
            aStrParamName = aDict[@"ParamName"];
            [aDict removeObjectForKey:@"ParamName"];
        }
        
        NSData *imageData2;
        NSString *aStrParamName2;
        
        if(aDict[@"Image2"])
        {
            
            imageData2 = UIImageJPEGRepresentation(aDict[@"Image2"], 0.5);
            aStrParamName2 = aDict[@"SecondParam"];
            [aDict removeObjectForKey:@"SecondParam"];
        }
        
        AFHTTPRequestOperation *op = [manager POST:aStrURL parameters:aDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            //do not put image inside parameters dictionary as I did, but append it!
            if(aDict[@"Image"])
            {
                [formData appendPartWithFileData:imageData name:aStrParamName fileName:@"logo.jpg" mimeType:@"image/jpeg"];
            }
            if(aDict[@"Image2"])
            {
                [formData appendPartWithFileData:imageData2 name:aStrParamName2 fileName:@"restimage.jpg" mimeType:@"image/jpeg"];
            }
            
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [CoinActivityView removeView];
            completionBlock(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [CoinActivityView removeView];
            failureBlock(error);
        }];
        [op start];
        
        
        
    }
    else
    {
        [CoinActivityView removeView];
        if(aBoolVal)
        {
            [self showConnectionErrorAlert];
        }
    }
    //  [operation start];
    
}

-(void)showConnectionErrorAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"EatOutWithMe" message:@"Couldn't connect to server, Please try again later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}


+(BOOL)checkForInternetConnection
{
    BOOL bNetAvailable=TRUE;
    
    
    [ReachabilityIndiaNIC reachabilityWithHostname:@"www.google.com"];
    
    NetworkStatus hostStatus =[[ReachabilityIndiaNIC reachabilityForInternetConnection] currentReachabilityStatus];
    switch (hostStatus)
    {
        case NotReachable:
        {
            bNetAvailable = NO;
            break;
        }
        case ReachableViaWiFi:
        {
            bNetAvailable = YES;
            break;
        }
        case ReachableViaWWAN:
        {
            bNetAvailable = YES;
            break;
        }
    }
    
    return bNetAvailable;
}



@end

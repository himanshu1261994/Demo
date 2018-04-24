//
//  WebServices.h
//  GenricClasses
//
//  Created by indianic on 13/06/16.
//  Copyright © 2016 indianic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebServices : NSObject

+(WebServices *)classInstance;
-(void)callWSWithURL:(NSString *)aStrURL withParams:(NSMutableDictionary *)aDict showConnectionError:(BOOL)aBoolVal withCompletionBlock:(void(^)(NSMutableDictionary * responseData))completionBlock withFailureBlock:(void(^)(NSError * error))failureBlock;
-(void)callWebserviceWithURL:(NSString *)aStrURL withParams:(NSDictionary *)aDict showConnectionError:(BOOL)aBoolVal withCompletionBlock:(void(^)(NSDictionary * responseData))completionBlock withFailureBlock:(void(^)(NSError * error))failureBlock;
-(void)callWebserviceToUploadImageWithURL:(NSString *)aStrURL withParams:(NSMutableDictionary *)aDict showConnectionError:(BOOL)aBoolVal withCompletionBlock:(void(^)(NSDictionary * responseData))completionBlock withFailureBlock:(void(^)(NSError * error))failureBlock;
+(BOOL)checkForInternetConnection;

@end

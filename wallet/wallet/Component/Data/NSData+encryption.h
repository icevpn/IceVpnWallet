//
//  NSData+encryption.h
//  ICE VPN
//
//  Created by tgg on 2023/5/18.
//

#import <Foundation/Foundation.h>

@interface NSData (encryption)
///aes256的加密和解密
- (NSData *)aes256EncryptWithKey:(NSData *)key iv:(NSData *)iv;
- (NSData *)aes256DecryptWithkey:(NSData *)key iv:(NSData *)iv;
@end


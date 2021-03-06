//
//  NSObject+TYSDKEncrypt.h
//  TuyaSmartUtil
//
//  Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com)
//

#import <Foundation/Foundation.h>

@interface NSString (TYSDKEnCrypt)

- (NSString *)tysdk_sha1String;

- (NSString *)tysdk_md5String;

- (NSString *)tysdk_sha256String;

- (NSString *)tysdk_aes128EncryptWithKey:(NSString *)key;

- (NSString *)tysdk_aes128CBCEncryptWithKey:(NSString *)key iv:(NSString *)iv;

- (NSString *)tysdk_aes128NoPaddingEncryptWithKey:(NSString *)key;

- (NSString *)tysdk_aes128DecryptWithKey:(NSString *)key;

- (NSString *)tysdk_aes128CBCDecryptWithKey:(NSString *)key iv:(NSString *)iv;

- (NSString *)tysdk_aes128NoPaddingDecryptWithKey:(NSString *)key;

- (NSString *)tysdk_aes256EncryptWithKey:(NSString *)key;

- (NSString *)tysdk_aes256DecryptWithKey:(NSString *)key;

- (NSString *)tysdk_hexRSAEncryptWithPublicKey:(NSString *)publicKey;

- (NSString *)tysdk_hexRSANoPaddingEncryptWithPublicKey:(NSString *)publicKey;

- (NSString *)tysdk_hmacSHA256StringWithKey:(NSString *)key;

@end


@interface NSData (TYSDKEncrypt)

- (NSString *)tysdk_md5String;

- (NSString *)tysdk_sha256String;

- (NSData *)tysdk_aes128EncryptWithKeyData:(NSData *)keyData;

- (NSData *)tysdk_aes128CBCEncryptWithKeyData:(NSData *)key iv:(NSData *)iv;

- (NSData *)tysdk_aes128NoPaddingEncryptWithKeyData:(NSData *)keyData;

- (NSData *)tysdk_aes128DecryptWithKeyData:(NSData *)keyData;

- (NSData *)tysdk_aes128CBCDecryptWithKeyData:(NSData *)keyData iv:(NSData *)iv;

- (NSData *)tysdk_aes128NoPaddingDecryptWithKeyData:(NSData *)keyData;

- (NSData *)tysdk_aes256EncryptWithKeyData:(NSData *)keyData;

- (NSData *)tysdk_aes256DecryptWithKeyData:(NSData *)keyData;

- (NSData *)tysdk_hmacSHA256DataWithKey:(NSString *)key;

- (NSData *)tysdk_hmacSHA256DataWithKeyData:(NSData *)keyData;

#if TARGET_OS_IOS

- (NSData *)tysdk_aes128GCMDencryptWithKeyData:(NSData *)keyData iv:(NSData *)ivData add:(NSData *)addData error:(NSError **)error;

- (NSData *)tysdk_aes128GCMEncryptWithKeyData:(NSData *)keyData iv:(NSData *)ivData add:(NSData *)addData error:(NSError **)error;

#endif

@end

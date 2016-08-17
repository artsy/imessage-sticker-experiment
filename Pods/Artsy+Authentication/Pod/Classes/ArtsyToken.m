#import "ArtsyToken.h"

@implementation ArtsyToken

+ (BOOL)supportsSecureCoding
{
    return YES;
}

- (instancetype)initWithToken:(NSString *)token expirationDate:(NSDate *)expirationDate
{
    self = [super init];
    if (!self) return nil;

    _token = token;
    _expirationDate = expirationDate;

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.token forKey:@"token"];
    [encoder encodeObject:self.expirationDate forKey:@"expiration"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder
{
    NSString *token = [decoder decodeObjectOfClass:NSString.class forKey:@"token"];
    NSDate *date = [decoder decodeObjectOfClass:NSDate.class forKey:@"expiration"];

    return [self initWithToken:token expirationDate:date];
}

- (BOOL)hasExpired
{
    return [self hasExpiredWithDate:[NSDate date]];
}

- (BOOL)hasExpiredWithDate:(NSDate *)date
{
    return [self.expirationDate compare:date] == NSOrderedAscending;
}

- (BOOL)isEmpty {
    return self.token.length < 1;
}

- (NSString *)description {
    NSString *empty = @"non-empty";
    if (self.empty) {
        empty = @"empty";
    }

    return [NSString stringWithFormat:@"Artsy authentication token (%@) %p expires: %@", empty, self, self.expirationDate];
}

- (id)copyWithZone:(NSZone *)zone {
    return [[ArtsyToken allocWithZone:zone] initWithToken:self.token expirationDate:self.expirationDate];
}

@end

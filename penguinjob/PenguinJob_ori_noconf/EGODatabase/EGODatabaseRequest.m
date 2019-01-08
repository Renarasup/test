#import "EGODatabaseRequest.h"
#import "EGODatabase.h"
@interface EGODatabaseRequest (Private)
- (void)didSucceedWithResult:(EGODatabaseResult*)result;
- (void)didFailWithError:(NSError*)error;
@end
@implementation EGODatabaseRequest
@synthesize requestKind, database, delegate, tag;
- (id)initWithQuery:(NSString*)aQuery {
	return [self initWithQuery:aQuery parameters:nil];
}
- (id)initWithQuery:(NSString*)aQuery parameters:(NSArray*)someParameters {
	if((self = [super init])) {
		query = [aQuery retain];
		parameters = [someParameters retain];
		requestKind = EGODatabaseSelectRequest;
	}
	return self;
}
- (void)main {
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	[delegate retain];
	if(self.requestKind == EGODatabaseUpdateRequest) {
		BOOL result = [self.database executeUpdate:query parameters:parameters];
		if(result) {
			[self didSucceedWithResult:nil];
		} else {
			NSString* errorMessage = [self.database lastErrorMessage];
			NSDictionary* userInfo = nil;
			if(errorMessage) {
				userInfo = [NSDictionary dictionaryWithObject:errorMessage forKey:@"message"];
			}
			NSError* error = [NSError errorWithDomain:@"com.egodatabase.update"
												 code:[self.database lastErrorCode]
											 userInfo:userInfo];
			[self didFailWithError:error];
		}
	} else {
		EGODatabaseResult* result = [self.database executeQuery:query parameters:parameters];
		if(result.errorCode == 0) {
			[self didSucceedWithResult:result];
		} else {
			NSDictionary* userInfo = nil;
			if(result.errorMessage) {
				userInfo = [NSDictionary dictionaryWithObject:result.errorMessage forKey:@"message"];
			}
			NSError* error = [NSError errorWithDomain:@"com.egodatabase.select"
												 code:result.errorCode
											 userInfo:userInfo];
			[self didFailWithError:error];
		}
	}
	[delegate release];
	[pool release];
}
- (void)didSucceedWithResult:(EGODatabaseResult*)result {
	if(delegate && [delegate respondsToSelector:@selector(requestDidSucceed:withResult:)]) {
		[delegate requestDidSucceed:self withResult:result];
	}
}
- (void)didFailWithError:(NSError*)error {
	if(delegate && [delegate respondsToSelector:@selector(requestDidFail:withError:)]) {
		[delegate requestDidFail:self withError:error];
	}
}
- (void)dealloc {
	[parameters release];
	[database release];
	[super dealloc];
}
@end

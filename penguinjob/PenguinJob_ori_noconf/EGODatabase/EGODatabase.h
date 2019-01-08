#import <Foundation/Foundation.h>
#import "EGODatabaseRequest.h"
#import "EGODatabaseResult.h"
#import "EGODatabaseRow.h"
#import <sqlite3.h>
@interface EGODatabase : NSObject {
@protected
	NSString* databasePath;
	NSLock* executeLock;
@private
	sqlite3* handle;
	BOOL opened;
}
+ (id)databaseWithPath:(NSString*)aPath;
- (id)initWithPath:(NSString*)aPath;
- (BOOL)open;
- (void)close;
- (BOOL)executeUpdateWithParameters:(NSString*)sql, ... NS_REQUIRES_NIL_TERMINATION;
- (BOOL)executeUpdate:(NSString*)sql;
- (BOOL)executeUpdate:(NSString*)sql parameters:(NSArray*)parameters;
- (EGODatabaseResult*)executeQueryWithParameters:(NSString*)sql, ... NS_REQUIRES_NIL_TERMINATION;
- (EGODatabaseResult*)executeQuery:(NSString*)sql;
- (EGODatabaseResult*)executeQuery:(NSString*)sql parameters:(NSArray*)parameters;
- (EGODatabaseRequest*)requestWithQueryAndParameters:(NSString*)sql, ... NS_REQUIRES_NIL_TERMINATION;
- (EGODatabaseRequest*)requestWithQuery:(NSString*)sql;
- (EGODatabaseRequest*)requestWithQuery:(NSString*)sql parameters:(NSArray*)parameters;
- (EGODatabaseRequest*)requestWithUpdateAndParameters:(NSString*)sql, ... NS_REQUIRES_NIL_TERMINATION;
- (EGODatabaseRequest*)requestWithUpdate:(NSString*)sql;
- (EGODatabaseRequest*)requestWithUpdate:(NSString*)sql parameters:(NSArray*)parameters;
- (NSString*)lastErrorMessage;
- (BOOL)hadError;
- (int)lastErrorCode;
@property(nonatomic,readonly) sqlite3* sqliteHandle;
@end

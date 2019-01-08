#import <Foundation/Foundation.h>
typedef enum {
	EGODatabaseUpdateRequest,
	EGODatabaseSelectRequest
} EGODatabaseRequestKind;
@class EGODatabase, EGODatabaseResult;
@protocol EGODatabaseRequestDelegate;
@interface EGODatabaseRequest : NSOperation {
@private
	NSArray* parameters;
	NSInteger tag;
	NSString* query;
	EGODatabase* database;
	EGODatabaseRequestKind requestKind;
	id<EGODatabaseRequestDelegate> delegate;
}
- (id)initWithQuery:(NSString*)aQuery;
- (id)initWithQuery:(NSString*)aQuery parameters:(NSArray*)someParameters;
@property(nonatomic,assign) NSInteger tag;
@property(nonatomic,retain) EGODatabase* database;
@property(nonatomic,assign) EGODatabaseRequestKind requestKind;
@property(nonatomic,assign) id<EGODatabaseRequestDelegate> delegate;
@end
@protocol EGODatabaseRequestDelegate<NSObject>
- (void)requestDidSucceed:(EGODatabaseRequest*)request withResult:(EGODatabaseResult*)result; 
- (void)requestDidFail:(EGODatabaseRequest*)request withError:(NSError*)error;
@end

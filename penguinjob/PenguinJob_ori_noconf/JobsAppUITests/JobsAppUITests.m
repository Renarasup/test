#import <XCTest/XCTest.h>
@interface JobsAppUITests : XCTestCase
@end
@implementation JobsAppUITests
- (void)setUp {
    [super setUp];
    self.continueAfterFailure = NO;
    [[[XCUIApplication alloc] init] launch];
}
- (void)tearDown {
    [super tearDown];
}
- (void)testExample {
}
@end

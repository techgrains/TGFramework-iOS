import XCTest
import TGFramework

class TGUtilTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testTGUtilMethods() {
        XCTAssertTrue(TGUtil.stringHasValue("Test"))
        XCTAssertTrue(TGUtil.arrayHasValue([0,1,2,3]))
        XCTAssertTrue(TGUtil.dictionaryHasValue([0:"1",2:"3"]))
        XCTAssertEqual(TGUtil.getStringFromBoolianValue(false), "false")
        XCTAssertEqual(TGUtil.getBoolianValue("1"), true)
        XCTAssertEqual(TGUtil.timeIntervalToDateInString(100000), "Jan 2, 1970")
        XCTAssertEqual(TGUtil.changeInDateFormat("Mar 28, 2017", currentFormate: "dd/MM/YYYY"), "28/03/2017")
    }
}

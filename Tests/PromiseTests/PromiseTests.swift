import XCTest
@testable import Promise

class PromiseTests: XCTestCase {

    func testThen() {
        let ex = expectation(description: "expect then")
        
        Promise<String> { resolve, reject in
            resolve("OK")
        }.then { result in
            XCTAssertEqual(result, "OK")
            ex.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testThenPromise() {
        let ex = expectation(description: "expect then promise")
        
        Promise<String> { resolve, reject in
            resolve("OK")
        }.then { result -> Promise<Bool> in
            XCTAssertEqual(result, "OK")
            return Promise { resolve, reject in
                resolve(true)
            }
        }.then { result in
//            XCTAssertTrue(result)
            ex.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFail() {
        enum TestError: Error {
            case AnError
        }
        let ex = expectation(description: "expect fail")

        Promise<String> { resolve, reject in
            reject(TestError.AnError)
        }.fail { error in
            ex.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)

    }
}

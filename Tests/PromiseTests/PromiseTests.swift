import XCTest
@testable import Promise

class PromiseTests: XCTestCase {

    enum TestError: Error {
        case AnError
    }
    
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
        }.then { result in
            return Promise<Bool> { resolve, reject in
                resolve(true)
            }
        }.then { result in
            XCTAssertTrue(result)
            ex.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFail() {
        let ex = expectation(description: "expect fail")

        Promise<String> { resolve, reject in
            reject(TestError.AnError)
        }.fail { error in
            ex.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)

    }
    
    func testThenFail() {
        let ex = expectation(description: "expect fail")
        
        Promise<String> { resolve, reject in
            resolve("OK")
        }.then { result in
            return Promise<Bool> { resolve, reject in
                reject(TestError.AnError)
            }
        }.fail { error in
            ex.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}

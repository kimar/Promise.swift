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
        }.then { result -> Promise<Bool> in
            XCTAssertEqual(result, "OK")
            return Promise<Bool> { resolve, reject in
                resolve(true)
            }
        }.then { result in
            XCTAssertTrue(result)
            ex.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testThenThenPromise() {
        let ex = expectation(description: "expect then promise")
        
        Promise<String> { resolve, reject in
            resolve("OK")
        }.then { result -> Promise<Bool> in
            XCTAssertEqual(result, "OK")
            return Promise<Bool> { resolve, reject in
                resolve(true)
            }
        }.then { result -> Promise<Int> in
            XCTAssertTrue(result)
            return Promise<Int> { resolve, reject in
                resolve(42)
            }
        }.then { result in
            XCTAssertEqual(result, 42)
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
        }.then { result -> Promise<Bool> in
            XCTAssertEqual(result, "OK")
            return Promise<Bool> { resolve, reject in
                reject(TestError.AnError)
            }
        }.fail { error in
            switch error {
            case TestError.AnError:
                XCTAssertTrue(true)
            default:
                XCTAssertTrue(false)
            }
            ex.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}

import XCTest
@testable import Promise

class PromiseTests: XCTestCase {

    func testThenFail() {
        Promise<String> { resolve, reject in
            resolve("OK")
        }.then { result in
            XCTAssertEqual(result, "OK")
        }.fail { error in
            print("failed: \(error)")
        }
    }
}

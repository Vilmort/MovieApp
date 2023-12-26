//
//  KPNetworkTests.swift
//  KPNetworkTests
//
//  Created by Victor on 26.12.2023.
//

import XCTest
@testable import KPNetwork

final class KPNetworkTests: XCTestCase {
    
    var sut: DefaultKPNetworkClient!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = DefaultKPNetworkClient(
            baseURL: "https://api.kinopoisk.dev/v1.4/",
            tokens: []
        )
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testMovieIdRequest() {
        let expectation = self.expectation(description: "response")
        Task {
            let result = await sut.sendRequest(request: KPMovieRequest(id: 81289))
            expectation.fulfill()
            guard let value = try? result.get(), let name = value.name else {
                XCTAssert(false)
                return
            }
            XCTAssertEqual(name, "Война миров")
        }
        waitForExpectations(timeout: 10)
    }

}

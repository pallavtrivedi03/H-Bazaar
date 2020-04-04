//
//  H_BazaarTests.swift
//  H-BazaarTests
//
//  Created by Pallav Trivedi on 01/04/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//

import XCTest
@testable import H_Bazaar

class H_BazaarTests: XCTestCase {

    var sut: HomeViewModel!

    override func setUp() {
        sut = HomeViewModel()
          let testBundle = Bundle(for: type(of: self))
          let path = testBundle.path(forResource: "Products", ofType: "json")
          let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
          
          let url = URL(string: "https://stark-spire-93433.herokuapp.com/json")
          let urlResponse = HTTPURLResponse(url: url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
          let sessionMock = URLSessionMock(data: data, response: urlResponse, error: nil)
          NetworkManager.shared.webserviceHelper.session = sessionMock    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_ProductsList_ParsesData() {
        
        //This test is to be run when app is not installed.
         let promise = expectation(description: "Status code: 200")
         
           XCTAssertEqual(sut.categories, nil, "categories array should be nil before the data task runs")
        sut.fetchDataFromAPI()
        DispatchQueue.global().asyncAfter(deadline: .now()+4) {
            promise.fulfill()
        }
         wait(for: [promise], timeout: 5)
         
       XCTAssertEqual(sut.categories.count, 17, "Didn't parse 17 categories from fake response")
       }

}

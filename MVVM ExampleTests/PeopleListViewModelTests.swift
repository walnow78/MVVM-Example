//
//  PeopleListViewModel.swift
//  MVVM ExampleTests
//
//  Created by Walicki, Pawel (Cognizant) on 2/6/18.
//  Copyright © 2018 com.walicki.pawel. All rights reserved.
//

import XCTest
@testable import MVVM_Example

class PeopleListViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFetch() {
        
        let exp = expectation(description: "fetch")
    
        let viewModel = PeopleListViewModel(apiService: APIPeopleMock())
        
        viewModel.reloadData = {() -> Void in
            
            XCTAssert(viewModel.numberOfRows() == 6, "Expected 6 rows")
        
            let indexPath = IndexPath(item: 0, section: 0)
            let person = viewModel.personViewModel(at: indexPath)
            
            XCTAssert(person.name == "Sheldon Cooper", "Wront full name")
            XCTAssert(person.phone == "433 502 482", "Wrong phone number")
            
            exp.fulfill()
        }
        
        viewModel.fetchPeople()
        
        viewModel.showAlert = { (message) -> Void in
           XCTFail("Error fetching data")
        }
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func testFechWithError() {
        let exp = expectation(description: "fetchWithError")
        
        let viewModel = PeopleListViewModel(apiService: APIPeople())
        
        viewModel.reloadData = {() -> Void in
            
            XCTAssert(viewModel.numberOfRows() == 0, "Expected 0 rows")
            exp.fulfill()
        }
        
        viewModel.showAlert = { (message) -> Void in
            XCTAssert(message != "", "Expected message text")
        }
    
        viewModel.fetchPeople()
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
}

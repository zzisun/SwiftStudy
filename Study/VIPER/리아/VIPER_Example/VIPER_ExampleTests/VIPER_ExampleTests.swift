//
//  VIPER_ExampleTests.swift
//  VIPER_ExampleTests
//
//  Created by Lia on 2021/11/09.
//

import XCTest
@testable import VIPER_Example

class CarPresenterTests: XCTestCase {
    var presenter: CarsPresenterProtocol!
    var interactor: TestCarInteractor!
    var router: TestCarRouter!
    
    override func setUp() {
        super.setUp()
        
        interactor = TestCarInteractor()
        router = TestCarRouter()
        presenter = CarsPresenter(interactor: interactor, router: router)
    }
    
    func testThatItRetrievesCars() {
        let testExpectation = expectation(description: #function)
        
        let car = Car(id: "id", make: "Subaru", model: "WRX", trim: "Limited")
        interactor.cars = [car]
        
        let callback = { (_ cars: [CarViewModel]?) -> Void in
            XCTAssertEqual(cars?.count, 1)
            XCTAssertEqual(cars?.first?.make, "Subaru")
            XCTAssertEqual(cars?.first?.model, "WRX")
            testExpectation.fulfill()
        }
        
        presenter.showCars(callback)
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testThatItShowsCarDetailScreen() {
        presenter.showCarDetail(for: CarViewModel(make: "Subaru", model: "WRX"))
        XCTAssertTrue(router.showCarDetailCalled)
    }
    
    func testThatItShowsCreateCarScreen() {
        presenter.showCreateCarScreen()
        XCTAssertTrue(router.showCreateCarScreenCalled)
    }
}

// Test Classes
extension CarPresenterTests {
    class TestCarRouter: CarsRouterProtocol {
        var showCarDetailCalled = false
        var showCreateCarScreenCalled = false
        
        func showCarDetail(for viewModel: CarViewModel) {
            showCarDetailCalled = true
        }
        
        func showCreateCarScreen() {
            showCreateCarScreenCalled = true
        }
    }
    
    class TestCarInteractor: CarsInteractorProtocol {
        var cars: [Car]?
        
        func getCars(_ completion: ([Car]?) -> Void) {
            completion(cars)
        }
    }
}

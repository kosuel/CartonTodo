//
//  CartonTodoTests.swift
//  CartonTodoTests
//
//  Created by ohhyung kwon on 29/7/2022.
//

import XCTest
@testable import CartonTodo
import Combine

class CartonTodoTests: XCTestCase {

    var cancels = Set<AnyCancellable>()
    
    let mocStorageService = ExampleStorageService()
    
    override func setUpWithError() throws {
        cancels = []
    }

    override func tearDownWithError() throws {
    }

    /// last completion status shuould be preserved
    func testExampleStorageService_persistData() throws {
        
        var viewModel: TodoListViewModel? = loadViewModel(storageService: mocStorageService)

        // toggle completion
        viewModel!.toggleComplete(ofId: "2")
        
        let numOfCompleted = viewModel!.numOfCompleted
        
        // reload data
        viewModel = nil
        
        viewModel = loadViewModel(storageService: mocStorageService)
        
        XCTAssertEqual(numOfCompleted, viewModel!.numOfCompleted)
    }
    
    /// test completion toggle
    func testExampleStorageService_toggleComplete() throws {
        
        let viewModel = loadViewModel(storageService: mocStorageService)

        // check number of data
        XCTAssertEqual(viewModel.numOfItems, mocStorageService.exampleData.count)
        
        let oldCompleted = viewModel.numOfCompleted
        
        // check toggle works
        viewModel.toggleComplete(ofId: "3")
        
        let newCompleted = viewModel.numOfCompleted
        
        XCTAssertNotEqual(oldCompleted, newCompleted)
    }
    
    func loadViewModel(storageService: StorageService) -> TodoListViewModel {
        
        let viewModel = TodoListViewModel(storageService: storageService)
        
        let expected = expectation(description: "data loading finished")
        
        viewModel.$isLoading
            .sink { isLoading in
                if isLoading == false {
                    expected.fulfill()
                }
            }
            .store(in: &cancels)
        
        /// wait for data loading
        wait(for: [expected], timeout: 1)
        
        return viewModel
    }
}

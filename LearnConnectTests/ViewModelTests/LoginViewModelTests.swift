//
//  LoginViewModelTests.swift
//  LearnConnectTests
//
//  Created by Berkay Sancar on 26.11.2024.
//

import XCTest
@testable import LearnConnect

final class LoginViewModelTests: XCTestCase {
    var viewModel: LoginViewModel!
    var mockAuthService: MockAuthService!
    
    override func setUp() {
        super.setUp()
        mockAuthService = MockAuthService()
        viewModel = LoginViewModel(authService: mockAuthService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockAuthService = nil
        super.tearDown()
    }
    
    func testLoginSuccess() {
        XCTAssertFalse(mockAuthService.invokedLogin)
        XCTAssertEqual(mockAuthService.invokedLoginCount, 0)
        XCTAssertTrue(mockAuthService.invokedLoginParamsList.isEmpty)
        
        viewModel.loginTapped(email: "test@test.com", password: "test") { }
        
        XCTAssertTrue(mockAuthService.invokedLogin)
        XCTAssertEqual(mockAuthService.invokedLoginCount, 1)
        XCTAssertFalse(mockAuthService.invokedLoginParamsList.isEmpty)
        XCTAssertEqual(mockAuthService.invokedLoginParamsList.map(\.email), ["test@test.com"])
        XCTAssertEqual(mockAuthService.invokedLoginParamsList.map(\.password), ["test"])
    }
}

//
//  SignUpViewModelTests.swift
//  LearnConnectTests
//
//  Created by Berkay Sancar on 26.11.2024.
//

import XCTest
@testable import LearnConnect

final class SignUpViewModelTests: XCTestCase {
    
    var viewModel: SignUpViewModel!
    var mockAuthService: MockAuthService!
    
    override func setUp() {
        super.setUp()
        mockAuthService = MockAuthService()
        viewModel = SignUpViewModel(authService: mockAuthService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockAuthService = nil
        super.tearDown()
    }
    
    func testSignUpSuccess() {
        XCTAssertFalse(mockAuthService.invokedSignUp)
        XCTAssertEqual(mockAuthService.invokedSignUpCount, 0)
        XCTAssertTrue(mockAuthService.invokedSignUpParamsList.isEmpty)
        
        viewModel.userName = "Tester"
        viewModel.email = "test@mail.com"
        viewModel.password = "123456"
        viewModel.signUpTapped(email: viewModel.email, password: viewModel.password)
        
        XCTAssertTrue(mockAuthService.invokedSignUp)
        XCTAssertEqual(mockAuthService.invokedSignUpCount, 1)
        XCTAssertFalse(mockAuthService.invokedSignUpParamsList.isEmpty)
        XCTAssertEqual(mockAuthService.invokedSignUpParamsList.map(\.email), ["test@mail.com"])
        XCTAssertEqual(mockAuthService.invokedSignUpParamsList.map(\.password), ["123456"])
    }
    
    func testSignUp_Success_AlertTypeSuccess() {
        mockAuthService.shouldReturnError = false
        
        viewModel.userName = "Berkay Sancar"
        viewModel.email = "berkay@mail.com"
        viewModel.password = "123456"
        viewModel.signUpTapped(email: viewModel.email, password: viewModel.password)
        
        XCTAssertEqual(viewModel.activeAlert, .signUpSuccess)
    }
}


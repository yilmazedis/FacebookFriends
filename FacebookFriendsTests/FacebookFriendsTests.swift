//
//  FacebookFriendsTests.swift
//  FacebookFriendsTests
//
//  Created by yilmaz on 11.04.2023.
//

import XCTest
@testable import FacebookFriends

class FacebookFriendsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testFriendListVIPRetainCycle() {
        
        var viewController: FriendListEntryPoint? = FriendListConfigurator.shared.configure()
        weak var weakReference: FriendListEntryPoint? = viewController
        // Create a weak reference to the view controller to check if it gets deallocated

        viewController = nil
        // Set the view controller reference to nil to trigger deallocation

        XCTAssertNil(weakReference, "The FriendList view controller was not deallocated")
        // Assert that the weak reference to the view controller is nil, indicating that the view controller was deallocated
    }
    
    func testSignupVIPRetainCycle() {
        
        var viewController: SignupEntryPoint? = SignupConfigurator.shared.configure()
        weak var weakReference: SignupEntryPoint? = viewController
        // Create a weak reference to the view controller to check if it gets deallocated

        viewController = nil
        // Set the view controller reference to nil to trigger deallocation

        XCTAssertNil(weakReference, "The Signup view controller was not deallocated")
        // Assert that the weak reference to the view controller is nil, indicating that the view controller was deallocated
    }
    
    func testSigninVIPRetainCycle() {
        
        var viewController: SigninEntryPoint? = SigninConfigurator.shared.configure()
        weak var weakReference: SigninEntryPoint? = viewController
        // Create a weak reference to the view controller to check if it gets deallocated

        viewController = nil
        // Set the view controller reference to nil to trigger deallocation

        XCTAssertNil(weakReference, "The Signin view controller was not deallocated")
        // Assert that the weak reference to the view controller is nil, indicating that the view controller was deallocated
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

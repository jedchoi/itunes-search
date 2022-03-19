//
//  itunes_searchTests.swift
//  itunes-searchTests
//
//  Created by JaeHyuk Choi on 2022/03/18.
//

import XCTest
import ReactiveSwift
@testable import itunes_search

class itunes_searchTests: XCTestCase {
    var dataSource: ITunesAPIInterface!
    var disposables: CompositeDisposable!

    override func setUpWithError() throws {
        Logger.track()
        dataSource = DependencyResolver.resolve(ITunesAPIInterface.self)
        disposables = CompositeDisposable()
    }

    override func tearDownWithError() throws {
        dataSource = nil
        disposables.dispose()
    }

    func testGetAppList() throws {
        let expt = expectation(description: "Test get app list")
        disposables += dataSource.getAppList(key: "something").startWithResult { result in
            switch result {
            case .success(let appList):
                Logger.track("\(appList)")
                XCTAssert(!appList.isEmpty, "init failed")
                expt.fulfill()
            case .failure(let error):
                Logger.track("\(error)")
            }
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }

}

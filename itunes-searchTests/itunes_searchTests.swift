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

    func testGetAppListDataSource() throws {
        let expt = expectation(description: "Test get app list from data source")
        disposables += dataSource.getAppList(key: "something").startWithResult { result in
            switch result {
            case .success(let appList):
                Logger.track("\(appList)")
                XCTAssert(!appList.isEmpty, "test failed")
                expt.fulfill()
            case .failure(let error):
                Logger.track("\(error)")
            }
        }
        waitForExpectations(timeout: 2.0, handler: nil)
    }

    func testGetAppListService() throws {
        let expt = expectation(description: "Test get app list from service")
        let usecase = GetAppListUseCase()
        disposables += usecase.execute(param: "something").startWithResult { result in
            switch result {
            case .success(let appList):
                Logger.track()
                XCTAssert(!appList.isEmpty, "test failed")
                expt.fulfill()
            case .failure(let error):
                Logger.track("\(error)")
            }
        }
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testGetDetailAppInformation() throws {
        let expt = expectation(description: "Test get app list from service")
        let usecase = GetDetailAppInformationUseCase()
        let param = "카카오뱅크"
        disposables += usecase.execute(param: param).startWithResult { result in
            switch result {
            case .success(let appList):
                Logger.track()
                XCTAssert(appList.title == param, "test failed")
                expt.fulfill()
            case .failure(let error):
                Logger.track("\(error)")
            }
        }
        waitForExpectations(timeout: 2.0, handler: nil)
    }
}

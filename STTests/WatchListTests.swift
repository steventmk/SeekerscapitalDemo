//
//  STTests.swift
//  STTests
//
//  Created by Tao Man Kit on 11/7/2019.
//  Copyright © 2019 tao. All rights reserved.
//

import XCTest
@testable import ST
@testable import RxSwift
@testable import RxCocoa
@testable import RxBlocking
@testable import RxTest

class WatchListTests: XCTestCase {
    
    // normally we need to provide a fakeDataProvider but it is already fake in this demo XD
    var watchListViewModel = WatchListViewModel(dataProvider: WatchListDataProvider())
    var stocks: [Stock]!
    let stock = Stock(name: "Apple Inc.", code: "APPL", close: 10.123, low: 9, high: 12, open: 10.1)
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        Styles.setup()
        loadMockData()
        disposeBag = DisposeBag()
    }

    override func tearDown() {
    
    }

    func testChangeColorCode() {
        var stock = Stock(name: "Apple Inc.", code: "APPL", close: 9, low: 9, high: 12, open: 10.1)
        var viewModel = WatchlistCellViewModel(stock: stock)
        XCTAssertEqual(viewModel.colorCode.value, Styles.decreasingColor)
        stock.close = 12
        viewModel = WatchlistCellViewModel(stock: stock)
        XCTAssertEqual(viewModel.colorCode.value, Styles.increasingColor)
        stock.close = 10.1
        viewModel = WatchlistCellViewModel(stock: stock)
        XCTAssertEqual(viewModel.colorCode.value, Styles.neutralColor)
    }
    
    func testLastPriceFormat() {
        let viewModel = WatchlistCellViewModel(stock: stock)
        XCTAssertEqual(viewModel.lastPrice.value, "10.12")
    }
    
    func testChangeFormat() {
        let viewModel = WatchlistCellViewModel(stock: stock)
        XCTAssertEqual(viewModel.change.value, "0.023")
    }
    
    func testChangePercentFormat() {
        let viewModel = WatchlistCellViewModel(stock: stock)
        XCTAssertEqual(viewModel.changePercent.value, "0.228%")
    }
    
    func testGetWatchList() throws {
        watchListViewModel.getWatchList()

        let watchListExpectation = expectation(description: "watchlist")
        watchListViewModel.cellViewModels.asObservable()
            .asObservable()
            .subscribe(onNext: { (cellViewModels) in
                if !cellViewModels.isEmpty {
                    watchListExpectation.fulfill()
                }
            })
            .disposed(by: disposeBag)
        
        wait(for: [watchListExpectation], timeout: 5)
        
        XCTAssertEqual(try watchListViewModel.cellViewModels.toBlocking().first(), stocks.map{WatchlistCellViewModel(stock: $0)})
    }
    
    // MARK: - Helpers
    func loadMockData() {
        if let path = Bundle.main.path(forResource: "watchListData", ofType: "json") {
            let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            stocks = try! JSONDecoder().decode([Stock].self, from: data)
        }
    }
    
}

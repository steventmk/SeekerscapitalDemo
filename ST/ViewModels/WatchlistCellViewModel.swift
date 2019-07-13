//
//  WatchlistCellViewModel.swift
//  ST
//
//  Created by Tao Man Kit on 8/7/2019.
//  Copyright © 2019 tao. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class WatchlistCellViewModel: ViewModel, MarketDataPresentable {
    // MARK: - Properties
    private var stock: Stock!
    var code = BehaviorRelay<String?>(value: nil)
    var name = BehaviorRelay<String?>(value: nil)
    var lastPrice = BehaviorRelay<String?>(value: nil)
    var change = BehaviorRelay<String?>(value: nil)
    var changePercent = BehaviorRelay<String?>(value: nil)
    var colorCode = BehaviorRelay<String>(value: Styles.neutralColor)
    
    // MARK: - Contructor
    init(stock: Stock) {
        self.stock = stock
        code.accept(stock.code)
        name.accept(stock.name)
        formatMarketData()
    }
    
    // MARK: - Public
    func updateClose(close: Double) {
        stock.close = close
        formatMarketData()
    }
    
    // MARK: - Private    
    private func formatMarketData() {
        let lastPriceStr = formatLastPrice(stock.close)
        let changeValue = countChange(open: stock.open, close: stock.close)
        let changeStr = formatChange(changeValue)
        let changePercentStr = formatChangePercent(countChangePercent(open: stock.open, close: stock.close))
        let colorCodeStr = colorCode(changeValue)
        lastPrice.accept(lastPriceStr)
        change.accept(changeStr)
        changePercent.accept(changePercentStr)
        colorCode.accept(colorCodeStr)
    }
}

extension WatchlistCellViewModel: Equatable {
    static func == (lhs: WatchlistCellViewModel, rhs: WatchlistCellViewModel) -> Bool {
        return lhs.stock == rhs.stock
    }
}

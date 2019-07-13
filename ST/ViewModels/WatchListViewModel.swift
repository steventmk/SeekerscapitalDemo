//
//  WatchListViewModel.swift
//  ST
//
//  Created by Tao Man Kit on 11/7/2019.
//  Copyright © 2019 tao. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class WatchListViewModel: ViewModel {
    
    // MARK: - Properties
    var dataProvider: WatchListDataProvider!
    private var stocks: [Stock]?
    var cellViewModels = BehaviorRelay<[WatchlistCellViewModel]>(value: [])
    var errorMessage = BehaviorRelay<String?>(value: nil)
    var isLoading = BehaviorRelay<Bool>(value: false)
    private let disposeBag = DisposeBag()
    
    
    // MARK: - Constructor
    init(dataProvider: WatchListDataProvider) {
        self.dataProvider = dataProvider
        dataProvider.isLoading
            .asObservable()
            .bind(to: self.isLoading)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Helpers
    func getWatchList() {
        dataProvider.getWatchList()
            .subscribe(
                onNext: {[weak self] stocks in
                    guard let strongSelf = self else { return }
                    let _cellViewModels = stocks.map { WatchlistCellViewModel(stock: $0) }
                    strongSelf.cellViewModels.accept(_cellViewModels)
            },
                onError: {[weak self] error in
                    self?.errorMessage.accept(error.localizedDescription)
            }
            )
            .disposed(by: disposeBag)
    }
    
    func streamWatchList() {
        dataProvider.streamWatchList()
            .subscribe(
                onNext: {[weak self] stocks in
                    guard let strongSelf = self else { return }
                    for stock in stocks {
                        if let cellViewModel = (strongSelf.cellViewModels.value.filter { $0.code.value == stock.code }).first {
                            cellViewModel.updateClose(close: stock.close)
                        }
                    }
                },
                onError: {[weak self] error in
                    self?.errorMessage.accept(error.localizedDescription)
                }
            )
            .disposed(by: disposeBag)
    }
}

//
//  WatchListDataProvider.swift
//  ST
//
//  Created by Tao Man Kit on 11/7/2019.
//  Copyright © 2019 tao. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class WatchListDataProvider: DataProvider {
    
    // MARK: - Properties
    let isLoading = BehaviorRelay<Bool>(value: false)
    var timer: Timer?
    
    // MARK: - Helpers
    func getWatchList() -> Observable<[Stock]> {
        return Observable.create { observer -> Disposable in
            // pretend the data are returned from server
            self.isLoading.accept(true)
            DispatchQueue.global().asyncAfter(deadline: .now() + 1, execute: {
                self.isLoading.accept(false)
                if let path = Bundle.main.path(forResource: "watchListData", ofType: "json") {
                    do {
                        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                        let stocks = try JSONDecoder().decode([Stock].self, from: data)
                        DispatchQueue.main.async {
                            observer.onNext(stocks)
                            observer.onCompleted()
                        }
                    } catch {
                        DispatchQueue.main.async { observer.onError(error) }
                    }
                }
            })
            
            return Disposables.create()
        }
    }
    
    func streamWatchList() -> Observable<[Stock]> {
        return Observable.create { observer -> Disposable in
            // pretend changed market data are streaming from server
            DispatchQueue.global().async {
                if let path = Bundle.main.path(forResource: "watchListData", ofType: "json") {
                    do {
                        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                        let stocks = try JSONDecoder().decode([Stock].self, from: data)
                        
                        DispatchQueue.main.async {
                            if self.timer != nil {
                                self.timer!.invalidate()
                            }
                            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
                                var updatedStocks = [Stock]()
                                // randomly assign stock and update its close value to simulate data streaming effect
                                stocks.forEach {
                                    if Bool.random() {
                                        var newStock = $0
                                        newStock.close += (Double.random(in: 0.0 ... 5.0) - 2.5)
                                        updatedStocks.append(newStock)
                                    }
                                }
                                observer.onNext(updatedStocks)                                
                            })
                        }
                    } catch {
                        DispatchQueue.main.async { observer.onError(error) }
                    }
                }
            }
            
            return Disposables.create()
        }
    }
    
    deinit {
        timer?.invalidate()
    }

}

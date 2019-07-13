//
//  WatchListViewController.swift
//  ST
//
//  Created by Tao Man Kit on 6/7/2019.
//  Copyright © 2019 tao. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class WatchListViewController: UIViewController, ViewModelBased {
    
    // MARK: - Properties    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var viewModel: WatchListViewModel!
    private let disposeBag = DisposeBag()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel(WatchListViewModel(dataProvider: WatchListDataProvider()))
        viewModel.getWatchList()
        viewModel.streamWatchList()
    }
    
    // MARK: - RX
    func bindViewModel(_ viewModel: WatchListViewModel) {
        self.viewModel = viewModel
        
        viewModel.cellViewModels
            .bind(to: self.tableView.rx.items(cellIdentifier: "WatchListCell", cellType: WatchListCell.self)) { row, model, cell in
                cell.bindViewModel(model)
            }.disposed(by: disposeBag)
        
        viewModel.errorMessage
            .asObservable()
            .observeOn(MainScheduler.instance)
            .filterNil()
            .subscribe(onNext: {[weak self] (errorMessage) in
                self?.showAlert(title: "Error", message: errorMessage)
            })
            .disposed(by: disposeBag)
        
        viewModel.isLoading
            .asDriver()
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
    }

    
}

//
//  WatchListCell.swift
//  ST
//
//  Created by Tao Man Kit on 6/7/2019.
//  Copyright © 2019 tao. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WatchListCell: UITableViewCell, ViewModelBased {

    // MARK: - Properties
    @IBOutlet weak var changeBaseView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var lastPriceLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var changePercentLabel: UILabel!
    var viewModel: WatchlistCellViewModel!
    private var disposeBag = DisposeBag()
    
    // MARK: - View Life Cycle    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }

    // MARK: - Helpers
    func bindViewModel(_ viewModel: WatchlistCellViewModel) {
        self.viewModel = viewModel
        
        viewModel.code
            .asDriver()
            .drive(titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.name
            .asDriver()
            .drive(subTitleLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.lastPrice
            .asDriver()
            .drive(lastPriceLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.change
            .asDriver()
            .drive(changeLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.changePercent
            .asDriver()
            .drive(changePercentLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.colorCode
            .asDriver()
            .map {UIColor(hexString: $0)}
            .drive(changeBaseView.rx.backgroundColor)
            .disposed(by: disposeBag)
    }

}

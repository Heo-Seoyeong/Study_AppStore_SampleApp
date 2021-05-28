//
//  BaseTableViewCell.swift
//  appStore
//
//  Created by seoyeong on 2021/05/28.
//

import UIKit

import RxCocoa
import RxSwift

class BaseTableViewCell: UITableViewCell {
    
    var bag = DisposeBag()
    
    final override func awakeFromNib() {
        super.awakeFromNib()
        
        commonInit()
    }

    final override func prepareForReuse() {
        super.prepareForReuse()
        
        commonInit()
    }
    
    func commonInit() {
        bag = DisposeBag()
    }

}

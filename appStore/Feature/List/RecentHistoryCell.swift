//
//  RecentHistoryCell.swift
//  appStore
//
//  Created by seoyeong on 2021/05/28.
//

import UIKit

class RecentHistoryCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func set(_ title: String) {
        titleLabel.text = title
    }

}

//
//  ListScreenshotCell.swift
//  appStore
//
//  Created by seoyeong on 2021/05/27.
//

import UIKit

class ListScreenshotCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
}

extension ListScreenshotCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 17
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 0.3
        imageView.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
    }
    
}

extension ListScreenshotCell {
    
    func bind(_ url: URL) {
        do {
            let data = try Data(contentsOf: url, options: .mappedIfSafe)
            imageView.image = UIImage(data: data)
        } catch {
            print(error)
        }
    }
    
}

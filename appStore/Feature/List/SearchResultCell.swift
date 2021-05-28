//
//  SearchResultCell.swift
//  appStore
//
//  Created by seoyeong on 2021/05/27.
//

import UIKit

import RxSwift
import RxCocoa

class SearchResultCell: BaseTableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var openButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private lazy var screenshotList: [URL] = []
    
    override func commonInit() {
        collectionView.rx.setDelegate(self)
            .disposed(by: bag)
    }
    
}

extension SearchResultCell {
    
    func bind(_ vm: ListDTO) {
        nameLabel.text = vm.trackName
        descLabel.text = vm.artistName
//        ratingView.rating = vm.averageUserRating
        reviewLabel.text = "\(vm.userRatingCount)"
        
        if let appIcon = vm.appIcon {
            iconImageView.image = UIImage(url: appIcon)
        }
     
        screenshotList = vm.screenshotList
        
        Observable.of(vm.screenshotList)
            .bind(to: collectionView.rx.items(cellIdentifier: "ListScreenshotCell", cellType: ListScreenshotCell.self)) { _, item, cell in
                cell.bind(item)
            }
            .disposed(by: bag)
    }
    
}

extension SearchResultCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = UIScreen.main.bounds.width - 60
        let widthPerItem = availableWidth / 3
        return CGSize(width: widthPerItem, height: widthPerItem * 2)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
}

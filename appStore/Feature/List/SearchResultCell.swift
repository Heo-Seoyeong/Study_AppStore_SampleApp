//
//  SearchResultCell.swift
//  appStore
//
//  Created by seoyeong on 2021/05/27.
//

import UIKit

class SearchResultCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var openButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!

    private lazy var screenshotList: [URL] = []
    
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
        self.collectionView.reloadData()
    }
    
}

extension SearchResultCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screenshotList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScreenshotCell", for: indexPath)
        if let cell = cell as? ScreenshotCell {
            cell.bind(screenshotList[indexPath.item])
        }
        return cell
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

//
//extension URL {
//
//    var image: UIImage {
//
//    }
//
//}

extension UIImage {
 
    convenience init?(url: URL) {
        do {
            let data = try Data(contentsOf: url, options: .mappedIfSafe)
            self.init(data: data)
        } catch {
            self.init()
        }
    }
    
}

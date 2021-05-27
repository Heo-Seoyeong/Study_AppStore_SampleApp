//
//  DetailViewController.swift
//  appStore
//
//  Created by seoyeong on 2021/05/24.
//

import UIKit

import RxSwift
import RxCocoa

class DetailViewController: BaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var openButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!

    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var averageAgeLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genreValueLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!

    @IBOutlet weak var iPhoneCollectionView: UICollectionView!
    @IBOutlet weak var iPadCollectionView: UICollectionView!
    @IBOutlet weak var screenshotTitleLabel: UILabel!
    @IBOutlet weak var screenshotTitleSecondLabel: UILabel!
    @IBOutlet weak var iconScreenshotImageView: UIImageView!
    @IBOutlet weak var showIPadScreenshotsButton: UIButton!

    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var modeButton: UIButton!
    @IBOutlet weak var showDescriptionButton: UIButton!

    @IBOutlet weak var rateView: UIView!
    @IBOutlet weak var rateDetailLabel: UILabel!
    @IBOutlet weak var reviewCountDetailLabel: UILabel!

    @IBOutlet weak var showDeveloperAppButton: UIButton!
    @IBOutlet weak var developerLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var releaseNoteLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!

    @IBOutlet weak var tableView: UITableView!

    var defaultHeight: Int = 100
    
    override func setUpGestures() {
        addAction(to: showIPadScreenshotsButton) {
            UIView.animate(withDuration: 0.05, animations: {
                self.iconScreenshotImageView.isHidden = true
                self.showIPadScreenshotsButton.isUserInteractionEnabled = false
                self.screenshotTitleLabel.text = "iPhone"
                self.iPadCollectionView.isHidden = false
                self.screenshotTitleSecondLabel.isHidden = false
            })
        }
        
    }

}

extension DetailViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigtionBar()

        iconImageView.layer.cornerRadius = 20
        openButton.layer.cornerRadius = openButton.frame.height / 2

        tableView.register(UINib(nibName: "InformationCell", bundle: nil), forCellReuseIdentifier: "InformationCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view.setNeedsUpdateConstraints()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
}

extension DetailViewController {
    
    func bind(_ data: AppStoreData) {
        let dto = DetailDTO(data)
        nameLabel.text = dto.trackName
        artistLabel.text = dto.artistName
        
        if let appIcon = dto.appIcon {
            iconImageView.image = UIImage(url: appIcon)
        }
        
//        rateView.rating = dto.averageUserRating
        rateLabel.isHidden = dto.averageUserRating == 0
        rateLabel.text = String(format: "%.1f", dto.averageUserRating)
        rateDetailLabel.text = String(format: "%.1f", dto.averageUserRating)
        
        reviewCountLabel.text = data.userRatingCount == 0 ? "평가 없음" : "\(dto.userRatingCount)개의 평가"
        reviewCountDetailLabel.text =  "\(dto.userRatingCount)개의 평가"
        
        genreLabel.text = dto.genres.first
        averageAgeLabel.text = dto.contentAdvisoryRating
        showIPadScreenshotsButton.isUserInteractionEnabled = !dto.ipadScreenshotUrls.isEmpty
        iconScreenshotImageView.isHidden = dto.ipadScreenshotUrls.isEmpty
        screenshotTitleLabel.text = dto.ipadScreenshotUrls.isEmpty ? "iPhone" : "iPad용 앱 제공"
        
        Observable.of(dto.ipadScreenshotUrls)
            .bind(to: iPhoneCollectionView.rx.items(cellIdentifier: "ScreenshotCell", cellType: ScreenshotCell.self)) { _, item, cell in
                cell.bind(item)
                cell.imageView.heightAnchor.constraint(equalToConstant: self.iPhoneCollectionView.frame.height - 10).isActive = true
                cell.imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        }.disposed(by: bag)
        
        Observable.of(dto.ipadScreenshotUrls)
            .bind(to: iPadCollectionView.rx.items(cellIdentifier: "ScreenshotCell", cellType: ScreenshotCell.self)) { _, item, cell in
                cell.bind(item)
                cell.imageView.heightAnchor.constraint(equalToConstant: self.iPhoneCollectionView.frame.height - 10).isActive = true
                cell.imageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        }.disposed(by: bag)
        
        developerLabel.attributedText = dto.description.toLineSpacedString(lineHeight: 1.4)
        developerLabel.text = dto.artistName
        versionLabel.text = "버전 " + dto.version
        releaseDateLabel.text = Date().offset(from: dto.releaseDate)
        releaseNoteLabel.text = dto.releaseNotes
        
        Observable.of(dto.detailContents())
            .bind(to: tableView.rx.items(cellIdentifier: "InformationCell", cellType: InformationCell.self)) { (_, item, cell) in
                cell.bind(item, desc: dto.description)
        }.disposed(by: bag)
        
        addAction(to: shareButton) {
            if let shareUrl = dto.shareUrl {
                let activityController = UIActivityViewController(activityItems: [shareUrl], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
            }
        }
        
        addAction(to: showDescriptionButton) {
            self.modeButton.isHidden = true
            self.descriptionLabel.numberOfLines = 0
            let attributedDesc = dto.description.toLineSpacedString(lineHeight: 1.4)
            self.descriptionLabel.attributedText = attributedDesc
            self.descriptionView.heightAnchor.constraint(equalToConstant: attributedDesc.height(width: UIScreen.main.bounds.width - 40) + 30).isActive = true
        }
        
        addAction(to: showDeveloperAppButton) {
            if let artistViewUrl = data.artistViewUrl,
               UIApplication.shared.canOpenURL(artistViewUrl) {
                UIApplication.shared.open(artistViewUrl, options: [:], completionHandler: nil)
            }
        }
    }
    
}

extension DetailViewController {

    func setNavigtionBar() {
        self.navigationItem.titleView?.layer.cornerRadius = 5
        self.navigationItem.titleView?.layer.masksToBounds = true
        self.navigationItem.titleView?.layer.borderWidth = 1
        self.navigationItem.titleView?.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
        self.navigationItem.titleView?.alpha = 0.0
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .systemBlue
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "검색", style: .plain, target: self, action: #selector(self.popVC))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "열기", style: .plain, target: self, action: nil)

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = .clear
    }

    @objc func popVC() {
        self.navigationController?.popViewController(animated: false)
    }
    
}

extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 {
            UIView.animate(withDuration: 0.3) {
                self.navigationItem.titleView?.alpha = 1.0
                self.navigationItem.rightBarButtonItem?.tintColor = .systemBlue
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.navigationItem.titleView?.alpha = 0.0
                self.navigationItem.rightBarButtonItem?.tintColor = .clear
            }
        }
    }
}

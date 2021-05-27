//
//  InformationCell.swift
//  appStore
//
//  Created by seoyeong on 2021/05/27.
//

import UIKit

class InformationCell: UITableViewCell {
    
    @IBOutlet weak var infoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var detailDescriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        detailDescriptionLabel.isHidden = true
        detailDescriptionLabel.heightAnchor.constraint(equalToConstant: 0).isActive = true
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        if selected {
//            switch reactor?.currentState.type {
//            case .SupportedDevice, .AdvisoryRating, .Language:
//                UIView.animate(withDuration: 0.05, animations: {
//                    self.imgView.isHidden = true
//                    self.labelDescription.isHidden = true
//                    self.labelDetailDescription.isHidden = false
//
//                    let attrDesc = self.reactor!.currentState.desc.toLineSpacedString()
//                    self.labelDetailDescription.attributedText = attrDesc
//                    self.labelDetailDescription.snp.remakeConstraints { make in
//                        make.height.equalTo(attrDesc.height(width: UIScreen.main.bounds.width - 40))
//                    }
//                })
//            default:
//                break
//            }
//        }
//    }
    
}

extension InformationCell {
    
    func bind(_ data: (DetailInformationContent, String), desc: String) {
        titleLabel.text = data.0.title
        
        descriptionLabel.text = desc
        
        switch data.0 {
        case .SupportedDevice:
            self.descriptionLabel.text = "이 iPhone와(과) 호환"
            self.infoImageView.isHidden = false
        case .Language:
            self.descriptionLabel.text = data.1
            self.infoImageView.isHidden = false
        case .AdvisoryRating:
            self.infoImageView.isHidden = false
        case .PrivacyPolicy, .DeveloperWebsite:
            self.titleLabel.textColor = .systemBlue
            self.infoImageView.isHidden = true
        default:
            self.infoImageView.isHidden = true
        }
    }
    
}

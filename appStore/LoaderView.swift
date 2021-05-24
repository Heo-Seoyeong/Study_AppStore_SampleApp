//
//  HudView.swift
//  MyLocations
//
//  Created by Paul Kim on 13/08/2019.
//  Copyright © 2019 Paul Kim. All rights reserved.
//

import UIKit

class LoaderView: UIView {
    @IBOutlet weak var lottieContainerView: UIView!
    private var contentView: UIView?
    
    static let shared: LoaderView = {
        return LoaderView(frame: .zero)
    }()
    
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    internal required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initialize()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    deinit {
        print("deinit LoaderView")
    }
    
    private func initialize() {
        self.backgroundColor = .clear
        guard let xibView = Bundle.main.loadNibNamed("LoaderView", owner: self, options: nil)?.first as? UIView else { return }
        
        self.addSubview(xibView)
        
        xibView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([
            NSLayoutConstraint.init(item: xibView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: xibView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: xibView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: xibView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
            ])
        
        contentView = xibView
        setSpinnerLottie()
    }
}

extension LoaderView {
    public func hide(completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            if self.superview == nil {
                completion?()
                return
            }
        }
        
        let task: () -> () = {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
//                self.contentView?.alpha = 0
            }) { (finished) in
                DispatchQueue.main.async {
                    completion?()
                    self.removeFromSuperview()
                }
            }
        }
        
        if Thread.isMainThread {
            task()
        } else {
            DispatchQueue.main.async {
                task()
            }
        }
    }
    
    func show(completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            if self.superview != nil {
                completion?()
                return
            }
        }
        let task: () -> () = {
            let rootWindow = UIApplication.shared.keyWindow
            self.frame = (rootWindow?.bounds)!
            UIApplication.shared.keyWindow?.addSubview(self)
            UIApplication.shared.keyWindow?.bringSubviewToFront(self)
            
//            self.contentView?.alpha = 0
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
//                self.contentView?.alpha = 1
            }) { (_) in
                DispatchQueue.main.async {
                    completion?()
                }
            }
            self.layoutIfNeeded()
        }
        
        if Thread.isMainThread {
            task()
        } else {
            DispatchQueue.main.async {
                task()
            }
        }
    }
}

extension LoaderView {
    private func setSpinnerLottie() {
    }
}

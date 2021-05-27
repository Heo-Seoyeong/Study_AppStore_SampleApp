//
//  BaseViewController.swift
//  appStore
//
//  Created by seoyeong on 2021/05/24.
//

import UIKit

import RxCocoa
import RxSwift

class BaseViewController: UIViewController {
    
    let bag = DisposeBag()
    
    private var topSeparatorView: UIView?
    private var bottomSeparatorView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpObservers()
        initUI()
        setUpGestures()
        
        navigationController?.isNavigationBarHidden = false
    }
    
    func setUpObservers() {
    }
    
    func initUI() {
    }
    
    func setUpGestures() {
    }
    
    func setUpBaseObservers(baseViewModel: BaseViewModel) {
        baseViewModel.toastMessage.listen(bag: bag, onNext: showToastMessage)
        baseViewModel.networkFailure.listen(bag: bag, onNext: showNetworkFailure)
    }
    
    private func showToastMessage(message: String) {
        
    }
    
    private func showNetworkFailure(failure: ApiFailure) {
        let alert = UIAlertController(title: "오류", message: failure.errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func addAction(to button: UIButton, _ onCompleted: @escaping () -> Void) {
        button.rx.tap.bind { _ in
            onCompleted()
        }.disposed(by: bag)
    }
    
    func addAction(to view: UIView, type: UIGestureRecognizer.type = .tap, _ onCompleted: @escaping () -> Void) {
        let gesture = type.value
        view.addGestureRecognizer(gesture)
        gesture.rx.event.bind { _ in
            onCompleted()
        }.disposed(by: bag)
    }
    
}

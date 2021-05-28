//
//  ListViewController.swift
//  appStore
//
//  Created by seoyeong on 2021/05/24.
//

import UIKit

import RxCocoa
import RxSwift
import RxDataSources

class ListViewController: BaseViewController {
    
    private let vm = ListViewModel()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func setUpObservers() {
        super.setUpObservers()
        
        super.setUpBaseObservers(baseViewModel: vm)
        
        self.vm.dto.listen(bag: bag) { [weak self] dto in
            guard let self = self else { return }
            
            let listDataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, ListViewModel.ListInfo>>(configureCell: { _, tableView, indexPath, item in
                switch item {
                case let .recent(history):
                    let cell = tableView.dequeueReusableCell(withIdentifier: "RecentHistoryCell", for: indexPath) as! RecentHistoryCell
                    cell.set(history)
                    return cell
                case let .search(app):
                    let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as! SearchResultCell
                    cell.bind(app)
                    return cell
                case .noresult:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "RecentHistoryCell", for: indexPath) as! RecentHistoryCell
                    cell.set("")
                    return cell
                }
            })

            Observable.of(dto)
                .bind(to: self.tableView.rx.items(dataSource: listDataSource))
                .disposed(by: self.bag)
        }
    }
    
    override func setUpGestures() {
        searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .debounce(.microseconds(1), scheduler: MainScheduler.instance)
            .bind(onNext: { self.vm.action(name: $0) } )
            .disposed(by: bag)

        searchBar.rx.textDidBeginEditing
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.searchBar.showsCancelButton = true
                })
            }).disposed(by: bag)

        searchBar.rx.cancelButtonClicked
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                
                UIView.animate(withDuration: 0.05, animations: {
                    self.searchBar.showsCancelButton = false
                })
                
                self.searchBar.text?.removeAll()
                self.vm.action()
            }).disposed(by: bag)

        searchBar.rx.searchButtonClicked
            .subscribe(onNext: { [weak self] in
                guard let self = self,
                      let name = self.searchBar.text else {
                    return
                }
                self.view.endEditing(true)
                self.vm.action(name: name)
            }).disposed(by: bag)
        
        searchBar.rx.text.orEmpty
            .debounce(RxTimeInterval.microseconds(5), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { searchText in
                self.vm.action(name: searchText)
            })
            .disposed(by: bag)
    }
    
}

extension ListViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = DetailViewController()
//        vc.bind(DetailDTO(vm.dto.value[indexPath.row]))
//        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ListViewController: UISearchBarDelegate {
    
    
    
}

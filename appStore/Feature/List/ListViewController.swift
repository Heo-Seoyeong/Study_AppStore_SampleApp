//
//  ListViewController.swift
//  appStore
//
//  Created by seoyeong on 2021/05/24.
//

import UIKit

enum ListRow {
    case recent
    case searching
    case result
}

class ListViewController: BaseViewController {
    
    private let vm = ListViewModel()

    @IBOutlet weak var tableView: UITableView!
    
    override func setUpObservers() {
        super.setUpObservers()
        
        super.setUpBaseObservers(baseViewModel: vm)
        
        vm.dto.listen(bag: bag) { [weak self] dto in
            guard let self = self else { return}
            self.tableView.reloadData()
        }
    }

}

extension ListViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        vm.fetchHomeData()
    }
    
}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.dto.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)
        if let cell = cell as? SearchResultCell {
            cell.bind(vm.dto.value[indexPath.row])
        }
        return cell
    }
    
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let dto
//        let brand = self.vm.dto.value.subBrands[indexPath.row]
//        LogEvent.BRANDSHOP_Tab_TextBrand.value("no\(indexPath.row)_\(brand.brandNameEng.convertGA)").selectContent()
//        let productsViewController = ProductsViewController(title: brand.name, mode: .stickyFilter, contentType: .brand(brand.id))
//        self.parent?.navigationController?.pushViewController(productsViewController, animated: true)
    }
    
}

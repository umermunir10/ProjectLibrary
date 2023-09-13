//
//  BookFiltersViewController.swift
//  projectLibrary
//
//  Created by Umer Munir on 25/08/2023.
//

import UIKit

class BookFiltersViewController: UIViewController {

    @IBOutlet var constraintCollection: [NSLayoutConstraint]!
    
    @IBOutlet weak var BookFiltersTableView: UITableView!
    
    var filters = BookFilter.getFilters()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCell()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.tintColor = UIColor(named: "K10B269")
    }
    
    func registerCell() {
        
        self.BookFiltersTableView.register(UINib(nibName: "BookFilterTableViewCell", bundle: nil), forCellReuseIdentifier: "BookFilterTableViewCell")
    }
}

extension BookFiltersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = BookFiltersTableView.dequeueReusableCell(withIdentifier: "BookFilterTableViewCell", for: indexPath) as! BookFilterTableViewCell
        cell.configureCell(self.filters[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Collections" : ""
    }
}

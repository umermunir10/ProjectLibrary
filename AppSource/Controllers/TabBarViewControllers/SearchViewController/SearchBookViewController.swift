//
//  SearchBookViewController.swift
//  projectLibrary
//
//  Created by Umer Munir on 24/08/2023.
//

import UIKit

class SearchBookViewController: UIViewController {

    @IBOutlet var constraintCollection: [NSLayoutConstraint]!
    @IBOutlet weak var searchBookTableView: UITableView!
    
    var bookSelectionDelegate: BookSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
    }
    
    func registerCell() {
        
        self.searchBookTableView.register(UINib(nibName: "SearchBookTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchBookTableViewCell")
    }
}

extension SearchBookViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchBookTableView.dequeueReusableCell(withIdentifier: "SearchBookTableViewCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

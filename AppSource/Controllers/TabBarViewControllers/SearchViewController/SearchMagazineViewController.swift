//  SearchMagazineViewController.swift
//  projectLibrary
//
//  Created by Umer Munir on 24/08/2023.

import UIKit

class SearchMagazineViewController: UIViewController {

    @IBOutlet var constraintCollection: [NSLayoutConstraint]!
    @IBOutlet weak var searchMagazineTableView: UITableView!
    
    var magazineSelecionDelegate: MagazineSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCell()
        
    }
    
    func registerCell() {
        
        self.searchMagazineTableView.register(UINib(nibName: "SearchMagazineTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchMagazineTableViewCell")
    }
}

extension SearchMagazineViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchMagazineTableView.dequeueReusableCell(withIdentifier: "SearchMagazineTableViewCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension 
    }
}

//
//  LibraryMagazineViewController.swift
//  projectLibrary
//
//  Created by Umer Munir on 21/08/2023.
//

import UIKit

class LibraryMagazineViewController: UIViewController {
    
    @IBOutlet var constraintCollection: [NSLayoutConstraint]!
    @IBOutlet weak var libraryMagazineTableView: UITableView!
    
    var magazineSelectionDelegate: MagazineSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    
    
    func registerCell() {
        
        self.libraryMagazineTableView.register(UINib(nibName: "LibraryMagazineTableViewCell", bundle: nil), forCellReuseIdentifier: "LibraryMagazineTableViewCell")
    }
}

extension LibraryMagazineViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = libraryMagazineTableView.dequeueReusableCell(withIdentifier: "LibraryMagazineTableViewCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


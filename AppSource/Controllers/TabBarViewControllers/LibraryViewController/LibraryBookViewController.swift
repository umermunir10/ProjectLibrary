//
//  LibraryBookViewController.swift
//  projectLibrary
//
//  Created by Umer Munir on 21/08/2023.
//

import UIKit

class LibraryBookViewController: UIViewController {

    @IBOutlet var constraintCollection: [NSLayoutConstraint]!
    @IBOutlet var viewCollection: [UIView]!
    @IBOutlet var labelCollection: [UILabel]!
    @IBOutlet var buttonCollection: [UIButton]!
    @IBOutlet weak var LibraryBookTableView: UITableView!
    
    var libraryBooksDelegate: LibraryBooksDelegate?
    var bookSelectionDelegate: BookSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCell()
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    func registerCell() {
        
        self.LibraryBookTableView.register(UINib(nibName: "LibraryBookTableViewCell", bundle: nil), forCellReuseIdentifier: "LibraryBookTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func moveToBookFilterVC() {
        
        let vc = BookFiltersViewController.instantiate(storyboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func bookFilterButton(_ sender: Any) {
        
        moveToBookFilterVC()
    }
}

extension LibraryBookViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LibraryBookTableView.dequeueReusableCell(withIdentifier: "LibraryBookTableViewCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension   }
}

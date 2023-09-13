//
//  ReadingViewController.swift
//  projectLibrary
//
//  Created by Umer Munir on 21/08/2023.
//

import UIKit

protocol MagazineSelectionDelegate {
    func onMagazineSelection(_ magazine: Book)
}

protocol BookSelectionDelegate {
    func onBookSelection(_ book: Book)
}


class ReadingViewController: UIViewController {

    @IBOutlet var constraintCollection: [NSLayoutConstraint]!
    @IBOutlet var labelCollection: [UILabel]!
    @IBOutlet weak var readingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.readingTableView.register(UINib(nibName: "ReadingGoalsTableViewCell", bundle: nil), forCellReuseIdentifier: "readingGoals")
    }
}

extension ReadingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = readingTableView.dequeueReusableCell(withIdentifier: "readingGoals", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

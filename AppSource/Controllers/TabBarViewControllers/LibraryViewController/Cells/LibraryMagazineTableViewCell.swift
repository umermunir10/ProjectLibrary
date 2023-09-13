//
//  LibraryMagazineTableViewCell.swift
//  projectLibrary
//
//  Created by Umer Munir on 24/08/2023.
//

import UIKit

class LibraryMagazineTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.mainView.layer.cornerRadius = 17
    }
}

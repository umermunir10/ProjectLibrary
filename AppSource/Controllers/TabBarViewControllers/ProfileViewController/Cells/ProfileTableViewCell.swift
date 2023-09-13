//
//  ProfileTableViewCell.swift
//  projectLibrary
//
//  Created by Umer Munir on 22/08/2023.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.mainView.layer.cornerRadius = 10
    }
    
}

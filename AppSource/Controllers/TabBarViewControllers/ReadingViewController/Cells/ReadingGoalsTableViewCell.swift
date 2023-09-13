//
//  ReadingGoalsTableViewCell.swift
//  projectLibrary
//
//  Created by Umer Munir on 21/08/2023.
//

import UIKit

class ReadingGoalsTableViewCell: UITableViewCell {

    @IBOutlet weak var viewReading: UIView!
    @IBOutlet weak var cardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.viewReading.layer.cornerRadius = 17.5
        self.cardView.layer.cornerRadius = 12
    }
}

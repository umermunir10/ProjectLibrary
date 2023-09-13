//
//  BookFilterTableViewCell.swift
//  projectLibrary
//
//  Created by Umer Munir on 25/08/2023.
//

import UIKit

class BookFilterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configureCell(_ data: BookFilter) {
        
        self.labelTitle.text = data.filter
        
    }
}

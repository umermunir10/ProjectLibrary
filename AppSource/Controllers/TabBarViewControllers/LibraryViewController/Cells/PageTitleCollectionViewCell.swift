//
//  PageTitleCollectionViewCell.swift
//  projectLibrary
//
//  Created by Umer Munir on 21/08/2023.
//

import UIKit

class PageTitleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectionView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //selectionView.isHidden = true
    }

    func configureCell(_ headerData: HeaderData) {
        
        
        titleLabel.text = headerData.title
        selectionView.backgroundColor = headerData.isSelected ? UIColor(named: "K10B269") : UIColor.clear
//        titleLabel.font = UIFont.SFProText(headerData.isSelected ? .bold : .regular, withSize: 20)
        
    }
    
}

//
//  CarCategoryCell.swift
//  CarRentalApp2.0
//
//  Created by Ziyadkhan on 30.10.23.
//

import UIKit

class CarCategoryCell: UICollectionViewCell {
    @IBOutlet weak var carCategoryImage: UIImageView!
    @IBOutlet weak var carCategoryCount: UILabel!
    @IBOutlet weak var carCategoryName: UILabel!
    @IBOutlet weak var background: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        background.layer.cornerRadius = 20
    }
    
    func selectItem() {
        background.backgroundColor = .mainBG
        carCategoryName.textColor = .white
        carCategoryCount.textColor = .white
    }
    
    func deSelectItem() {
        background.backgroundColor = .white
        carCategoryName.textColor = .black
        carCategoryCount.textColor = .lightGray
    }
}



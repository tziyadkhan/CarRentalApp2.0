//
//  CarListCell.swift
//  CarRentalApp2.0
//
//  Created by Ziyadkhan on 30.10.23.
//

import UIKit

class CarListCell: UICollectionViewCell {

    @IBOutlet weak var background: UIView!
    @IBOutlet weak var carEngineLabel: UILabel!
    @IBOutlet weak var carModelLabel: UILabel!
    @IBOutlet weak var carPriceLabel: UILabel!
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var carImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        background.layer.cornerRadius = 20
    }

}

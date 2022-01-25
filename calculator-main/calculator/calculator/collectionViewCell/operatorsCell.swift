//
//  operatorsCell.swift
//  calculator
//
//  Created by Mohamed Elboraey on 22/01/2022.
//

import UIKit

class operatorsCell: UICollectionViewCell {
    @IBOutlet weak var operationLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        operationLB.layer.borderWidth = 0.5
        operationLB.layer.borderColor = UIColor.black.cgColor
    }

}

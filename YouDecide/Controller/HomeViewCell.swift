//
//  HomeViewCell.swift
//  YouDecide
//
//  Created by Dhara Bhavsar on 2022-06-20.
//

import Foundation
import UIKit

class HomeViewCell: UICollectionViewCell {

    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeImg: UIImageView!

    static let reuseIdentifier = "HomeViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        debugPrint("commonInit")
    }
}

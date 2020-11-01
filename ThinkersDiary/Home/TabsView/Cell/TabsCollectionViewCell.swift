//
//  TabsCollectionViewCell.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 01/11/20.
//

import UIKit

class TabsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellView: UIView!
    var color : UIColor? {
        didSet {
            cellView.backgroundColor = color
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

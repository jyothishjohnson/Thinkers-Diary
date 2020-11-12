//
//  TabsCollectionViewCell.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 01/11/20.
//

import UIKit

class TabsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cellName: UILabel!
    var color : UIColor? {
        didSet {
            cellView.backgroundColor = color
        }
    }
    
    var cellNameText : String? {
        didSet {
            cellName.text = cellNameText
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func removeWhite(){
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.cellView.backgroundColor = .black
            self.cellName.textColor = .white
        }
    }

    func addWhite(){
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
            self.cellView.backgroundColor = .white
            self.cellName.textColor = .black
        }
    }
}

//
//  TabsCollectionViewCell.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 01/11/20.
//

import UIKit

class TabsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cellNameLabel: UILabel!
    var color : UIColor? {
        didSet {
            cellView.backgroundColor = color
        }
    }
    
    var cellNameText : String? {
        didSet {
            cellNameLabel.text = cellNameText
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
        self.cellNameLabel.textColor = .black
        self.cellView.layer.cornerRadius = 16
        // Initialization code
    }
    
    func removeColor(){
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
            self.cellView.backgroundColor = .white
            self.cellNameLabel.textColor = .black
        }
    }

    func addColor(){
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.cellView.backgroundColor = .black
            self.cellNameLabel.textColor = .white
        }
    }
}

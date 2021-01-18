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
    
    var cellNameText : String? {
        didSet {
            cellNameLabel.text = cellNameText
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .systemBackground
        self.cellNameLabel.textColor = UIColor.color(.TabCellLabelColor)
        self.cellView.layer.cornerRadius = 16
        self.cellView.backgroundColor = UIColor.color(.TabCellColor)
    }
    
    func removeColor(){
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) { [weak self] in
            self?.cellView.backgroundColor =  UIColor.color(.TabCellColor)
            self?.cellNameLabel.textColor = UIColor.color(.TabCellLabelColor)
        }
    }

    func addColor(duration : TimeInterval = 0.0){
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut) { [weak self] in
            self?.cellView.backgroundColor = .black
            self?.cellNameLabel.textColor = .white
        }
    }
}

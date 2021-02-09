//
//  TabsCollectionViewCell.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 01/11/20.
//

import UIKit

class TabsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var iconName : String? {
        didSet{
            iconImageView.image = UIImage(systemName: iconName ?? "")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
    }
    
    func removeColor(){
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) { [weak self] in
            self?.iconImageView.tintColor = .darkGray
        }
    }

    func addColor(duration : TimeInterval = 0.0){
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut) { [weak self] in
            self?.iconImageView.tintColor = .systemBlue
        }
    }
}

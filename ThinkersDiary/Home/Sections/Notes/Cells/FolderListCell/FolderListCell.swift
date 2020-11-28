//
//  FolderListCell.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 26/11/20.
//

import UIKit

class FolderListCell: UITableViewCell {

    @IBOutlet weak var folderNameLabel: UILabel!
    
    var folderName : String? {
        didSet {
            self.folderNameLabel.text = folderName
        }
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.selectionStyle = .none
    }
}

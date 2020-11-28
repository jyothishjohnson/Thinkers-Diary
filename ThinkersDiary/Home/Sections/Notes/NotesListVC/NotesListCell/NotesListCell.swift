//
//  NotesListCell.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 14/11/20.
//

import UIKit

class NotesListCell: UITableViewCell {

    @IBOutlet weak var noteTitleLabel: UILabel!
    
    var noteTitle : String? {
        didSet {
            noteTitleLabel.text = noteTitle ?? ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
}

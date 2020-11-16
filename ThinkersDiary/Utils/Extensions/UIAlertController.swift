//
//  UIAlertController.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 14/11/20.
//

import UIKit

extension UIAlertController {
    
    static func promptForFolderName(_ completion : @escaping (String?) -> ()) -> UIAlertController{
        
        let ac = UIAlertController(title: "Enter folder name", message: nil, preferredStyle: .alert)
        ac.addTextField { (textField) in
            textField.autocapitalizationType = .words
        }
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
            let folderTF = ac.textFields![0]
            let folderName = folderTF.text
            if folderName != nil && !(folderName?.isEmpty ?? true) {
                completion(folderName)
            }
        }
        
        ac.addAction(submitAction)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        return ac
    }
}

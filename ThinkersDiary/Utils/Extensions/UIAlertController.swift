//
//  UIAlertController.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 14/11/20.
//

import UIKit

extension UIAlertController {
    
    static func prompt(title: String, _ submitText: String = "Submit",
                       _ completion : @escaping (String?) -> ()) -> UIAlertController{
        
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        ac.addTextField { (textField) in
            textField.autocapitalizationType = .words
        }
        
        let submitAction = UIAlertAction(title: submitText, style: .default) { [unowned ac] _ in
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
    
    static func showMessage(title: String, _ message : String = "Unknown Error",
                            _ completion : (() -> ())?) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }
}

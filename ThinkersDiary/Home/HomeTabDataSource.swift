//
//  HomeTabDataSource.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 01/11/20.
//

import UIKit

class HomeTabDataSource {
    
    var data = [UIViewController?]()
    unowned var parent : UIViewController!
    
    lazy var todoController : UIViewController = {
        
        let controller = NotesViewController(nibName: "NotesViewController", bundle: nil)
        controller.cName = "Notes"
        return controller
    }()
    lazy var reminderController : UIViewController = {
        
        let controller = NotesViewController(nibName: "NotesViewController", bundle: nil)
        controller.cName = "Reminder"
        return controller
    }()
    lazy var diaryController : UIViewController = {
        
        let controller = NotesViewController(nibName: "NotesViewController", bundle: nil)
        controller.cName = "Diary"
        return controller
    }()
    
    
    
    
    init(_ parent: UIViewController){
        self.parent = parent
        data = [todoController,reminderController,diaryController]
    }
    
}

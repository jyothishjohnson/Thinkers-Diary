//
//  HomeTabDataSource.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 01/11/20.
//

import UIKit

class HomeTabDataSource {
    
    var data = [NotesViewController?]()
    unowned var parent : UIViewController!
    
    lazy var todoController : NotesViewController = {
        
        let controller = NotesViewController(nibName: "NotesViewController", bundle: nil)
        controller.cName = "Notes"
        return controller
    }()
    lazy var reminderController : NotesViewController = {
        
        let controller = NotesViewController(nibName: "NotesViewController", bundle: nil)
        controller.cName = "Reminder"
        return controller
    }()
    lazy var diaryController : NotesViewController = {
        
        let controller = NotesViewController(nibName: "NotesViewController", bundle: nil)
        controller.cName = "Diary"
        return controller
    }()
    
    
    
    
    init(_ parent: UIViewController){
        self.parent = parent
        data = [todoController,reminderController,diaryController]
    }
    
}

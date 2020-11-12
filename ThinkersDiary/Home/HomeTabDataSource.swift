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
    
    lazy var todoController : NotesViewController = {
        
        let controller = NotesViewController(nibName: "NotesViewController", bundle: nil)
        controller.title = "Notes"
        return controller
    }()
    lazy var reminderController : NotesViewController = {
        
        let controller = NotesViewController(nibName: "NotesViewController", bundle: nil)
        controller.title = "Reminder"
        return controller
    }()
    lazy var diaryController : NotesViewController = {
        
        let controller = NotesViewController(nibName: "NotesViewController", bundle: nil)
        controller.title = "Diary"
        return controller
    }()
    
    
    
    
    init(_ parent: UIViewController){
        self.parent = parent
        data = [todoController,reminderController,diaryController]
    }
    
}

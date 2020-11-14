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
    
    lazy var notesController : UIViewController = {
        
        let controller = NotesViewController(nibName: "NotesViewController", bundle: nil)
        controller.title = "Notes"
        return controller
    }()
    lazy var reminderController : UIViewController = {
        
        let controller = RemindersViewController(nibName: "RemindersViewController", bundle: nil)
        controller.title = "Reminder"
        return controller
    }()
    lazy var diaryController : UIViewController = {
        
        let controller = RemindersViewController(nibName: "RemindersViewController", bundle: nil)
        controller.title = "Diary"
        return controller
    }()
    lazy var profileController : UIViewController = {
        
        let controller = RemindersViewController(nibName: "RemindersViewController", bundle: nil)
        controller.title = "Profile"
        return controller

    }()
    
    
    
    
    init(_ parent: UIViewController){
        self.parent = parent
        data = [notesController,reminderController,diaryController,profileController]
    }
    
}

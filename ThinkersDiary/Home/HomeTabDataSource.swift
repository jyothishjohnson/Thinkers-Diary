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
    
    lazy var notesController : UINavigationController = {
        
        let controller = NotesFolderViewController(nibName: "NotesFolderViewController", bundle: nil)
        controller.title = "Notes"
        let navController = UINavigationController(rootViewController: controller)
        navController.navigationBar.isHidden = true
        return navController
    }()
    lazy var reminderController : UINavigationController = {
        
        let controller = RemindersViewController(nibName: "RemindersViewController", bundle: nil)
        controller.title = "Reminders"
        let navController = UINavigationController(rootViewController: controller)
        navController.navigationBar.isHidden = true
        return navController
    }()
    lazy var diaryController : UINavigationController = {
        
        let controller = RemindersViewController(nibName: "RemindersViewController", bundle: nil)
        controller.title = "Diary"
        let navController = UINavigationController(rootViewController: controller)
        navController.navigationBar.isHidden = true
        return navController
    }()
    lazy var profileController : UINavigationController = {
        
        let controller = RemindersViewController(nibName: "RemindersViewController", bundle: nil)
        controller.title = "Profile"
        let navController = UINavigationController(rootViewController: controller)
        navController.navigationBar.isHidden = true
        return navController

    }()
    
    
    
    
    init(_ parent: UIViewController){
        self.parent = parent
        data = [notesController,reminderController,diaryController,profileController]
    }
    
}

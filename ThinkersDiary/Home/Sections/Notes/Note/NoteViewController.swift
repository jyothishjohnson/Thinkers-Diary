//
//  NoteViewController.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 07/12/20.
//

import UIKit
import PencilKit

class NoteViewController: UIViewController, PKToolPickerObserver{

    @IBOutlet weak var canvas: PKCanvasView!
    @IBOutlet weak var headerView: HeaderView!
    
    var toolPicker: PKToolPicker?
    
    var drawingHasChanged = false
    var noteId : String!
    var content : Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        canvas.alwaysBounceVertical = true
        canvas.bounces = true
        
        if let content = content {
            do {
                try canvas.drawing = PKDrawing(data: content)
            }catch {
                print(error.localizedDescription)
            }
        }
        canvas.delegate = self
        canvas.alwaysBounceHorizontal = true
        canvas.setZoomScale(100, animated: true)
        
        if #available(iOS 14.0, *) {
            toolPicker = PKToolPicker()
        } else {
            
            let window = parent?.view.window
            toolPicker = PKToolPicker.shared(for: window!)
        }
        
        toolPicker?.setVisible(true, forFirstResponder: canvas)
        toolPicker?.addObserver(canvas)
        toolPicker?.addObserver(self)
        if let toolPicker = toolPicker {
            updateLayout(for: toolPicker)
        }
        canvas.allowsFingerDrawing = true
        canvas.becomeFirstResponder()
        navigationItem.leftItemsSupplementBackButton = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        toolPicker = nil
        canvas.resignFirstResponder()
        if drawingHasChanged {
            uploadUpdatedDrawing()
        }
    }
    
    func setUpView(){
        setUpHeaderView()
    }
    
    func setUpHeaderView(){
        headerView.leftButtonImageName = ("chevron.left", true)
        headerView.leftButtonAction = { [unowned self] in
            print("left button")
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func updateLayout(for toolPicker: PKToolPicker) {
        let obscuredFrame = toolPicker.frameObscured(in: view)
        
        // If the tool picker is floating over the canvas, it also contains
        // undo and redo buttons.
        if obscuredFrame.isNull {
            canvas.contentInset = .zero
            navigationItem.leftBarButtonItems = []
        }
        
        // Otherwise, the bottom of the canvas should be inset to the top of the
        // tool picker, and the tool picker no longer displays its own undo and
        // redo buttons.
        else {
            canvas.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: view.bounds.maxY - obscuredFrame.minY, right: 0)
            //            navigationItem.leftBarButtonItems = [undoBarButtonitem, redoBarButtonItem]
        }
        canvas.scrollIndicatorInsets = canvas.contentInset
    }
    
    func updateContentSizeForDrawing() {
        // Update the content size to match the drawing.
        let drawing = canvas.drawing
        let contentHeight: CGFloat
        
        // Adjust the content size to always be bigger than the drawing height.
        if !drawing.bounds.isNull {
            contentHeight = max(canvas.bounds.height, (drawing.bounds.maxY + 400) * canvas.zoomScale)
        } else {
            contentHeight = canvas.bounds.height
        }
        canvas.contentSize = CGSize(width: 750 * canvas.zoomScale, height: contentHeight)
    }
}

//MARK: - Save Drawing

extension NoteViewController {
    
    func uploadUpdatedDrawing(){
        
        let data : Data = canvas.drawing.dataRepresentation()
        
        let note = UpdateNoteDrawing(id: noteId, content: data)
        
        let noteData = try? JSONEncoder().encode(note)
        
        let url = URL(string: "\(EP.ipBaseURL)\(EP.updateNoteDrawing)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = NetworkMethods.PUT.rawValue
        request.httpBody = noteData
        
        NetworkManager.shared.makeRequest(request) { (result: Result<Int, NetworkManagerError>) in
            
            switch result {
            
            case .success(let statusCode):
                
                print(statusCode)
                
            case .failure(_):
                print()
            }
        }
        
        
    }
}

//MARK: - PKCanvasViewDelegate

extension NoteViewController: PKCanvasViewDelegate{
    
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        drawingHasChanged = true
        updateContentSizeForDrawing()
    }
}

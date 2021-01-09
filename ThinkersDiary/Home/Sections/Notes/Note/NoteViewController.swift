//
//  NoteViewController.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 07/12/20.
//

import UIKit
import PencilKit

class NoteViewController: UIViewController, PKCanvasViewDelegate, PKToolPickerObserver{

    @IBOutlet weak var canvas: PKCanvasView!
    @IBOutlet weak var headerView: HeaderView!
    
    var toolPicker: PKToolPicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        canvas.delegate = self
//        canvas.drawing = dataModelController.drawings[drawingIndex]
        canvas.alwaysBounceVertical = true
        canvas.bounces = true
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

extension NoteViewController {
    
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        updateContentSizeForDrawing()
    }
}

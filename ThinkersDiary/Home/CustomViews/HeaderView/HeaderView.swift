//
//  HeaderView.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 28/12/20.
//

import UIKit

class HeaderView: UIView {
    
    @IBOutlet var rootView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var rightButton: UIButton!
    
    var buttonAction : (() -> ())?
    var rightButtonImageName : (name: String,isSystemImage: Bool)? {
        didSet {
            if rightButtonImageName?.isSystemImage ?? true {
                rightButton.setImage(UIImage(systemName: rightButtonImageName?.name ?? ""), for: .normal)
            }else {
                rightButton.setImage(UIImage(named: rightButtonImageName?.name ?? ""), for: .normal)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }

    @IBAction func rightButtonAction(_ sender: UIButton) {
        print(#function)
        if let buttonAction = buttonAction{
            buttonAction()
        }
    }
    
    func setUpView(){
        Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)
        addSubview(rootView)
        rootView.frame = self.bounds
        rootView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}

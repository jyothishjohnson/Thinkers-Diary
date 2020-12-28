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
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }

    @IBAction func rightButtonAction(_ sender: UIButton) {
        print(#function)
    }
    
    func setUpView(){
        Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)
        addSubview(rootView)
        rootView.frame = self.bounds
        rootView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}

//
//  TabsView.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 01/11/20.
//

import UIKit

protocol TabsMenuDelegate: class{
    
    func menuDidSelect(position : Int)
}

class TabsView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var containerView: UIView!
    
    var datasource : (tabs: [String], icons: [String]) = ([],[]) {
        didSet {
            print(datasource)
        }
    }
    
    var currentIndexPath : IndexPath?
    weak var delegate : TabsMenuDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    
    func initView(){
        
        initContainer()
        registerCell()
    }
    
    func initContainer(){
        Bundle.main.loadNibNamed("TabsView", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    }
    
    func registerCell(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "TabsCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "TabsCollectionViewCell")
        collectionView.isScrollEnabled = false
    }
}


extension TabsView : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        datasource.tabs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabsCollectionViewCell", for: indexPath) as! TabsCollectionViewCell
        cell.cellNameText = datasource.tabs[indexPath.row]
        cell.iconName = datasource.icons[indexPath.row]
        if indexPath.row == 0 {
            cell.addColor()
            currentIndexPath = indexPath
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width / CGFloat(datasource.tabs.count)
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let previousIndexPath = currentIndexPath {
            let cell = collectionView.cellForItem(at: previousIndexPath) as? TabsCollectionViewCell
            cell?.removeColor()
        }
        
        let cell = collectionView.cellForItem(at: indexPath) as? TabsCollectionViewCell
        cell?.addColor(duration: 0.3)
        delegate?.menuDidSelect(position: indexPath.row)
        
        currentIndexPath = indexPath
    }
}

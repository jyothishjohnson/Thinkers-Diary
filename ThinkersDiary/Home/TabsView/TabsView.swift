//
//  TabsView.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 01/11/20.
//

import UIKit

class TabsView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var containerView: UIView!
    
    var datasource : [NotesViewController?] = []
    
    var currentIndexPath : IndexPath?
        
    // MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    
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
        print(collectionView.frame)
        print(containerView.frame)
    }
    
    func registerCell(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "TabsCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "TabsCollectionViewCell")
    }
}


extension TabsView {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabsCollectionViewCell", for: indexPath) as! TabsCollectionViewCell
        cell.cellNameText = datasource[indexPath.row]?.cName
        
        if indexPath.row == 0 {
            cell.addColor()
            currentIndexPath = indexPath
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width / CGFloat(datasource.count)
        let height = collectionView.frame.height
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        
        if let iPath = currentIndexPath {
            let cell = collectionView.cellForItem(at: iPath) as? TabsCollectionViewCell
            cell?.removeColor()
        }
        
        let cell = collectionView.cellForItem(at: indexPath) as? TabsCollectionViewCell
        cell?.addColor()
        
        currentIndexPath = indexPath
    }
}

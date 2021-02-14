//
//  EventsDemoViewController.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 13/02/21.
//

import UIKit

class EventsDemoViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Usable>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureDataSource()
        applyInitialSnapshots()
    }
    
    func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
    }
    
    func createLayout() -> UICollectionViewLayout {
        
        let sectionProvider :(Int, NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? = {
            sectionIndex, layoutenv in
            
            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
            
            let section: NSCollectionLayoutSection
            
            switch sectionKind {
            
            case .destinations:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(0.2))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            case .countries:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.2))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
            }
            return section
        }
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
    
    func configureDataSource() {
        
                
        dataSource = UICollectionViewDiffableDataSource<Section,Usable>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, usable) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section") }
            
            switch section {
    
            case .destinations:
                return collectionView.dequeueConfiguredReusableCell(using: self.configuredGridCell(), for: indexPath, item: (usable as! DestinationCities))
            case .countries:
                return collectionView.dequeueConfiguredReusableCell(using: self.configuredListCell(), for: indexPath, item: (usable as! Country))

            }
        })


        
    }
    
    func configuredListCell() -> UICollectionView.CellRegistration<UICollectionViewListCell, Country> {
        return UICollectionView.CellRegistration<UICollectionViewListCell, Country> { (cell, indexPath, item) in
            var content = UIListContentConfiguration.valueCell()
            content.text = item.cName
            cell.contentConfiguration = content
        }
    }
    
    func configuredGridCell() -> UICollectionView.CellRegistration<UICollectionViewCell, DestinationCities> {
        return UICollectionView.CellRegistration<UICollectionViewCell, DestinationCities> { (cell, indexPath, dest) in
            var content = UIListContentConfiguration.cell()
            content.text = dest.destName
            content.textProperties.font = .boldSystemFont(ofSize: 28)
            content.textProperties.alignment = .center
            content.directionalLayoutMargins = .zero
            cell.contentConfiguration = content
            var background = UIBackgroundConfiguration.listPlainCell()
            background.cornerRadius = 8
            background.strokeColor = .systemGray3
            background.strokeWidth = 1.0 / cell.traitCollection.displayScale
            cell.backgroundConfiguration = background
        }
    }
    
    func applyInitialSnapshots(){
        
        let sections = Section.allCases
        var snapshot = NSDiffableDataSourceSnapshot<Section, Usable>()
        snapshot.appendSections(sections)
        dataSource.apply(snapshot, animatingDifferences: false)
        
        let dest = [DestinationCities(name: "DElhi"),DestinationCities(name: "Banglore"), DestinationCities(name: "Kochi"), DestinationCities(name: "Manali")]
        var recentsSnapshot = NSDiffableDataSourceSectionSnapshot<Usable>()
        recentsSnapshot.append(dest)
        dataSource.apply(recentsSnapshot, to: .destinations, animatingDifferences: false)
        
        let countries = [Country(name: "India"), Country(name: "USA"),Country(name: "China")]
        var countrySnapshot = NSDiffableDataSourceSectionSnapshot<Usable>()
        countrySnapshot.append(countries)
        dataSource.apply(countrySnapshot, to: .countries, animatingDifferences: false)
        
    }
}



class Usable: Hashable {
    let name : String
    
    init(name : String){
        self.name = name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func == (lhs: Usable, rhs: Usable) -> Bool {
        lhs.name == rhs.name
    }
}

final class DestinationCities: Usable{
    let destName : String
    
    override init(name: String){
        
        self.destName = name.lowercased()
        super.init(name: name)
    }
}

final class Country: Usable{
    let cName : String
    
    override init(name: String){
        
        self.cName = name.uppercased()
        super.init(name: name)
    }
}

enum Section : Int,CaseIterable {
    case destinations
    case countries
}

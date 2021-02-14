//
//  EventsDemoViewController.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 13/02/21.
//

import UIKit

class EventsDemoViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, DestinationCities>!
    var dataSourceCL: UICollectionViewDiffableDataSource<Section, Country>!

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
//        collectionView.delegate = self
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
        
                
        dataSource = UICollectionViewDiffableDataSource<Section,DestinationCities>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, dest) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section") }
            
            switch section {
    
            case .destinations:
                return collectionView.dequeueConfiguredReusableCell(using: self.configuredGridCell(), for: indexPath, item: dest)
            default:
                return nil

            }
        })
        
        dataSourceCL = UICollectionViewDiffableDataSource<Section,Country>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, country) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section") }

            switch section {

            case .countries:
                return collectionView.dequeueConfiguredReusableCell(using: self.configuredListCell(), for: indexPath, item: country)

            default:
                return nil
            }
        })

        
    }
    
    func configuredListCell() -> UICollectionView.CellRegistration<UICollectionViewListCell, Country> {
        return UICollectionView.CellRegistration<UICollectionViewListCell, Country> { (cell, indexPath, item) in
            var content = UIListContentConfiguration.valueCell()
            content.text = item.name
            cell.contentConfiguration = content
        }
    }
    
    func configuredGridCell() -> UICollectionView.CellRegistration<UICollectionViewCell, DestinationCities> {
        return UICollectionView.CellRegistration<UICollectionViewCell, DestinationCities> { (cell, indexPath, dest) in
            var content = UIListContentConfiguration.cell()
            content.text = dest.name
            content.textProperties.font = .boldSystemFont(ofSize: 38)
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
        var snapshot = NSDiffableDataSourceSnapshot<Section, DestinationCities>()
        var snapshotCL = NSDiffableDataSourceSnapshot<Section, Country>()
        snapshotCL.appendSections(sections)
        snapshot.appendSections(sections)
        dataSource.apply(snapshot, animatingDifferences: false)
        dataSourceCL.apply(snapshotCL, animatingDifferences: false)
        
        let dest = [DestinationCities(name: "DElhi"),DestinationCities(name: "Banglore"), DestinationCities(name: "Kochi"), DestinationCities(name: "Manali")]
        var recentsSnapshot = NSDiffableDataSourceSectionSnapshot<DestinationCities>()
        recentsSnapshot.append(dest)
        dataSource.apply(recentsSnapshot, to: .destinations, animatingDifferences: false)
        
        let countries = [Country(name: "India"), Country(name: "USA"),Country(name: "China")]
        var recentsSnapshotCL = NSDiffableDataSourceSectionSnapshot<Country>()
        recentsSnapshotCL.append(countries)
        dataSourceCL.apply(recentsSnapshotCL, to: .countries, animatingDifferences: false)
        
    }
}


//struct Events: Hashable {
//
//    let recents : [DestinationCities]
//    let list : [Country]
//}

class Usable {

}

class DestinationCities: Usable, Hashable  {
    let name : String
    
    init(name : String){
        self.name = name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func == (lhs: DestinationCities, rhs: DestinationCities) -> Bool {
        lhs.name == rhs.name
    }
}

class Country: Usable, Hashable{
    let name : String
    
    init(name : String){
        self.name = name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func == (lhs: Country, rhs: Country) -> Bool {
        lhs.name == rhs.name
    }
}

enum Section : Int,CaseIterable {
    case destinations
    case countries
}

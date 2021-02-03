//
//  NetworkObserver.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 04/01/21.
//

import Network
import Foundation

protocol ConnectionUpdateDelegate: class{
    func connectionDidUpdate()
}

final class NetworkObserver {
    
    static let shared = NetworkObserver()
    
    let connectionTypes : [NWInterface.InterfaceType] = [.cellular,.wifi,.wiredEthernet]
    
    private let observer = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkObserver")
    
    weak var delegate : ConnectionUpdateDelegate?
    
    var isActive = false
    var isExpensive = false
    var isConstrained = false
    var connectionType = NWInterface.InterfaceType.other
    
    private init(){
        observer.pathUpdateHandler = { [unowned self] path in
            
            self.isActive = path.status == .satisfied
            self.isExpensive = path.isExpensive
            self.isConstrained = path.isConstrained
            self.connectionType = self.connectionTypes.first(where: path.usesInterfaceType(_:)) ?? .other
            
            self.delegate?.connectionDidUpdate()
            
        }
        
        observer.start(queue: queue)
    }
    
}

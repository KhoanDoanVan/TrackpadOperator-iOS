//
//  UDPSender.swift
//  TrackpadOperator-iOS
//
//  Created by Đoàn Văn Khoan on 15/2/25.
//


import Foundation
import Network

class UDPSender {
    
    // MARK: - Properties
    private var destinationIP: String
    private let errorHandler: (Error) -> Void
    
    private var connection: NWConnection?
    
    // MARK: - Init
    init(
        destinationIP: String,
        errorHandler: @escaping (Error) -> Void
    ) {
        self.destinationIP = destinationIP
        self.errorHandler = errorHandler
        
        setupConnection()
    }
    
    // MARK: Setup
    private func setupConnection() {
        connection = NWConnection(
            host: NWEndpoint.Host(destinationIP),
            port: NWEndpoint.Port(integerLiteral: AppConstants.portUDPSender),
            using: .udp
        )
        
        connection?.stateUpdateHandler = { [weak self] stateUpdate in
            
            switch stateUpdate {
                
            case .failed(let error):
                self?.errorHandler(error)
            default:
                break
            }
            
        }
        
        connection?.start(queue: .global())
    }
}

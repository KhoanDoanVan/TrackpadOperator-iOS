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
            port: NWEndpoint.Port(integerLiteral: AppConstants.portUDP),
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
    
    func send(message: String) {
        
        guard let data = message.data(using: .utf8),
              let connection = connection
        else {
            return
        }
        
        connection.send(content: data, completion: .contentProcessed({ error in
            if let error = error {
                print("Send Message UDP Error iOS: \(error.localizedDescription)")
            }
        }))
    }
}

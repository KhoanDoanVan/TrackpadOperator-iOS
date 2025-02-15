//
//  TCPBonjourClinet.swift
//  TrackpadOperator-iOS
//
//  Created by Đoàn Văn Khoan on 15/2/25.
//

import Foundation
import Network


class TCPBonjourClient: NSObject, NetServiceBrowserDelegate, NetServiceDelegate {
    
    // MARK: - Properties
    private var serviceBrowser = NetServiceBrowser()
    private var discoveredServices: [NetService] = []
    var connection: NWConnection?
    
    
    // MARK: - Setup
    /// Start Browsing
    func startBrowsing() {
        serviceBrowser.searchForServices(
            ofType: AppConstants.ofTypeTCPBonjourClient,
            inDomain: AppConstants.inDomainTCPBonjourClient
        )
    }
    
    // MARK: - Methods
    /// Found the connection
    func netServiceBrowser(
        _ browser: NetServiceBrowser,
        didFind service: NetService,
        moreComing: Bool
    ) {
        discoveredServices.append(service)
        service.delegate = self
        /// service.resolve(withTimeout: 5) is called to resolve the service details (e.g., hostname & port).
        service.resolve(withTimeout: 5)
    }
    
    func netServiceDidResolveAddress(_ sender: NetService) {
        if let host = sender.hostName {
            connectToService(host: host)
        }
    }
    
    private func connectToService(host: String) {
        connection = NWConnection(
            host: NWEndpoint.Host(host),
            port: NWEndpoint.Port(integerLiteral: NWEndpoint.Port.IntegerLiteralType(AppConstants.portTCPBonjour)),
            using: .tcp
        )
        
        connection?.start(queue: .main)
        
        
    }
}

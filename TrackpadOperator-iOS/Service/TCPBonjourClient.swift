//
//  TCPBonjourClinet.swift
//  TrackpadOperator-iOS
//
//  Created by Đoàn Văn Khoan on 15/2/25.
//

import Foundation
import Network


class TCPBonjourClient: NSObject, ObservableObject, NetServiceBrowserDelegate, NetServiceDelegate {
    
    // MARK: - Properties
    private var serviceBrowser = NetServiceBrowser()
    private var discoveredServices: [NetService] = []
    var connection: NWConnection?
    
    @Published var receivedMessages: [String] = []
    
    
    // MARK: - Setup
    /// Start Browsing
    func startBrowsing() {
        serviceBrowser.delegate = self
        serviceBrowser.searchForServices(
            ofType: AppConstants.ofTypeTCPBonjourClient,
            inDomain: AppConstants.inDomainTCPBonjourClient
        )
        
        print("Start Browsing from iOS")
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
    
    /// Resolve the address successfully
    func netServiceDidResolveAddress(_ sender: NetService) {
        if let host = sender.hostName {
            connectToService(host: host)
        }
    }
    
    /// Connection by Host
    private func connectToService(host: String) {
        connection = NWConnection(
            host: NWEndpoint.Host(host),
            port: NWEndpoint.Port(integerLiteral: NWEndpoint.Port.IntegerLiteralType(AppConstants.portTCPBonjour)),
            using: .tcp
        )
        
        connection?.start(queue: .main)
        
        receiveMessage()
    }
    
    /// Receive Message
    private func receiveMessage() {
        connection?.receive(
            minimumIncompleteLength: 1,
            maximumLength: 1024
        ) { [weak self] data, _, isComplete, error in
            
            guard let self,
                  error == nil
            else {
                print("Connection closed or error: \(error?.localizedDescription ?? "Unknown Error")")
                return
            }
            
            if let data,
               let message = String(data: data, encoding: .utf8)
            {
                DispatchQueue.main.async {
                    self.receivedMessages.append("Server: \(message)")
                }
            }
            
            if !isComplete {
                /// Callback
                self.receiveMessage()
            } else {
                print("Server disconnected")
            }
        }
    }
    
    /// Send Message
    func sendMessage(_ message: String) {
        let data = message.data(using: .utf8)!
        
        connection?.send(content: data, completion: .contentProcessed({ error in
            print("Error to send Messsage from Client: \(String(describing: error?.localizedDescription))")
        }))
        
        DispatchQueue.main.async {
            self.receivedMessages.append("Client: \(message)")
        }
    }
}

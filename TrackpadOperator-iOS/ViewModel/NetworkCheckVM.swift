//
//  NetworkCheckVM.swift
//  TrackpadOperator-iOS
//
//  Created by Đoàn Văn Khoan on 15/2/25.
//

import SwiftUI
import Network

class NetworkCheckViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var monitor: NWPathMonitor?
    private var queue: DispatchQueue?
    @Published var typeNetwork: TypeNetwork?
    @Published var animationsRunning = false
    
    // MARK: - Init
    init() {
        self.monitor = NWPathMonitor()
        self.queue = DispatchQueue.global(qos: .background)
        
        self.startMonitor()
    }
    
    // MARK: - Methods
    /// Start Check Network
    func startMonitor() {
        monitor?.start(queue: self.queue!)
        
        checkNetworkType()
    }
    
    /// Get Connection Type
    func checkNetworkType() {
        
        monitor?.pathUpdateHandler = { path in
            
            DispatchQueue.main.async { [weak self] in
                if path.status == .satisfied {
                    
                    if path.usesInterfaceType(.wifi) {
                        self?.typeNetwork = .wifi
                    }
                    else if path.usesInterfaceType(.cellular) {
                        self?.typeNetwork = .cellular
                    }
                    
                    withAnimation {
                        self?.animationsRunning = true
                    }
                    
                } else {
                    self?.typeNetwork = .notConnection
                }
            }
            
        }
        
    }
    
    /// Stop Check Network
    func stopMonitor() {
        monitor?.cancel()
    }
    
}

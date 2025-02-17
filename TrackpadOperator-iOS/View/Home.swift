//
//  Home.swift
//  TrackpadOperator-iOS
//
//  Created by Đoàn Văn Khoan on 15/2/25.
//

import SwiftUI

struct Home: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                buttonNetworkChecking()
                buttonConnection()
            }
            .navigationTitle("Trackpad Operator iOS")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    trailingButton()
                }
            }
            .sheet(isPresented: $viewModel.openNetworkSheet) {
                NetworkCheckView()
                    .presentationDetents([.height(200)])
            }
            .fullScreenCover(isPresented: Binding(get: {
                viewModel.scannedIP != nil
            }, set: { _ in })) {
                
                if let ip = viewModel.scannedIP {
                    ControlView(destinationIP: ip)
                }
            }
        }
    }
    
    /// Check network
    func buttonNetworkChecking() -> some View {
        Button {
            viewModel.openNetworkSheet.toggle()
        } label: {
            VStack {
                Image(systemName: "wifi")
                    .foregroundStyle(Color.black)
                    .font(.largeTitle)
                
                Text("Network")
                    .foregroundStyle(Color.black)
                    .bold()
            }
            .padding()
            .background(Color.teal)
            .clipShape(.rect(cornerRadius: 20))
            .shadow(radius: 2, x: 3, y: 5)
        }
    }
    
    /// Connection
    func buttonConnection() -> some View {
        Button {
            viewModel.openConnection.toggle()
        } label: {
            VStack {
                Image(systemName: "rectangle.inset.filled.and.cursorarrow")
                    .foregroundStyle(Color.black)
                    .font(.largeTitle)
                Text("Connection Now")
                    .foregroundStyle(Color.black)
                    .bold()
            }
            .padding()
            .background(Color.teal)
            .clipShape(.rect(cornerRadius: 20))
            .shadow(radius: 2, x: 3, y: 5)
        }
        .fullScreenCover(isPresented: $viewModel.openConnection) {
            QRCodeScannerView(scannedIP: $viewModel.scannedIP)
        }
        .padding()
    }
    
    @ViewBuilder
    func trailingButton() -> some View {
        Button {
            
        } label: {
            Image(systemName: "gearshape.fill")
                .foregroundStyle(Color.black)
        }
    }
}

#Preview {
    Home()
}

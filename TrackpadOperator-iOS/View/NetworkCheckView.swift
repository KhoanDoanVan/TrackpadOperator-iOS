//
//  NetworkCheckView.swift
//  TrackpadOperator-iOS
//
//  Created by Đoàn Văn Khoan on 15/2/25.
//

import SwiftUI
import Network

struct NetworkCheckView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm = NetworkCheckViewModel()
        
    var body: some View {
        NavigationStack {
            VStack {
                
                if vm.typeNetwork != nil,
                   let type = vm.typeNetwork
                {
                    VStack(spacing: 5) {
                        Image(systemName: type.icon)
                            .symbolEffect(.bounce.down, value: vm.animationsRunning)
                        Text(type.title)
                    }
                    .bold()
                    .font(.headline)
                    .foregroundStyle(type.color)
                } else {
                    VStack {
                        ProgressView()
                            .frame(width: 200, height: 200)
                        Text("Waiting to detect type network 👀")
                    }
                }
                
            }
            .navigationTitle("Network")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    doneButton()
                }
            }
            .onAppear {
                vm.startMonitor()
            }
        }
    }
    
    /// Done btn
    func doneButton() -> some View {
        Button {
            vm.stopMonitor()
            dismiss()
        } label: {
            Text("Done")
                .foregroundStyle(Color.teal)
        }
    }
    
}

#Preview {
    NetworkCheckView()
}

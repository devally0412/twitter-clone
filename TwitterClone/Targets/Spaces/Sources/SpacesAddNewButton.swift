//
//  SpacesAddNewButton.swift
//  Spaces
//
//  Created by amos.gyamfi@getstream.io on 9.2.2023.
//  Copyright © 2023 Stream.io Inc. All rights reserved.
//

import SwiftUI


public struct SpacesCircularButton: View {
    public init(spacesViewModel: SpacesViewModel) {
        self.spacesViewModel = spacesViewModel
    }
    
    public struct SpacesAddNewButton: View {
        public init() {}
        @State private var isCreatingSpace = false
        
        @Environment(\.colorScheme) var colorScheme
        
        @ObservedObject var spacesViewModel: SpacesViewModel
        
        @State private var showingSheet = false
        
        public var body: some View {
            Button {
                
                showingSheet = true
            } label: {
                Image(systemName: "mic.badge.plus")
                    .symbolRenderingMode(.multicolor)
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 46, height: 46)
                    .background(
                        LinearGradient.blueish(for: colorScheme),
                        in: Circle()
                    )
            }
            .sheet(isPresented: $showingSheet) {
                CreateSpaceView(spacesViewModel: spacesViewModel)
                
                isCreatingSpace.toggle()
            } label: {
                Image("spacesNewIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 46, height: 46)
                
                /*ZStack { // optimized for both dark and light modes
                 LinearGradient(gradient: Gradient(colors: [colorScheme == .light ? .streamLightStart : .streamDarkStart, colorScheme == .light ? .streamLightEnd : .streamDarkEnd]), startPoint: .top, endPoint: .bottom)
                 .frame(width: 46, height: 46)
                 .clipShape(Circle())
                 Image(systemName: "mic.badge.plus")
                 .symbolRenderingMode(.multicolor)
                 .font(.title3)
                 .bold()
                 .foregroundColor(.white)
                 }*/
            }
            .sheet(isPresented: $isCreatingSpace) {
                SpacesCreateStartNow()
                    .presentationDetents([.fraction(0.4)])
            }
        }
    }
    
    struct SpacesAddNewButton_Previews: PreviewProvider {
        static var previews: some View {
            
            SpacesCircularButton(spacesViewModel: .preview)
            
            SpacesAddNewButton()
        }
    }
}

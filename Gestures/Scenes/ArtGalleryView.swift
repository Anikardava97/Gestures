//
//  ArtGalleryView.swift
//  Gestures
//
//  Created by Ani's Mac on 22.12.23.
//

import SwiftUI

struct ArtGalleryView: View {
    
    // MARK: - Properties
    let backgroundColor = Color(red: 34/255, green: 34/255, blue: 34/255)
    let textColor = Color(red: 225/255, green: 180/255, blue: 90/255)
    
    @State private var angle: Angle = Angle(degrees: 0)
    @State private var isImageHidden = true
    @State private var xOffset: CGFloat = 0
    @State private var isComplete = false
    @State private var isMovingLeft = false
    @State private var isMovingRight = false
    @State private var offset: CGSize = .zero
    @State private var currentAmount: CGFloat = 0
    
    // MARK: - Body
    var body: some View {
        
        ZStack {
            backgroundColor.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 48) {
                    galleryTitle
                    sloganTitle
                    firstArtWork
                    secondArtWork
                    thirdArtWork
                    fourthArtWork
                    fifthArtWork
                    sixthArtwork
                    seventhArtwork
                    eighthArtwork
                    Spacer()
                }
            }
        }
    }
    
    // MARK: - Content
    var galleryTitle: some View {
        
        Text("Art Gallery")
            .font(.system(size: 20, weight: .bold, design: .serif))
            .foregroundStyle(.white)
    }
    
    var sloganTitle: some View {
        
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("Your")
                    .font(.system(size: 20, design: .serif))
                    .foregroundStyle(.white.opacity(0.6))
                    .strikethrough()
                
                Text("Art")
                    .font(.system(size: 40, design: .serif))
                    .foregroundStyle(textColor.opacity(0.9))
            }
            
            Text("Your Voice, Your Story")
                .font(.system(size: 24, design: .serif))
                .foregroundStyle(.white.opacity(0.8))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 20)
    }
    
    var firstArtWork: some View {
        
        HStack {
            Image("artwork1")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 256)
                .rotationEffect(angle)
                .gesture(
                    RotationGesture()
                        .onChanged { value in
                            angle = value
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                angle = Angle(degrees: 0)
                            }
                        }
                )
            
            Spacer()
            
            Text("\"Night\nWindows\"")
                .font(.system(size: 16, design: .serif))
                .foregroundStyle(.white.opacity(0.6))
                .rotationEffect(.degrees(-90), anchor: .center)
                .padding(.trailing, 20)
                .frame(height: 256)
                .fixedSize(horizontal: true, vertical: false)
                .lineSpacing(6)
        }
    }
    
    var secondArtWork: some View {
        
        HStack {
            Text("Room in\nNew York\"")
                .font(.system(size: 38, design: .serif))
                .foregroundStyle(isImageHidden ? Color.white.opacity(0.6) : textColor.opacity(0.9))
                .frame(maxWidth: .infinity)
                .lineSpacing(6)
                .onTapGesture {
                    withAnimation {
                        isImageHidden.toggle()
                    }
                }
            
            Spacer()
            
            Image("artwork2")
                .resizable()
                .scaledToFit()
                .frame(width: 224, height: 180)
                .offset(x: isImageHidden ? 100 : xOffset)
                .opacity(isImageHidden ? 0.5 : 1)
        }
    }
    
    var thirdArtWork: some View {
        
        VStack(spacing: 4) {
            Image("artwork3")
                .resizable()
                .scaledToFit()
                .clipShape(Rectangle())
                .frame(maxWidth: isComplete ? .infinity : 200)
                .gesture(
                    TapGesture()
                        .onEnded {
                            withAnimation(.easeInOut) {
                                isComplete.toggle()
                            }
                        }
                )
            
            
            Spacer()
            
            Text("\"Nightwalk\"")
                .font(.system(size: 16, design: .serif))
                .italic()
                .foregroundStyle(.white.opacity(0.6))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal, 20)
                .lineSpacing(6)
        }
    }
    
    var fourthArtWork: some View {
        HStack {
            if isMovingLeft {
                Text("Room In")
                    .font(.system(size: 20, design: .serif))
                    .foregroundStyle(.white.opacity(0.6))
                    .rotationEffect(.degrees(-90), anchor: .center)
                    .frame(height: 150)
                    .padding(.leading, 32)
                    .fixedSize(horizontal: true, vertical: false)
                    .transition(.move(edge: .leading))
            }
            
            Spacer()
            
            Image("artwork4")
                .resizable()
                .scaledToFit()
                .frame(width: 180, height: 150)
                .gesture(
                    LongPressGesture()
                        .onEnded { _ in
                            withAnimation {
                                isMovingLeft.toggle()
                                isMovingRight.toggle()
                            }
                        }
                )
            
            Spacer()
            
            if isMovingRight {
                Text("Brooklyn")
                    .font(.system(size: 12, design: .serif))
                    .foregroundStyle(.white.opacity(0.6))
                    .rotationEffect(.degrees(-90), anchor: .center)
                    .frame(height: 150)
                    .padding(.trailing, 20)
                    .fixedSize(horizontal: true, vertical: false)
                    .transition(.move(edge: .trailing))
            }
        }
    }
    
    var fifthArtWork: some View {
        
        HStack {
            Text("\"Pennsylvania\nCoal\nTown\"")
                .font(.system(size: 16, design: .serif))
                .foregroundStyle(.white.opacity(0.6))
                .frame(maxWidth: .infinity)
                .lineSpacing(20)
            
            Spacer()
            
            Image("artwork5")
                .resizable()
                .scaledToFit()
                .frame(width: 260, height: 200)
                .offset(offset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.spring()) {
                                offset = value.translation
                            }
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                offset = .zero
                            }
                        }
                )
        }
    }
    
    var sixthArtwork: some View {
        
        HStack {
            Image("artwork6")
                .resizable()
                .scaledToFit()
                .frame(width: 280, height: 170)
                .offset(x: isImageHidden ? -100 : xOffset)
                .opacity(isImageHidden ? 0.5 : 1)
            
            Spacer()
            
            Text("\"Early\nSunday\nMorning\"")
            
                .font(.system(size: 20, design: .serif))
                .foregroundStyle(isImageHidden ? Color.white.opacity(0.6) : textColor.opacity(0.9))
                .frame(maxWidth: .infinity)
                .lineSpacing(6)
                .onTapGesture {
                    withAnimation {
                        isImageHidden.toggle()
                    }
                }
        }
    }
    
    var seventhArtwork: some View {
        
        VStack(spacing: 4) {
            Image("artwork7")
                .resizable()
                .scaledToFit()
                .frame(width: 260, height: 220)
                .scaleEffect(1 + currentAmount)
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            currentAmount = value - 1
                        }
                        .onEnded { value in
                            withAnimation(.spring) {
                                currentAmount = 0
                            }
                        }
                )
            
            Spacer()
            
            Text("\"Chop Suey\"")
                .font(.system(size: 20, design: .serif))
                .italic()
                .foregroundStyle(.white.opacity(0.6))
                .frame(maxWidth: .infinity)
        }
    }
    
    var eighthArtwork: some View {
        
        VStack(spacing: 4)  {
            Image("artwork8")
                .resizable()
                .scaledToFit()
                .offset(offset)
                .scaleEffect(getScaleAmount())
                .rotationEffect(Angle(degrees: getRotationAmount()))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.spring()) {
                                offset = value.translation
                            }
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                offset = .zero
                            }
                        }
                )
            
            Spacer()
            
            Text("\"  A     u     t     o     m     a     t  \"".uppercased())
                .font(.system(size: 24, design: .serif))
                .foregroundStyle(textColor.opacity(0.9))
                .frame(maxWidth: .infinity)
        }
    }
    
    // MARK: - Methods
    func getScaleAmount() -> CGFloat {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = abs(offset.width)
        let percentage = currentAmount / max
        return 1.0 - min(percentage, 0.5) * 0.5
    }
    
    func getRotationAmount() -> Double {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = offset.width
        let percentage = currentAmount / max
        let percentageAsDouble = Double(percentage)
        let maxAngle: Double = 10
        return percentageAsDouble * maxAngle
    }
}

#Preview {
    ArtGalleryView()
}


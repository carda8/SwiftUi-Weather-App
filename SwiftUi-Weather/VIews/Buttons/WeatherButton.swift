//
//  WeatherButton.swift
//  SwiftUi-Weather
//
//  Created by SeungJun Lee on 3/27/24.
//
import SwiftUI

struct WeatherButton: View {
    
    var title: String
    var textColor: Color
    var backgroundColor: Color
    
    var body: some View {
        Text(title)
            .frame(width: 280, height: 50)
            .background(LinearGradient(gradient: Gradient(colors: [backgroundColor, backgroundColor.opacity(0.3)]), startPoint: .top, endPoint: .bottom))
            .foregroundStyle(textColor)
            .font(.system(size: 20, weight: .bold))
            .clipShape(.rect(cornerRadius: 10
                        )
            )
    }
}

//
//  SFSymbolsSwiftUIView.swift
//  MyiOSLibrary
//
//  Created by Vijay Sachan on 5/29/25.
//

import SwiftUI
struct SFSymbolsSwiftUIView: View {
    var body: some View {
        ScrollView(.vertical){
            VStack(spacing: 20) {
                Image(systemName: "star.fill")
                    .symbolRenderingMode(.monochrome)
                    .foregroundColor(.yellow)

                Image(systemName: "leaf.fill")
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.green,.black)

                Image(systemName: "pencil.and.outline")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.blue, .gray)

                Image(systemName: "balloon.2.fill")
                    .symbolRenderingMode(.multicolor)
                Image(systemName: "multiply.circle.fill")
                      .foregroundStyle(.yellow, .red)
                      .font(.system(size: 42.0))
            }
            .font(.system(size: 40))


        }
    }
}

#Preview {
    SFSymbolsSwiftUIView()
}
//struct SFSymbolsSwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SFSymbolsSwiftUIView()
//    }
//}

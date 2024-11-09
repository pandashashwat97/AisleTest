//
//  NavView.swift
//  AisleTest
//
//  Created by Shashwat Panda on 09/11/24.
//

import SwiftUI

struct NavView: View {
    @State var toggleView: Bool = false
    @State var fullNumber: String = ""
    var body: some View{
        if toggleView {
            OTPView(phoneNumber: fullNumber, isViewActive: $toggleView)
        } else {
            LoginView(isViewActive: $toggleView, fullNumber: $fullNumber)
        }
    }
}

#Preview {
    NavView()
}


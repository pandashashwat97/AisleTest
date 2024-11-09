//
//  LoginView.swift
//  AisleTest
//
//  Created by Shashwat Panda on 08/11/24.
//

import SwiftUI

struct LoginView: View {
    
    let vm = NetworkCall()
    
    @State var countryCode: String = ""
    @State var phoneNumber: String = ""
    @Binding var isViewActive: Bool
    @Binding var fullNumber: String
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                headingView()
                textFieldView(countryCode: $countryCode, phoneNumber: $phoneNumber)
                buttonView()
                Spacer()
            }
            .padding(EdgeInsets(top: 80, leading: 30, bottom: 0, trailing: 0))
            Spacer()
        }
        .padding()
    }
    
    // Heading View
    func headingView() -> some View {
        return VStack(alignment: .leading){
            Text("Get OTP")
                .font(.custom("Inter", size: 18))
                .fontWeight(.medium)
            Text("Enter Your")
                .font(.custom("Inter", size: 30))
                .fontWeight(.heavy)
                .padding(.top, 10)
            Text("Phone Number")
                .font(.custom("Inter", size: 30))
                .fontWeight(.heavy)
                .padding(.top, -10)
        }
    }
    
    // Text Field
    func textFieldView(countryCode: Binding<String>, phoneNumber: Binding<String>) -> some View {
        return HStack{
            TextField("", text: $countryCode)
                .padding(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .frame(width: 64, height: 36)
                .padding(.trailing, 5)
            TextField("", text: $phoneNumber)
                .padding(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .frame(width: 147, height: 36)
        }
        .padding(.top, 20)
    }
    
    // Button View
    func buttonView() -> some View {
        return Button {
            vm.postData(number: countryCode + phoneNumber, otp: nil, completion: { response in
                if response["status"] as! Int == 0 {
                    isViewActive.toggle()
                } else {
                    print(" Response: \(response)")
                }
            })
            fullNumber = countryCode + phoneNumber
        } label: {
            ZStack{
                RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                    .frame(width: 96, height: 40)
                    .foregroundStyle(Color.yellow)
                Text("Continue")
                    .font(.custom("Inter", size: 14))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.black)
            }
        }
        .padding(.top, 20)
    }
}

#Preview {
    LoginView(isViewActive: .constant(true), fullNumber: .constant(""))
}

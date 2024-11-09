//
//  OTPView.swift
//  AisleTest
//
//  Created by Shashwat Panda on 09/11/24.
//

import SwiftUI

struct OTPView: View {
    
    let vm = NetworkCall()
    
    @State private var timeRemaining = 60
    @State private var timerIsActive = true
    
    // Formatter to display time in mm:ss format
    private var formattedTime: String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    // Timer that updates every second
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var phoneNumber: String = ""
    @State var otp: String = ""
    @Binding var isViewActive: Bool
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                headingView()
                textFieldView(otp: $otp)
                buttonView()
                Spacer()
            }
            .padding(EdgeInsets(top: 80, leading: 30, bottom: 0, trailing: 0))
            Spacer()
        }
        .padding()
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                stopTimer()
                timerIsActive = false
            }
        }
        .onChange(of: isViewActive) {
            if isViewActive {
                startTimer()
            }
        }
    }
    
    // Heading View
    func headingView() -> some View {
        return VStack(alignment: .leading){
            HStack{
                Text(phoneNumber)
                    .font(.custom("Inter", size: 18))
                    .fontWeight(.medium)
                    .padding(.trailing, 5)
                Button {
                    isViewActive.toggle()
                } label: {
                    Image(systemName: "pencil")
                        .foregroundStyle(Color.black)
                        .bold()
                }

            }
            Text("Enter The")
                .font(.custom("Inter", size: 30))
                .fontWeight(.heavy)
                .padding(.top, 10)
            Text("OTP")
                .font(.custom("Inter", size: 30))
                .fontWeight(.heavy)
                .padding(.top, -10)
        }
    }
    
    // Text Field
    func textFieldView(otp: Binding<String>) -> some View {
        return TextField("", text: $otp)
            .padding(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .frame(width: 78, height: 36)
            .padding(.top, 20)
    }
    
    // Button View
    func buttonView() -> some View {
        return HStack{
            Button {
                vm.postData(number: phoneNumber, otp: otp, completion: { response in
                    vm.getData(header: response["Authorization"] as? String)
                })
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
            if timerIsActive {
                Text(formattedTime)
                    .padding(.leading, 10)
            } else {
                Button {
                    isViewActive.toggle()
                } label: {
                    Text("Resend")
                        .font(.custom("Inter", size: 18))
                        .fontWeight(.heavy)
                        .padding(.leading, 10)
                }
            }
        }
        .padding(.top, 20)
    }
    
    // Start the timer
    private func startTimer() {
        timeRemaining = 60  // Reset to 60 seconds
    }
    
    // Stop the timer
    private func stopTimer() {
        timeRemaining = 0
    }
}

//#Preview {
//    OTPView(phoneNumber: "+918763805155", formattedTime: "00:59", otp: "9999", isViewActive: .constant(true))
//}

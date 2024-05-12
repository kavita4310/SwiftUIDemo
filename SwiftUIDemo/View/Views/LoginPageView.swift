//
//  LoginPageView.swift
//  SwiftUIDemo
//
//  Created by kavita chauhan on 18/04/24.
//

import SwiftUI


struct LoginPageView: View {
    
    @State private var email: String = "riya@gmail.com"
    @State private var password: String = "12345"
    @State private var confirmPassword: String = "12345"
    @State private var toHomeView: Bool? = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                Image(uiImage: UIImage(named: "backgroungImg") ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing:10){
                    Text("myTuur")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top,120)
                        .foregroundColor(.white)
                    
                    CustomTextField(placeholder: "E-mail", text: $email)
                    CustomSecureField(placeholder: "Password", text: $password)
                    CustomSecureField(placeholder: "Confirm Password", text: $confirmPassword)

                    Button(action: {
                        if !isValidEmail(email) {
                            showAlert = true
                            alertMessage = "Please enter a valid email."
                        } else if password != confirmPassword {
                            showAlert = true
                            alertMessage = "Please make sure your password is the same."
                        } else {
                            loginApi()
                        }
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.white)
                            HStack {
                                Text("Explore")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                                    .padding()

                                Image("rightarrow")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 15,height: 40)
                                    .padding(.trailing,0)
                                
                            }
                        }.padding(.top, 50)


                    }
                    .frame(maxWidth: 120,maxHeight: 40, alignment: .leading)

                    .background(
                        NavigationLink(
                            destination: HomeTabBarView().navigationBarHidden(true),
                            tag: true,
                            selection: $toHomeView
                        ) {
                            EmptyView()
                        }
                    )

                    Spacer()
                    
                    HStack(spacing: 10){
                        SocialLoginButtons()
                    }
                    
                    Button(action: {
                        print("Forgot Password tapped!")
                        
                    }) {
                        Text("Forgot Password?")
                            .foregroundColor(.white)
                    }
                }
            }
            .navigationBarHidden(true)
            .background(Color.clear)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Alert"), message: Text(alertMessage))
                       }
            //    , dismissButton: .default(Text("OK")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    // MARK: Login api
    func loginApi() {
        struct LoginRequestBody: Encodable {
            let username: String
            let password: String
            let expiresInMins: Int
        }

        let requestBody = LoginRequestBody(username: email, password: password, expiresInMins: 30)
        
        guard let url = URL(string: "https://dummyjson.com/auth/login") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        do {
            request.httpBody = try JSONEncoder().encode(requestBody)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                do {
                    if let data = data {
                        if let responseDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            if let message = responseDictionary["message"] as? String {
                                print("Response", message)
                                DispatchQueue.main.async {
                                    toHomeView = true
                                }
                            }
                        } else {
                            print("Unable to parse response data.")
                        }
                    }
                } catch {
                    showAlert = true
                    alertMessage = error.localizedDescription
                }
            }.resume()
        } catch {
            showAlert = true
            alertMessage = error.localizedDescription
        }
    }
}

func isValidEmail(_ email: String) -> Bool {
       return email.contains("@") && email.contains(".")
   }


struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
       
        TextField(placeholder, text: $text)
            .padding()
            .frame(width: 300,height: 50)
            .background(Color.white)
            .foregroundColor(.black)
            .cornerRadius(25)
    }
}



struct CustomSecureField: View {
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        SecureField(placeholder, text: $text)
            .padding()
            .frame(width: 300,height: 50)
            .background(Color.white)
            .foregroundColor(.black)
            .cornerRadius(25)
    }
}


struct SocialLoginButtons: View {
    var body: some View {
        HStack(spacing: 10) {
            ForEach(SocialButtonType.allCases, id: \.self) { type in
                Button(action: {
                    print("\(type.rawValue) Button tapped!")
                }) {
                    Image(type.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                }
            }
        }
    }
}

enum SocialButtonType: String, CaseIterable {
    case apple = "apple"
    case facebook = "facebook"
    case google = "google2"
}

#Preview {
    LoginPageView()
}

// MARK: Alert
extension UIAlertController {
    class func alert(title:String, msg:String, target: UIViewController) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {
        (result: UIAlertAction) -> Void in
        })
        target.present(alert, animated: true, completion: nil)
    }
}

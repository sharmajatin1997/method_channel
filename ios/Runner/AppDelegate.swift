import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        let controller = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "com.example.native/api",
                                           binaryMessenger: controller.binaryMessenger)

        channel.setMethodCallHandler { call, result in
            if call.method == "login" {
                guard let args = call.arguments as? [String: Any],
                      let email = args["email"] as? String,
                      let password = args["password"] as? String,
                      let deviceToken = args["device_token"] as? String,
                      let deviceType = args["device_type"] as? String else {
                    result(FlutterError(code: "INVALID_ARGUMENTS", message: "Missing arguments", details: nil))
                    return
                }
                self.login(email: email, password: password, deviceToken: deviceToken, deviceType: deviceType, flutterResult: result)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    func login(email: String, password: String, deviceToken: String, deviceType: String, flutterResult: @escaping FlutterResult) {
        guard let url = URL(string: "https://scratchy.esferasoft.in/api/login") else {
            flutterResult(FlutterError(code: "BAD_URL", message: "Invalid URL", details: nil))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let params: [String: Any] = [
            "email": email,
            "password": password,
            "device_token": deviceToken,
            "device_type": deviceType
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch {
            flutterResult(FlutterError(code: "JSON_ERROR", message: "Failed to encode request body", details: error.localizedDescription))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                flutterResult(FlutterError(code: "NETWORK_ERROR", message: "Request failed", details: error.localizedDescription))
                return
            }

            guard let data = data,
                  let jsonString = String(data: data, encoding: .utf8) else {
                flutterResult(FlutterError(code: "RESPONSE_ERROR", message: "Invalid response", details: nil))
                return
            }

            flutterResult(jsonString)
        }.resume()
    }
}

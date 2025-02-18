import Foundation

@Observable
class ServiceCall {
    private var baseURL = "https://iosimais.iosi.com.br/elearning/api/"
    
    //MARK: - Esqueceu senha
    func forgotPassword(email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: baseURL + "auth/password") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Erro de URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["email": email]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: error?.localizedDescription as Any])))
                return
            }
            
            completion(.success(()))
        }
        
        task.resume()
    }
    //MARK: - Redefinir senha
    func resetPassword(token: String, newPassword: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: baseURL + "change-password?tk=\(token)") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["token": token, "newPassword": newPassword]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: error?.localizedDescription as Any])))
                return
            }
            
            completion(.success(()))
        }
        
        task.resume()
    }
}

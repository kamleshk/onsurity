//
//  RequestService.swift
//  ContactApp
//
//  Created by Kamalesh Kumar Yadav on 15/06/20.
//  Copyright © 2020 Kamalesh Kumar Yadav. All rights reserved.
//

import Foundation

final class RequestService {
	
	
	///  Calling or requesting APi call for URLSession
	/// - Parameters:
	///   - urlString: Api url ie drop box api
	///   - session: urlseeion with default configuratin even user can create there custom session and tey pass as paramater to it
	///   - completion: Result of Api model as Model
	/// - Returns: Void
	func loadData(urlString: String, session: URLSession = URLSession(configuration: .default), completion: @escaping (Result<Data, ErrorResult>) -> Void) -> URLSessionTask? {
		
		guard let url = URL(string: urlString) else {
			completion(.failure(.network(string: "Wrong url format")))
			return nil
		}
		// creating request
        guard let accessToken = SessionManager.shared.keychain.string(forKey: "access_token") else {
            completion(.failure(.network(string: "no acces tooken")))
            return nil
        }
        let request = RequestFactory.request(method: .GET, url: url, token: accessToken)
		// calling api on shared session
		let task = session.dataTask(with: request) { (data, response, error) in
			if let error = error {
				completion(.failure(.network(string: "An error occured during request :" + error.localizedDescription)))
				return
			}
			if let data = data {
				completion(.success(data))
			}
		}
		task.resume()
		return task
	}
}

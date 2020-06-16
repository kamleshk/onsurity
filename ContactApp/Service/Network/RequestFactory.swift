//
//  File.swift
//  ContactApp
//
//  Created by Kamalesh Kumar Yadav on 15/06/20.
//  Copyright © 2020 Kamalesh Kumar Yadav. All rights reserved.
//

import Foundation

/// RequestFactory  responsible for creating request with type of method liske get and post (HTTP method)
final class RequestFactory {
	
	enum Method: String {
		case GET
		case POST
	}
	
	/// Creating request
	/// - Parameters:
	///   - method: Type of method  ie GET, POST etc
	///   - url: URL which is going to be rquested
	/// - Returns: URL request with all method type and url
    static func request(method: Method, url: URL,token:String) -> URLRequest {
		var request = URLRequest(url: url)
		request.httpMethod = method.rawValue
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
		return request
	}
}


/// Custom enum for Result with generic value which have  case success and failue
enum Result<T, E: Error> {
	case success(T)
	case failure(E)
}

/// Custom Enum for error handaling
enum ErrorResult: Error {
	case network(string: String)
	case parser(string: String)
	case custom(string: String)
}


//
//  RequestHandler.swift
//  ContactApp
//
//  Created by Kamalesh Kumar Yadav on 15/06/20.
//  Copyright © 2020 Kamalesh Kumar Yadav. All rights reserved.
//

import Foundation


class RequestHandler {
	
	
	/// PRequestHandler this method used for getting model array in result  with error
	/// - Parameter completion: handale parsed data
	/// - Returns: returns json data
	func networkResult<T: Decodable>(completion: @escaping ((Result<[T], ErrorResult>) -> Void)) ->
		((Result<Data, ErrorResult>) -> Void) {
			
			return { dataResult in
				
				DispatchQueue.global(qos: .background).async(execute: {
					switch dataResult {
					case .success(let data) :
						ParserHelper.parse(data: data, completion: completion)
						break
					case .failure(let error) :
						print("Network error \(error)")
						completion(.failure(.network(string: "Network error " + error.localizedDescription)))
						break
					}
				})
				
			}
	}
	
	/// PRequestHandler this method used for getting model  in result  with error
	/// - Parameter completion: returns parsed data
	/// - Returns: returns json data
	func networkResult<T: Decodable>(completion: @escaping ((Result<T, ErrorResult>) -> Void)) ->
		((Result<Data, ErrorResult>) -> Void) {
			
			return { dataResult in
				
				DispatchQueue.global(qos: .background).async(execute: {
					switch dataResult {
					case .success(let data) :
						ParserHelper.parse(data: data, completion: completion)
						break
					case .failure(let error) :
						print("Network error \(error)")
						completion(.failure(.network(string: "Network error " + error.localizedDescription)))
						break
					}
				})
				
			}
	}
}

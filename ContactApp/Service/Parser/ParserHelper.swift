//
//  ParserHelper.swift
//  ContactApp
//
//  Created by Kamalesh Kumar Yadav on 15/06/20.
//  Copyright © 2020 Kamalesh Kumar Yadav. All rights reserved.
//

import Foundation


/// Praser helper call supports in parsing the data which we had got from api request . This class converts Data into keyvalue paired aor JSON format  where its going to pass these json data to desired model
final class ParserHelper {
    
    /// Method for parsing api Data which is apected to be in array or model
    /// - Parameters:
    ///   - data: api response data
    ///   - completion: completion  aprsed result Model
  /*  static func parse<T: Codable>(data: Data, completion : (Result<[T], ErrorResult>) -> Void) {
        
        do {
            // Serialization of data
            if let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [AnyObject] {
                
                var finalResult : [T] = [] // array intilizing
                for object in result {
                    if let dictionary = object as? [String : AnyObject] {
                        
                        // check foreach dictionary if parseable
                        switch T.parseObject(dictionary: dictionary) {
                        case .failure(_):
                            continue
                        case .success(let newModel):
                            finalResult.append(newModel);
                            break
                        }
                    }
                }
                
                completion(.success(finalResult))
                
            } else {
                // not an array
                completion(.failure(.parser(string: "Json data is not an array")))
            }
        } catch {
            // can't parse json
            completion(.failure(.parser(string: "Error while parsing json data")))
        }
    }
    */
    
    /// Method for  json serilization  which is be keyvalue pair
    /// - Parameters:
    ///   - data: api request data
    ///   - completion: result as model or error
    static func parse<T: Decodable>(data: Data, completion : (Result<T, ErrorResult>) -> Void) {
			
			do {
				
				let jsonDecoder = try JSONDecoder().decode(T.self, from: data)
				completion(.success(jsonDecoder))
				
			} catch let error {
				
				// can't parse json
				print("Debug error:\(error)")
				completion(.failure(.parser(string: "Error while parsing json data \(error.localizedDescription)")))
			}
	}
}

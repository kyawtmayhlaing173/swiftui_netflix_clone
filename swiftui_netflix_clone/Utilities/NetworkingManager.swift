//
//  NetworkingManager.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 27/11/2024.
//

import Foundation
import Combine
import Alamofire

class NetworkingManager {
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(let url):
                return "Bad response from URL \(url)"
            case .unknown:
                return "Unknown error occured"
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return AF.request(url)
            .validate()
            .publishData()
            .tryMap({ try handleURLResponse(output: $0, url: url)})
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: DataResponsePublisher<Data>.Output, url: URL) throws -> Data {
        guard let response = output.response, response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        guard let data = output.data else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("🔥 Error: \(error.localizedDescription)")
        }
    }
}

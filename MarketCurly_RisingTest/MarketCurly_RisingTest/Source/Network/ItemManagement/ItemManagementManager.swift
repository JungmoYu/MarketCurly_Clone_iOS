//
//  ItemManagementManager.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/26.
//

import Alamofire
import Foundation

class ItemManagementManager {
    
    func getRecommendedItem(completion: @escaping (Result<ItemInfoResponse, Error>) -> Void) {
        
        IndicatorView.shared.show()
        IndicatorView.shared.showIndicator()
        
        let formatter = DateFormatter()
        let today = Date()
        
        formatter.dateFormat = "YYYY-MM-dd"
        let url = Constant.BASE_URL+Constant.RECOMMEND_ITEM_QUERY+formatter.string(from: today)
        
        AF.request(url, method: .get)
            .responseDecodable(of: ItemInfoResponse.self) { response in
                
                switch response.result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
            }
    }
    
    
    func getDealItem(completion: @escaping (Result<ItemInfoResponse, Error>) -> Void) {
        
        IndicatorView.shared.show()
        IndicatorView.shared.showIndicator()
        
        let formatter = DateFormatter()
        let today = Date()
        
        formatter.dateFormat = "YYYY-MM-dd"
        let url = Constant.BASE_URL+Constant.DEAL_ITEM_QUERY+formatter.string(from: today)
        
        AF.request(url, method: .get)
            .responseDecodable(of: ItemInfoResponse.self) { response in
                
                switch response.result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
            }
    }
    
    func getRandomItem(completion: @escaping (Result<ItemInfoResponse, Error>) -> Void) {
        
        IndicatorView.shared.show()
        IndicatorView.shared.showIndicator()
        
        let formatter = DateFormatter()
        let today = Date()
        
        formatter.dateFormat = "YYYY-MM-dd"
        
        let url = Constant.BASE_URL+Constant.RANDOM_ITEM_QUERY+formatter.string(from: today)
        AF.request(url, method: .get)
            .responseDecodable(of: ItemInfoResponse.self) { response in
                
                switch response.result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
            }
    }
    
}

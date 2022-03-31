//
//  ItemManagementManager.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/26.
//

import Alamofire
import Foundation

class ItemManagementManager {
    
    func getOrderList(completion: @escaping (Result<OrderListResponse, Error>) -> Void ) {
        let url = Constant.BASE_URL + Constant.ORDER_LIST
        
        let header : HTTPHeaders = [
            "x-access-token": Constant.JWT
        ]
        
        IndicatorView.shared.show()
        IndicatorView.shared.showIndicator()
        
        AF.request(url,
                   method: .get,
                   headers: header)
            .responseDecodable(of: OrderListResponse.self) { response in
                
                switch response.result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
            }
    }
    
    func makeOrder(order: OrderRequest, completion: @escaping (Result<OrderResponse, Error>) -> Void ) {
        let url = Constant.BASE_URL + Constant.ORDER_LIST
        
        let header : HTTPHeaders = [
            "x-access-token": Constant.JWT
        ]
        
        let param = ["orderList": order.orderList,
                     "pay": order.pay] as [String: Any]
        print(Constant.JWT)
        IndicatorView.shared.show()
        IndicatorView.shared.showIndicator()
        
        AF.request(url,
                   method: .post,
                   parameters: param,
//                   encoder: JSONParameterEncoder.default,
                   headers: header)
            .responseDecodable(of: OrderResponse.self) { response in
                
                switch response.result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
            }
    }
    
    func deleteReview(reviewID: String, completion: @escaping (Result<ReviewRequestResponse, Error>) -> Void ) {
        let url = Constant.BASE_URL + Constant.REVIEW + "/" + reviewID
        
        let header : HTTPHeaders = [
            "x-access-token": Constant.JWT
        ]
        
        IndicatorView.shared.show()
        IndicatorView.shared.showIndicator()
        
        AF.request(url,
                   method: .put,
                   headers: header)
            .responseDecodable(of: ReviewRequestResponse.self) { response in
                
                switch response.result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
            }
    }
    
    func updateReview(reviewID: String, review: ReviewRequest, completion: @escaping (Result<ReviewRequestResponse, Error>) -> Void ) {
        let url = Constant.BASE_URL + Constant.REVIEW + "/" + reviewID
        
        let header : HTTPHeaders = [
            "x-access-token": Constant.JWT
        ]
        
        let param = ["title": review.title,
                     "content": review.content
        ]
        
        IndicatorView.shared.show()
        IndicatorView.shared.showIndicator()
        
        AF.request(url,
                   method: .patch,
                   parameters: param,
                   encoder: JSONParameterEncoder.default,
                   headers: header)
            .responseDecodable(of: ReviewRequestResponse.self) { response in
                
                switch response.result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
            }
    }
    
    func getReviews(postID: String, completion: @escaping (Result<ReviewResponse, Error>) -> Void ) {
        let url = Constant.BASE_URL + Constant.REVIEW + Constant.GETREVIEWS + postID
        
        IndicatorView.shared.show()
        IndicatorView.shared.showIndicator()
        
        AF.request(url, method: .get)
            .responseDecodable(of: ReviewResponse.self) { response in
                
                switch response.result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
            }
    }
    
    func createReview(review: ReviewRequest ,completion: @escaping (Result<ReviewRequestResponse, Error>) -> Void ) {
        
        let url = Constant.BASE_URL + Constant.REVIEW
        
        let header : HTTPHeaders = [
            "x-access-token": Constant.JWT
        ]
        
        let param = ["item_id": review.item_id,
                     "title": review.title,
                     "content": review.content
        ] as [String : Any]
        
        IndicatorView.shared.show()
        IndicatorView.shared.showIndicator()
        
        AF.request(url,
                   method: .post,
                   parameters: param,
                   headers: header)
            .responseDecodable(of: ReviewRequestResponse.self) { response in
                
                switch response.result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
            }
    }
    
    func deleteItemFromCart(itemID: String, completion: @escaping (Result<UpdateCartResponse, Error>) -> Void ) {
        
        let url = Constant.BASE_URL + Constant.CART + "/" + itemID
        let header : HTTPHeaders = [
            "x-access-token": Constant.JWT
        ]
        
        IndicatorView.shared.show()
        IndicatorView.shared.showIndicator()
        
        AF.request(url,
                   method: .delete,
                   headers: header
                   )
            .responseDecodable(of: UpdateCartResponse.self) { response in
                
                switch response.result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
            }
    }
    
    
    func updateCart(itemID: String, numOfItemToUpdate: String, completion: @escaping (Result<UpdateCartResponse, Error>) -> Void ) {
        
        let url = Constant.BASE_URL + Constant.CART + "/" + itemID
        let header : HTTPHeaders = [
            "x-access-token": Constant.JWT
        ]
        
        let param = ["quantity": numOfItemToUpdate]
        
        IndicatorView.shared.show()
        IndicatorView.shared.showIndicator()
        
        AF.request(url,
                   method: .patch,
                   parameters: param,
                   encoder: JSONParameterEncoder.default,
                   headers: header
                   )
            .responseDecodable(of: UpdateCartResponse.self) { response in
                
                switch response.result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
            }
    }
    
    func addToCart(itemList: [AddToCartItem], completion: @escaping (Result<AddToCartResponse, Error>) -> Void ) {
        let url = Constant.BASE_URL + Constant.CART
        
        let header : HTTPHeaders = [
            "x-access-token": Constant.JWT
        ]
        
        let param = ["item_list": itemList] as [String: [AddToCartItem]]
        
        IndicatorView.shared.show()
        IndicatorView.shared.showIndicator()
        
        AF.request(url,
                   method: .post,
                   parameters: param,
                   encoder: JSONParameterEncoder.default,
                   headers: header
                   )
            .responseDecodable(of: AddToCartResponse.self) { response in
                
                switch response.result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
            }
    }
    
    func getCartList(completion: @escaping (Result<CartListResponse, Error>) -> Void ) {
        
        let url = Constant.BASE_URL + Constant.CART
        
        let header : HTTPHeaders = [
            "x-access-token": Constant.JWT
        ]
        
        IndicatorView.shared.show()
        IndicatorView.shared.showIndicator()
        
        AF.request(url,
                   method: .get,
                   headers: header)
            .responseDecodable(of: CartListResponse.self) { response in
                
                switch response.result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
            }
    }
    
    func getItemDetail(itemNum: Int, completion: @escaping (Result<ItemInfoDetailResponse, Error>) -> Void) {
        
        IndicatorView.shared.show()
        IndicatorView.shared.showIndicator()
        
        let url = Constant.BASE_URL + Constant.ITEM_DETAIL_QUERY + String(itemNum)
        AF.request(url, method: .get)
            .responseDecodable(of: ItemInfoDetailResponse.self) { response in
                
                switch response.result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
            }
    }
    
    func getRecommendedItem(completion: @escaping (Result<ItemInfoResponse, Error>) -> Void) {
    
        IndicatorView.shared.show()
        IndicatorView.shared.showIndicator()
        
        let formatter = DateFormatter()
        let today = Date()
        
        formatter.dateFormat = "YYYY-MM-dd"
        let url = Constant.BASE_URL+Constant.RECOMMEND_ITEM_QUERY + formatter.string(from: today)
        
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
        let url = Constant.BASE_URL+Constant.DEAL_ITEM_QUERY + formatter.string(from: today)
        
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
        
        let url = Constant.BASE_URL+Constant.RANDOM_ITEM_QUERY + formatter.string(from: today)
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

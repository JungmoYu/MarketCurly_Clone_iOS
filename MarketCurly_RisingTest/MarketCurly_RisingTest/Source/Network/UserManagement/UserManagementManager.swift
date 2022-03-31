//
//  UserManagementManager.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/25.
//

import Alamofire


class UserManagementManager {
    
    
    func deleteReauest(completion: @escaping( Result<UpdateUserResponse, Error> ) -> Void ) {
        
        let header : HTTPHeaders = [
            "x-access-token": Constant.JWT
        ]
        
        AF.request(Constant.BASE_URL+Constant.SEARCH_USERINDEX + String(Constant.USER_INDEX),
                   method: .put,
                   headers: header)
            .responseDecodable(of: UpdateUserResponse.self) { response in
                
                switch response.result {
                case .success(let response):
                    UserManagementManager().searchUser(userID: Constant.USER_INDEX, JWT: Constant.JWT) { result in
                        switch result {
                        case .success(let data):
                            Constant.User = data.result?[0]
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func updateRequest(_ user: UpdateUserRequest, completion: @escaping( Result<UpdateUserResponse, Error> ) -> Void )  {
        let header : HTTPHeaders = [
            "x-access-token": Constant.JWT
        ]
        
        let param = ["password": user.password,
                     "email": user.email,
                     "phone": user.phone,
                     "address": user.address,
                     "birthday": user.birthday,
                     "gender": user.gender
        ]
        
        AF.request(Constant.BASE_URL+Constant.SEARCH_USERINDEX + String(Constant.USER_INDEX),
                   method: .patch,
                   parameters: param,
                   encoder: JSONParameterEncoder.default,
                   headers: header)
            .responseDecodable(of: UpdateUserResponse.self) { response in
                
                switch response.result {
                case .success(let response):
                    UserManagementManager().searchUser(userID: Constant.USER_INDEX, JWT: Constant.JWT) { result in
                        switch result {
                        case .success(let data):
                            Constant.User = data.result?[0]
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        
    }
    
    
    func searchUser(userID: Int, JWT: String, completion: @escaping(Result<UserResponse, Error>) -> Void) {
        let header : HTTPHeaders = [
            "x-access-token": Constant.JWT
        ]
        
        AF.request(Constant.BASE_URL+Constant.SEARCH_USERINDEX + String(Constant.USER_INDEX),
                   method: .get,
                   headers: header)
            .responseDecodable(of: UserResponse.self) { response in
                
                switch response.result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                    
                }
            }
        
    }
    
    func loninRequest(_ user: LoginUserRequest, completion: @escaping(Result<LoginUserResponse, Error>) -> Void) {
        let param = ["id": user.id,
                     "password": user.password
        ]
        
        AF.request(Constant.BASE_URL+Constant.LOGIN_QUERY,
                   method: .post,
                   parameters: param,
                   encoder: JSONParameterEncoder.default
                   )
            .responseDecodable(of: LoginUserResponse.self) { response in
                switch response.result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    
    func joinRequest(_ user: JoinUserRequest, completion: @escaping( Result<JoinUserResponse, Error> ) -> Void )  {

        let param = ["id": user.id,
                     "password": user.password,
                     "name": user.name,
                     "email": user.email,
                     "phone": user.phone,
                     "address": user.address,
                     "birthday": user.birthday,
                     "gender": user.gender
        ]
        
        AF.request(Constant.BASE_URL+Constant.JOIN_QUERY,
                   method: .post,
                   parameters: param,
                   encoder: JSONParameterEncoder.default
                   )
            .responseDecodable(of: JoinUserResponse.self) { response in
                
                switch response.result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        
    }
    
    
}

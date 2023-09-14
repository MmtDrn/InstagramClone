//
//  AuthManagerPRotocol.swift
//  InstagramClone
//
//  Created by mehmet duran on 14.09.2023.
//

import Foundation

protocol AuthManagerPRotocol {
    func userRegister(model: RegisterModel, completion: @escaping(Result<Bool, RegisterError>)-> Void)
    func logIn(email: String, password: String, completion: @escaping(Result<Bool, Error>) -> Void)
    func logOut(completion: @escaping(Result<Bool, Error>) -> Void)
}

extension AuthManagerPRotocol {
    func userRegister(model: RegisterModel, completion: @escaping(Result<Bool, RegisterError>)-> Void) { }
    func logIn(email: String, password: String, completion: @escaping(Result<Bool, Error>) -> Void) { }
    func logOut(completion: @escaping(Result<Bool, Error>) -> Void) { }
}

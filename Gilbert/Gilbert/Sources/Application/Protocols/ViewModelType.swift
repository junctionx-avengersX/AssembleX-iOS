//
//  ViewModelType.swift
//  Gilbert
//
//  Created by Tom on 2021/05/22.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

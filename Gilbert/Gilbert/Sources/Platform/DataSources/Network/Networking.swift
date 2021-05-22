//
//  Networking.swift
//  Gilbert
//
//  Created by Tom on 2021/05/22.
//

import Foundation

import Moya
import RxSwift

protocol NetworkingProtocol {
  func request(_ target: MultiTarget,
               file: StaticString,
               function: StaticString,
               line: UInt)
  -> Single<Response>
}

extension NetworkingProtocol {
  func request(_ target: MultiTarget,
               file: StaticString = #file,
               function: StaticString = #function,
               line: UInt = #line)
  -> Single<Response> {
    return self.request(target,
                        file: file,
                        function: function,
                        line: line)
  }
}

final class Networking: MoyaProvider<MultiTarget>,
                        NetworkingProtocol {
  init(plugins: [PluginType] = []) {
    let session = MoyaProvider<MultiTarget>.defaultAlamofireSession()
    session.sessionConfiguration.timeoutIntervalForRequest = 10
    
    super.init(session: session, plugins: plugins)
  }
  
  func request(
    _ target: MultiTarget,
    file: StaticString,
    function: StaticString,
    line: UInt
  ) -> Single<Response> {
    let requestString = "\(target.method.rawValue) \(target.path)"
    return self.rx.request(target)
      .filterSuccessfulStatusCodes()
      .do(
        onSuccess: { value in
          let message = "SUCCESS: \(requestString) (\(value.statusCode))"
          debugPrint(message)
        },
        onError: { error in
          if let response = (error as? MoyaError)?.response {
            if let jsonObject = try? response.mapJSON(failsOnEmptyData: false) {
              let message = "FAILURE: \(requestString) (\(response.statusCode))\n\(jsonObject)"
              debugPrint(message)
            } else if let rawString = String(data: response.data, encoding: .utf8) {
              let message = "FAILURE: \(requestString) (\(response.statusCode))\n\(rawString)"
              debugPrint(message)
            } else {
              let message = "FAILURE: \(requestString) (\(response.statusCode))"
              debugPrint(message)
            }
          } else {
            let message = "FAILURE: \(requestString)\n\(error)"
            debugPrint(message)
          }
        },
        onSubscribed: {
          let message = "REQUEST: \(requestString)"
          debugPrint(message)
        }
      )
  }
}

//
//  FiledValidation.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 03/03/25.
//

import Foundation
import Combine

class FiledValidation: ObservableObject, ExpressibleByStringLiteral, CustomStringConvertible {
    @Published var value: String = "" {
        didSet{
            DispatchQueue.main.async { [weak self] in
                  guard let self = self else { return }
                let constrainedValue = self.applyConstraints(self.value)
                if constrainedValue != self.value {
                    self.value = constrainedValue
                }
            }
        }
    }
    @Published var isValid: Bool = false
    var description: String {value}
    
    private var cancellables = Set<AnyCancellable>()
    private var isValidPublisher: AnyPublisher<Bool,Never>
    {
        Publishers.Map(upstream: $value) { !$0.isEmpty }
        .eraseToAnyPublisher()
    }
    
    required init(stringLiteral value: String) {
        self.value = "\(value)"
        isValidPublisher
            .assign(to: \.isValid, on: self)
            .store(in: &cancellables)
    }
    
    
    func applyConstraints(_ value: String) -> String {
        return value
    }

    
}

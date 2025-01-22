//
//  ViewModel.swift
//  Presentation
//
//  Created by 정명곤 on 10/29/24.
//  Copyright © 2024 CleanArchitecture. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Domain


public final class MainViewModel {
  private let useCase: CoinListUseCase
  private let disposeBag = DisposeBag()

  struct Input {
    let tapButton: Observable<Void>
  }

  public struct Output {
    public let navigateToAuthCoordinator = PublishRelay<Void>()
  }

//  public let navigateToAuthCoordinator: PublishRelay<Void> = PublishRelay()
  public let output = Output()

  public init(useCase: CoinListUseCase) {
    self.useCase = useCase
  }

  func transform(from input: Input) -> Output {

    input.tapButton
      .bind(to: output.navigateToAuthCoordinator)
      .disposed(by: disposeBag)

//    let movieList = input.refresh
//                .flatMap { [weak self] _ -> Observable<[Movie]> in
//                    guard let self = self else { return Observable.just([]) }
//                  return useCase.fetchMovie()
//                }

    return Output()
  }

}

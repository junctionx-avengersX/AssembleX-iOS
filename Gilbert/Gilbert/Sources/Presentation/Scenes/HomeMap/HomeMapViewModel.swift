import RxSwift
import RxCocoa
class HomeMapViewModel {
  let destinationRelay = PublishRelay<(MapPosition, MapPosition)>()
  private let useCase: HomeMapUseCase
  private let navigator: HomeMapNavigator
  private let provider: ServiceProvider
  private let disposeBag = DisposeBag()
  init(
    useCase: HomeMapUseCase,
    navigator: HomeMapNavigator,
    provider: ServiceProvider
  ) {
    self.useCase = useCase
    self.navigator = navigator
    self.provider = provider
  }
}
extension HomeMapViewModel: ViewModelType {
  struct Input {
    let destination: Observable<(MapPosition, MapPosition)>
  }
  struct Output {
    let driving: Observable<Driving>
  }
  func transform(input: Input) -> Output {
    let driving = input.destination.flatMapLatest {
      [weak self] position -> Observable<Driving> in
      guard let this = self else { return Observable.empty() }
      return this.provider.drivingService.getDriving(start: position.0, goal: position.1).asObservable()
    }
    return Output(driving: driving)
  }
}

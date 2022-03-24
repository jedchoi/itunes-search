# itunes-search

1. App의 목적
  - App Store에서 어플리케이션을 검색하는 기능 만들기
  - 검색한 어플리케이션의 List오 상세정보 확인

2. 설계
  - 3 Layered Architecture 적용(UI, Domain, Infra)
  - SwiInject를 이용한 Dependency Injection 적용 
  - Reactive Programming 적용
  - Unit Test 적용
  - UI Layer: VIPER 패턴 적용
  - Domain Layer: Use Case - Service로 구분하여 UI는 UseCase를 통해서만 Domain에 접근하도록 제한
  - Infra Layer: 개발 편의를 위한 Fake 모듈과 실제 데이터를 제공하는 Infra 분리

3. 설계 특장점
  - Data Model의 의존성 제거
    : 각 UI마다(페이지,subview) 독립적인 Data Model(ViewModel)을 사용하고, Domain도 독립적인 DataModel(Entity) 사용
    : 다른 UI 혹은 Layer로 데이터를 전달할 때는 json 타입으로 Encoding하여 전달하여 Dependency르 제거
  - VIPER 패터 적용으로 각 UI간 의존성 최소화
    : RIBs와 비슷하 구조로 구성되 VIPER 패턴을 적용하여 각 UI 페이지는 Router를 통해서만 전환이 가능하여 의존성 제거

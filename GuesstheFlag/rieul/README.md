# Guess the Flag

## VStack

- 내부에 뷰를 수직으로 배치
- 뷰와 뷰 사이의 간격은 `spacing` 을 지정: `VStack(spacing: 20) { ... }`
- 최대 10개의 지식을 가질 수 있음
- 뷰를 정렬하는 방법은 `alignment` 을 지정: `VStack(alignment: .leading) { ... }`
  - 기본값은 `center`

## HStack

- 내부에 뷰를 수평으로 배치
- 간격 및 정렬은 VStack 과 동일하게 지정
- VStack 과 HStack 은 컨텐츠에 자동으로 맞춰짐. 어느 한 쪽으로 치우치게 하고 싶은 경우, `Spacer` 이용

## ZStack

- CSS 의 z-index 처럼 동작
- 뷰가 겹치기 때문에 간격의 개념은 없지만, 정렬은 있음

## Gradient

- LinearGradient
  - 한 방향으로 진행
  - 시작과 끝을 지정해야 함
- RadialGradient: 방사형
  - 원모양으로 바깥쪽으로 이동
  - 시작 및 끝 반경 지정
- AngularGradient: 원추형, 원뿔형
  - 바깥쪽으로 방사되지 않고 원을 중심으로 색이 순환됨

## Button

- 버튼이 탭 됐을 때 실행해야 하는 동작을 클로저 혹은 함수로 전달
- 

## 그 외

- SafeArea 를 침범해서 뷰를 그리고 싶다면 `ignoresSafeArea` 를 지정해야 함
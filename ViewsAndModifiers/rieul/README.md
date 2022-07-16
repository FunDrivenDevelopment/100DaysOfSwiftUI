# ViewsAndModifiers

## 목표

- SwiftUI 에서 왜 View 에 구조체를 사용했는지 이해하기
- 왜 `some View` 를 사용하는지
- modifier 는 실제로 어떻게 동작하는지

## SwiftUI 는 왜 구조체를 사용하는가?

- 성능 && 간단함을 유지하기?

구조체는 클래스보다 성능이 좋다. 

상태를 고립시키고, 간단하게 유지한다: 이와 더불어 클래스는 변할 수 있어서 복잡해지지만, 구조체는 변할 수 없어서 복잡해지지 않는다.

UIKit 에서 모든 뷰들은 UIView 를 상속받는다. 이 때 사용 여부에 상관없이 200 여 개의 프로퍼티/메서드들이 하위 클래스로 상속된다.

## `UIHostingController`

UIKit 과 SwiftUI 사이의 bridge

## ModifiedContent

SwiftUI 는 제네릭을 이용해서.. 수정자들이 붙을 때 감싸고 감싸고 어쩌구 저쩌구를 함..

++ 보충해서 공부하기

## `some View`를 사용하는 이유

성능: 이것마저 없다면 컴파일러가 해당 구조체가 무엇이 변경되었는지 파악하고 유추하는 것이 더 느려진다.

## VStack 이 동작하는 원리

VStack 에 하위 뷰를 두 개 넣는다고 하면 컴파일러는 두 개의 뷰를 포함하는 `TupleView`를 생성한다.

SwiftUI 에서 하위 뷰를 10개까지만 가능하게 하는 이유는 TupleView 의 구현이 최대 10개까지 밖에 안되기 때문이다.

## 스택에 래핑하지 않고 body 속성에서 직접 두 개의 뷰를 다시 보내면 어떻게 될까?

`body` 라는 속성에 `@ViewBuilder` 라는 특수한 속성이 적용되어 있다. 이것은 `TupleView` 컨테이너 중 하나에서 여러 뷰를 자동으로 래핑하는 효과가 있으므로 여러 뷰를 다시 보내는 것처럼 보이지만 하나의 `TupleView` 로 결합된다.

## Environment Modifier

- (개발자 관점에서) 일반 수정자와 같은 방식으로 사용된다.
- 하위 뷰에서 하나라도 동일한 수정자를 재정의하는 경우 하위 버전을 우선시 한다.

## 하위 뷰를 별도로 쪼개기

- body 를 깔끔하고, 명확하게 유지할 수 있음
- Swift는 객체가 생성될 때 문제를 일으킬 수 있기 때문에 다른 저장 속성을 참조하는 하나의 저장 속성을 생성하는 것을 허용하지 않는다.
- 원하는 경우 computed property 로 만들 수 있음

```swift
var motto1: some View {
    Text("Draco dormiens")
}
```

body 와 달리 @ViewBuilder 속성이 자동으로 붙지 않기 때문에 주의할 것 (= VStack 없이 여러 개의 뷰를 내보낼 수 없음)

여러 뷰를 내보내고자 할 때 방법은 세 가지가 있다.

1. VStack 으로 wrapping
2. Group 으로 wrapping (View 의 배열은 이 프로퍼티를 사용하는 곳에서 사용하는 방식에 따라 변함)
3. @ViewBuilder 프로퍼티를 직접 추가

## ViewModifier 프로토콜

`font()`, `background()` 같은 커스텀 수정자를 만들때는 ViewModifier 프로토콜을 채택한 구조체를 만든다.


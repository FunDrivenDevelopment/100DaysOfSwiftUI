# Word Scramble

## `List`

- SwiftUI 에서 UIKit 의 UITableView 같은 존재
- 사용자의 입력을 요청하는 대신 데이터를 표시한다는 것을 제외하면 `Form`과 거의 유사함
- 정적, 동적 컨텐츠를 같이 가질 수 있음
- 내부에 `Section` 을 혼합해서 사용할 수 있음
- 전체 목록이 동적으로 구성된 경우, `ForEach` 를 생략해서 표기할 수 있음: `List(0..<) { }`

## Bundle

- Xcode 는 iOS 앱을 빌드할 때 Bundle 을 생성
- 앱의 모든 파일은 Bundle 에 저장됨
- 메인 앱 번들에 있는 파일의 URL을 읽으려면: `Bundle.main.url()`
- 앱은 샌드박스에 있으므로 외부에서 접근할 수 없음

## Strings

- `String.components(separatedBy:)`
  - 문자열에서 특정 문자열을 기준으로 배열로 분리하는 메서드
- `String.trimmingCharacters(in:)`
  - 문자열의 시작과 끝에 있는 특정 문자열을 제거하는 메서드

## `UITextChecker`

- 맞춤법 검사 클래스

UITextChecker 는 Objective-C 로 만들어졌다. 그래서 사용하려면 문자열의 길이를 알려줘야 하는데, 이를 위해서는 `String.utf16.count` 를 사용해야 한다. 왜냐하면 Swift 는 이모지 등을 저장하기 위해 문자열을 UTF-16 으로 저장하는 반면에 Objective-C 는 그렇지 않기 때문이다.

또한 Objective-C 는 Optional 이라는 개념이 없기 때문에, 값이 없는 경우 `NSNotFound` 를 반환한다.

## `fatalError()`

- 해결할 수 없는 문제에 명확하게 대응(= 앱 종료)
- 때로는 앱을 충돌시켜서 원인을 찾는게 낫다.
- 
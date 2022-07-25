# Word Scramble

## `List`

- SwiftUI 에서 UIKit 의 UITableView 같은 존재
- 사용자의 입력을 요청하는 대신 데이터를 표시한다는 것을 제외하면 `Form`과 거의 유사함
- 정적, 동적 컨텐츠를 같이 가질 수 있음
- 내부에 `Section` 을 혼합해서 사용할 수 있음
- 전체 목록이 동적으로 구성된 경우, `ForEach` 를 생략해서 표기할 수 있음: `List(0..<) { }`
- 
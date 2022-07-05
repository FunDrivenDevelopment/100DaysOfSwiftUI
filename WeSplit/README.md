# 배운점
- option+cmd+P = 프리뷰 resume
- $사인은 바인딩해서 값을 write 하고 싶을때 사용. write 없이 read만 할거라면 $ 필요없음
- forEach(sutdents, id: \.self) { }
에서 id 는 swiftUI가 셀의 값이 변하는 경우를 대비해 각각의 셀이 어떤 셀인지 아이덴티파잉 하기 위해 사용한다. 모든 아이디 값은 유니크 해야함. 이 경우에는 [String]인 students 어레이의 값 그 자체를 id로 사용하고 있다. 만약 중복되는 스트링이 있다면 문제될 수 있음.
- FocusState

# FocusState
[Apple documentation] https://developer.apple.com/documentation/swiftui/focusstate
A property wrapper type that can read and write a value that SwiftUI updates as the placement of focus within the scene changes.
SwiftUI가 scene 변화 내에서 포커스의 placement로써 업데이트 하는 값을 읽고 쓸 수 있는 프로퍼티 래퍼 타입.

```
struct LoginForm {
    enum Field: Hashable {
        case username
        case password
    }

    @State private var username = ""
    @State private var password = ""
    @FocusState private var focusedField: Field?

    var body: some View {
        Form {
            TextField("Username", text: $username)
                .focused($focusedField, equals: .username)

            SecureField("Password", text: $password)
                .focused($focusedField, equals: .password)

            Button("Sign In") {
                if username.isEmpty {
                    focusedField = .username
                } else if password.isEmpty {
                    focusedField = .password
                } else {
                    handleLogin(username, password)
                }
            }
        }
    }
}
```

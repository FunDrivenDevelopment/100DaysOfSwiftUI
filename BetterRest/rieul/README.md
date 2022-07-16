# BetterRest

## Stepper

- `in:` 항목으로 최소, 최대를 지정할 수 있음 (Range 타입)
- `step:` 항목으로 스텝을 지정할 수 있음 (State 와 동일한 타입)

## DatePicker

이유는 모르겠다만, Preview 에서 표시가 안됨

- `labelsHidden()` 메서드를 사용하여 레이블을 숨길 수 있음
  - 단, VoiceOver 에서는 레이블이 숨겨지지 않음!! :+1:
- `displayedComponents:` 사용자에게 표시되어야 하는 옵션을 지정할 수 있음
- 
- `in:` 사용자가 선택할 수 있는 날짜 범위를 지정할 수 있음 (Date 타입도 Range 로 지정할 수 있다 두둥)


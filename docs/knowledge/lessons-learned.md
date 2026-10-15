# Lessons Learned: Flutter Neobrutalist Resume

## 1. Unbounded Width in Flex / Row with TextFields
- **Symptom**: `An InputDecorator, which is typically created by a TextField, cannot have an unbounded width.`
- **Root Cause**: `TextField` placed inside `Wrap` (e.g. `SkillPillWidget`) or unconstrained `Row` lacks horizontal constraints.
- **Remedy**: For non-multiline fields, wrap with `IntrinsicWidth(child: ConstrainedBox(constraints: BoxConstraints(minWidth: 40), child: ...))`. For multiline fields, ensure parent flex applies `Expanded`.

## 2. Cursor Blinking Animation in Widget Tests
- **Symptom**: `pumpAndSettle timed out` in Flutter widget tests containing `TextField`s.
- **Root Cause**: Blinking cursor animations continuously schedule frames, preventing `pumpAndSettle()` from ever reaching an idle state.
- **Remedy**: In widget tests containing text fields, replace `pumpAndSettle()` with discrete pumps: `await tester.pump(); await tester.pump(const Duration(milliseconds: 100));`.

## 3. SharedPreferences in Flutter Unit Tests
- **Symptom**: Async data loading hangs or errors during `tester.pumpWidget` execution.
- **Root Cause**: `SharedPreferences` requires a mock backend when running in headless `flutter test`.
- **Remedy**: Call `SharedPreferences.setMockInitialValues({});` in the test `setUp()` block.

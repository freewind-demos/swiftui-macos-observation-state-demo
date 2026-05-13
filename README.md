# SwiftUI macOS Observation State Demo

## 简介

这个 demo 只讲 1 件事：

- SwiftUI 里现在更推荐的状态管理最小写法

适用前提：

- macOS 14+
- Swift 5.9+
- Xcode 15+

这套写法的核心是：

- 视图自己拥有状态源 → `@State`
- 共享 UI 状态模型 → `@Observable`
- 子视图要改模型 → `@Bindable`
- UI 状态统一收口主线程 → `@MainActor`

如果你要兼容更老系统，再退回 `ObservableObject/@Published/@StateObject`。

## 运行

```bash
cd swiftui-macos-observation-state-demo
./scripts/build.sh
open SwiftUIObservationStateDemo.xcodeproj
```

## 这 demo 在演示什么

### 1. App 自己持有 store

```swift
@State private var store = CoffeeOrderStore()
```

意思：

- 这份状态归当前界面树拥有
- 不要在子 view 里各自 new

### 2. 状态模型用 `@Observable`

```swift
@MainActor
@Observable
final class CoffeeOrderStore {
    var customerName = "Freewind"
    var cups = 1
    var wantsOatMilk = false
}
```

意思：

- 普通属性改了，SwiftUI 会追踪
- 不用自己写 `@Published`

### 3. 需要编辑时，用 `@Bindable`

```swift
@Bindable var store: CoffeeOrderStore
TextField("Customer", text: $store.customerName)
```

意思：

- 子 view 可直接拿到 binding
- 表单控件能直接改 store

### 4. 只读 view 不需要 `@Bindable`

```swift
let store: CoffeeOrderStore
Text(store.summary)
```

意思：

- 只读就直接读
- 仍会自动刷新

## 最佳实践浓缩

- 小型、临时、只在当前 view 用的状态 → `@State`
- 多个子 view 共用的界面状态 → 1 个 `@Observable` store
- store 谁拥有，谁在更高层 `@State` 持有
- 子 view 不拥有 store，只接收它
- 需要改值的子 view 用 `@Bindable`
- UI 状态模型尽量 `@MainActor`

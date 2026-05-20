# 2WayWeb

## App 架構

純 UIKit + WKWebView，無 SwiftUI。使用 SceneDelegate 管理 window。

## Project Structure

```
Sources/
├── AppDelegate.swift
├── SceneDelegate.swift
├── index.html
└── Home/
    ├── HomeViewModel+Models.swift   # M: State / User
    ├── HomeViewModel.swift          # VM: @Observable @MainActor
    ├── HomeHostController.swift     # C: UIViewController
    ├── HomeViewOutlet.swift         # WKWebView 設定與 JS 呼叫
    └── HTMLHandler.swift            # WKScriptMessageHandler 橋接
```

## Architecture: MVVMC

| 層 | 職責 |
|---|---|
| M | State struct、ViewStatus enum、User |
| VM | @Observable @MainActor，doAction 單一進入點，onRoute 觸發導航 |
| C | UIViewController，設定 onRoute，handleRouter 處理所有導航與 WebView 呼叫 |

## JS ↔ Swift 通訊

- JS → Swift：`HTMLHandler`（WKScriptMessageHandler）接收 JS 訊息 → ViewModel `doAction(.js(...))`
- Swift → JS：`HomeViewOutlet.sendName/sendAge` 呼叫 `callAsyncJavaScript`

## 使用方式

```bash
brew install xcodegen
xcodegen generate
open TwoWayWeb.xcodeproj
```

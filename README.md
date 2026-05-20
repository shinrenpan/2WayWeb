# 2WayWeb

示範 Swift ↔ JavaScript 雙向通訊，透過 WKWebView 讓 HTML 頁面與 Native App 互相呼叫。

---

## 使用方式

```bash
brew install xcodegen
xcodegen generate
open TwoWayWeb.xcodeproj
```

---

## 功能

- JavaScript → Swift：HTML 按鈕觸發 `WKScriptMessageHandler`，請求使用者資料
- Swift → JavaScript：Native 取得資料後，透過 `callAsyncJavaScript` 回傳至 HTML 更新 DOM

## 架構

採用 MVVMC 架構：

| 層 | 檔案 | 職責 |
|---|---|---|
| M | `HomeViewModel+Models.swift` | State / User |
| VM | `HomeViewModel.swift` | 業務邏輯、JS 事件處理、onRoute |
| C | `HomeHostController.swift` | UIViewController、Router 導航 |
| - | `HomeViewOutlet.swift` | WKWebView 設定與 JS 呼叫 |
| - | `HTMLHandler.swift` | WKScriptMessageHandler 橋接 |

## 技術

- Swift 6 / iOS 18
- UIKit + WKWebView
- Swift Observation（`@Observable`）
- Swift Concurrency（`async/await`）

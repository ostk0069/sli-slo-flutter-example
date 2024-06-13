enum SentrySpanChildOperationType {
  /// API Requests
  api,

  /// native navigation (not web_view navigation)
  /// NOTE: "navigation" exists in sentry as a reserved word for screen transition
  route,

  /// web_view navigation
  webView,

  /// Permission acquisition
  permission,

  /// Image processing
  imageProcessing,

  /// User operation or interruption event due to crash or app kills
  discontinuedEvent,
  ;
}
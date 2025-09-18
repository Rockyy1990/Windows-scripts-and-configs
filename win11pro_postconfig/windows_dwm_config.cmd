@echo off

echo.
echo Windows DWM config.
echo.

pause


Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\DWM\Schedule" /v "FrameDisplayBaseNegOffsetNS" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\DWM\Schedule" /v "FrameDisplayResDivValue" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\DWM\Schedule" /v "FrameRateMin" /t REG_DWORD /d "4294967295" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\DWM\Schedule" /v "Gc6State" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\DWM\Schedule" /v "HideBalloonNotification" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\DWM\Schedule" /v "HideXGpuTrayIcon" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\DWM\Schedule" /v "IgnoreDisplayChangeDuration" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\DWM\Schedule" /v "IgnoreNodeLocked" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\DWM\Schedule" /v "IgnoreSP" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\DWM\Schedule" /v "LicenseInterval" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\DWM\Schedule" /v "LingerInterval" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\DWM\Schedule" /v "PerformanceState" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\DWM\Schedule" /v "RestrictedNvcplUIMode" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\DWM\Schedule" /v "ShowTrayIcon" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\DWM\Schedule" /v "WindowedGsyncGeforceFlag" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "AlwaysHibernateThumbnails" /t REG_DWORD /d "0" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "AlwaysOffscreenComposition" /t REG_DWORD /d "0" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "AnimationAttributionEnabled" /t REG_DWORD /d "0" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "AnimationAttributionHashingEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "AnimationsShiftKey" /t REG_DWORD /d "0" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "BackdropBlurCachingThrottleMs" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "Blur" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "BufferAgingTimeout" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "BufferCount" /t REG_DWORD /d "1" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "ChildWindowDpiIsolation" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "Composition" /t REG_DWORD /d "0" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "CompositionPolicy" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "CompositorClockPolicy" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "ConfigureInput" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "CpuClipAASinkEnableIntermediates" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "CpuClipAASinkEnableOcclusion" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "CpuClipAASinkEnableRender" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "CpuClipFlatteningTolerance" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "CustomRefreshRateMode" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "DDisplayTestMode" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "DebugFailFast" /t REG_DWORD /d "0" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "DisableAdvancedDirectFlip" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "DisableDComp" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "DisableDeviceBitmaps" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "DisableDeviceBitmapsForMultiAdapter" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "DisableDrawListCaching" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "DisableDynamicShutdownUI" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "DisableHardwareComposition" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "DisableHologramCompositor" /t REG_DWORD /d "1" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "DisableIndependentFlip" /t REG_DWORD /d "0" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "DisableLockingMemory" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "DisableProjectedShadows" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "DisableProjectedShadowsRendering" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "DisallowColorizationColorChanges" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "DisallowComposition" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "DisallowNonDrawListRendering" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "DiscardSurfaceOnMinimize" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "EnableAcrylicBlur" /t REG_DWORD /d "0" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "EnableAeroPeek" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "EnableBackdropBrush" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "EnableCommonSuperSets" /t REG_DWORD /d "1" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "EnableCpuClipping" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "EnableDDisplayScanoutCaching" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "EnableDesktopOverlays" /t REG_DWORD /d "0" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "EnableDrawToBackbuffer" /t REG_DWORD /d "0" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "EnableEffectCaching" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "EnableFrontBufferRenderChecks" /t REG_DWORD /d "0" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "EnableImageProcessing" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "EnableInputPrediction" /t REG_DWORD /d "0" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "EnableMegaRects" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "EnableMPCPerfCounter" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "EnablePrimitiveReordering" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "EnableRenderPathTestMode" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "EnableResizeOptimization" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "EnableShadow" /t REG_DWORD /d "0" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "EnableWindowColorization" /t REG_DWORD /d "0" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "FlattenVirtualSurfaceEffectInput" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "ForceDirectDrawSync" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "ForceDisableModeChangeAnimation" /t REG_DWORD /d "1" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "ForceEffectMode" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "ForceGdiComposition" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "ForceModeEnumeration" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "ForceSoftwareD3D" /t REG_DWORD /d "1" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "FrameLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "HighColor" /t REG_DWORD /d "0" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "ImageProcessing8bit" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "InitialWatchdogTelemetryTimeoutMilliseconds" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "InkGPUAccelOverrideVendorWhitelist" /t REG_DWORD /d "1" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "InteractionOutputPredictionDisabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "LogExpressionPerfStats" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "MarshalAllDebugInfo" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "MaxBufferCount" /t REG_DWORD /d "1" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "MaxD3DFeatureLevel" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "MaxOutstandingFrames" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "MaxQueuedFrames" /t REG_DWORD /d "0" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "MaxQueuedPresentBuffers" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "m_bufferCount" /t REG_DWORD /d "1" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "MegaRectSearchCount" /t REG_DWORD /d "0" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "MegaRectSize" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "MousewheelAnimationDurationMs" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "MouseWheelScrollingMode" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "MPCInputRouterWaitForDebugger" /t REG_DWORD /d "0" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "OneCoreNoBootDWM" /t REG_DWORD /d "1" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "OneCoreNoDWMRawGameController" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "OptimizeForDirtyExpressions" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayDisqualifyCount" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayDisqualifyInterval" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayMinFPS" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayQualifyCount" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayQualifyInterval" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "ParallelModeLeaveAfterThresholdMS" /t REG_DWORD /d "0" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "ParallelModePolicy" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "RecurringWatchdogTelemetryTimeoutMilliseconds" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "RenderThreadWatchdogTimeoutMilliseconds" /t REG_DWORD /d "0" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "ResampleInLinearSpace" /t REG_DWORD /d "0" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "ResampleModeOverride" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "ResizeTimeoutGdi" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "ResizeTimeoutModern" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "RetryFrameOnDrop" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "SDRBoostPercentOverride" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "ShowDirtyRegions" /t REG_DWORD /d "0" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "SuperWetEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "SuperWetExtensionTimeMicroseconds" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "SwapEffect" /t REG_DWORD /d "2" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "TelemetryFramesReportPeriodMilliseconds" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "TelemetryFramesSequenceIdleIntervalMilliseconds" /t REG_DWORD /d "0" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "TelemetryFramesSequenceMaximumPeriodMilliseconds" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "UseCopyOnPresent" /t REG_DWORD /d "1" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "UseDpiScaling" /t REG_DWORD /d "0" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "UseHWDrawListEntriesOnWARP" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "UseLegacyDisplayFrameBuffer" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "UseMachineCheck" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "UseStaticComposition" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "AlwaysHibernateThumbnails" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "AlwaysOffscreenComposition" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "AnimationAttributionEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "AnimationAttributionHashingEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "AnimationsShiftKey" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "BackdropBlurCachingThrottleMs" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "Blur" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "BufferAgingTimeout" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "BufferCount" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "ChildWindowDpiIsolation" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "Composition" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "CompositionPolicy" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "CompositorClockPolicy" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "ConfigureInput" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "CpuClipAASinkEnableIntermediates" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "CpuClipAASinkEnableOcclusion" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "CpuClipAASinkEnableRender" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "CpuClipFlatteningTolerance" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "CustomRefreshRateMode" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "DDisplayTestMode" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "DebugFailFast" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "DisableAdvancedDirectFlip" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "DisableDComp" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "DisableDeviceBitmaps" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "DisableDeviceBitmapsForMultiAdapter" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "DisableDrawListCaching" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "DisableDynamicShutdownUI" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "DisableHardwareComposition" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "DisableHologramCompositor" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "DisableIndependentFlip" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "DisableLockingMemory" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "DisableProjectedShadows" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "DisableProjectedShadowsRendering" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "DisallowColorizationColorChanges" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "DisallowComposition" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "DisallowNonDrawListRendering" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "DiscardSurfaceOnMinimize" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "EnableAcrylicBlur" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "EnableAeroPeek" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "EnableBackdropBrush" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "EnableCommonSuperSets" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "EnableCpuClipping" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "EnableDDisplayScanoutCaching" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "EnableDesktopOverlays" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "EnableDrawToBackbuffer" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "EnableEffectCaching" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "EnableFrontBufferRenderChecks" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "EnableImageProcessing" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "EnableInputPrediction" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "EnableMegaRects" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "EnableMPCPerfCounter" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "EnablePrimitiveReordering" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "EnableRenderPathTestMode" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "EnableResizeOptimization" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "EnableShadow" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "EnableWindowColorization" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "FlattenVirtualSurfaceEffectInput" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "ForceDirectDrawSync" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "ForceDisableModeChangeAnimation" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "ForceEffectMode" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "ForceGdiComposition" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "ForceModeEnumeration" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "ForceSoftwareD3D" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "FrameLatency" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "HighColor" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "ImageProcessing8bit" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "InitialWatchdogTelemetryTimeoutMilliseconds" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "InkGPUAccelOverrideVendorWhitelist" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "InteractionOutputPredictionDisabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "LogExpressionPerfStats" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "MarshalAllDebugInfo" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "MaxBufferCount" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "MaxD3DFeatureLevel" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "MaxOutstandingFrames" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "MaxQueuedFrames" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "MaxQueuedPresentBuffers" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "m_bufferCount" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "MegaRectSearchCount" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "MegaRectSize" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "MousewheelAnimationDurationMs" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "MouseWheelScrollingMode" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "MPCInputRouterWaitForDebugger" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "OneCoreNoBootDWM" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "OneCoreNoDWMRawGameController" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "OptimizeForDirtyExpressions" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "OverlayDisqualifyCount" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "OverlayDisqualifyInterval" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "OverlayMinFPS" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "OverlayQualifyCount" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "OverlayQualifyInterval" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "ParallelModeLeaveAfterThresholdMS" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "ParallelModePolicy" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "RecurringWatchdogTelemetryTimeoutMilliseconds" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "RenderThreadWatchdogTimeoutMilliseconds" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "ResampleInLinearSpace" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "ResampleModeOverride" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "ResizeTimeoutGdi" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "ResizeTimeoutModern" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "RetryFrameOnDrop" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "SDRBoostPercentOverride" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "ShowDirtyRegions" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "SuperWetEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "SuperWetExtensionTimeMicroseconds" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "SwapEffect" /t REG_DWORD /d "2" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "TelemetryFramesReportPeriodMilliseconds" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "TelemetryFramesSequenceIdleIntervalMilliseconds" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "TelemetryFramesSequenceMaximumPeriodMilliseconds" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "UseCopyOnPresent" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "UseDpiScaling" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "UseHWDrawListEntriesOnWARP" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "UseLegacyDisplayFrameBuffer" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "UseMachineCheck" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\Dwm" /v "UseStaticComposition" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\DWM" /v "AlwaysHibernateThumbnails" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\DWM" /v "AnimationAttributionEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\DWM" /v "AnimationAttributionHashingEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\DWM" /v "Blur" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\DWM" /v "ColorizationGlassAttribute" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\DWM" /v "Composition" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\DWM" /v "CompositionPolicy" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\DWM" /v "DisableAccentGradient" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\DWM" /v "DisableHologramCompositor" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\DWM" /v "DisallowAnimations" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\DWM" /v "DisallowColorizationColorChanges" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\DWM" /v "DisallowFlip3d" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\DWM" /v "DWMWA_TRANSITIONS_FORCEDISABLED" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\DWM" /v "EnableAeroPeek" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\DWM" /v "EnableShadow" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\DWM" /v "OneCoreNoBootDWM" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\DWM" /v "UseDpiScaling" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\DWM" /v "UseWindowFrameStagingBuffer" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DWM" /v "AnimationAttributionEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DWM" /v "AnimationAttributionHashingEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DWM" /v "Composition" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DWM" /v "DisableAccentGradient" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DWM" /v "DisallowAnimations" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DWM" /v "DisallowColorizationColorChanges" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DWM" /v "DisallowComposition" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DWM" /v "DisallowFlip3d" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DWM" /v "DWMWA_TRANSITIONS_FORCEDISABLED" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DWM" /v "EnableAeroPeek" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DWM" /v "AnimationAttributionEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DWM" /v "AnimationAttributionHashingEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DWM" /v "Composition" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DWM" /v "DisableAccentGradient" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DWM" /v "DisallowAnimations" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DWM" /v "DisallowColorizationColorChanges" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DWM" /v "DisallowComposition" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DWM" /v "DisallowFlip3d" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DWM" /v "DWMWA_TRANSITIONS_FORCEDISABLED" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DWM" /v "EnableAeroPeek" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\DWM\ExtendedComposition" /v "Blur" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\DWM\ExtendedComposition" /v "Composition" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\DWM\ExtendedComposition" /v "CompositionPolicy" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\DWM\ExtendedComposition" /v "Compositor" /t REG_SZ /d "" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\DWM\ExtendedComposition" /v "EnableAeroPeek" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\DWM\ExtendedComposition" /v "EnableColorSeparation" /t REG_DWORD /d "0" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\DWM\ExtendedComposition" /v "ExclusiveModeFramerateAveragingPeriodMs" /t REG_DWORD /d "1000" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\DWM\ExtendedComposition" /v "ExclusiveModeFramerateThresholdPercent" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\DWM\ExtendedComposition" /v "ForwardOnlyOnly" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\DWM\ExtendedComposition" /v "RemoveSRMeshInShell" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\DWM\ExtendedComposition" /v "SydneyDownsampleFilterKernelSize" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm\Scene" /v "EnableDrawToBackbuffer" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Dwm\Scene" /v "MsaaQualityMode" /t REG_DWORD /d "0" /f
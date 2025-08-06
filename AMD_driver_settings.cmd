@echo off

echo. 
echo This script sets up settings on the amd adrenalin driver.
echo. 
pause

rem # Disable Radeon Upscaling
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "RADEON_UPSCALING" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "RADEON_UPSCALING_NA" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "KMD_RadeonUpscalingEnabled" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "KMD_RadeonUpscalingSupport" /t REG_DWORD /d "0" /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "DynamicContrast_NA" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "DynamicContrast_DEF" /t REG_SZ /d "0" /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "hotkeys_ui_component_na" /t REG_SZ /d "false" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "hotkeys_ui_component_def" /t REG_SZ /d "false" /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "imagesharpening_runtime_component_na" /t REG_SZ /d "false" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "imagesharpening_runtime_component_def" /t REG_SZ /d "false" /f

rem # Radeon Chill Power Saving
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "KMD_ChillEnabled" /t REG_DWORD /d "0" /f

rem # Radeon Anti-Lag
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "KMD_DeLagEnabled" /t REG_DWORD /d "0" /f

rem # Image Sharpening
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "KMD_USUEnable" /t REG_DWORD /d "0" /f

rem # Frame Limiter
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "KMD_FRTEnabled" /t REG_DWORD /d "0" /f

rem # Radeon Boost
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "KMD_RadeonBoostEnabled" /t REG_DWORD /d "0" /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "OverclockEnabled_NA" /t REG_SZ /d "True" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "OverclockEnabled_DEF" /t REG_SZ /d "True" /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "powermanagement_delag_component_na" /t REG_SZ /d "false" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "powermanagement_delag_component_def" /t REG_SZ /d "false" /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "CameraShakeMotionDetect_NA" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "CameraShakeMotionDetect_DEF" /t REG_SZ /d "0" /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "chill_component_na" /t REG_SZ /d "false" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "chill_component_def" /t REG_SZ /d "false" /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "AutoTuneRequest_NA" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "AutoTuneRequest_DEF" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "DDC2Disabled" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "DVRTrackingEnabledBuild" /t REG_SZ /d "0" /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "KMD_DisableVariableRefreshRate" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "KMD_EnableEventLog" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "KMD_TdrDelay" /t REG_DWORD /d "0" /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "freesync_runtime_component_na" /t REG_SZ /d "false" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "freesync_runtime_component_def" /t REG_SZ /d "false" /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "mobile_runtime_component_NA" /t REG_SZ /d "false" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "mobile_runtime_component_DEF" /t REG_SZ /d "false" /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "MobileLinkOverCloudAuth_NA" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "MobileLinkOverCloudAuth_DEF" /t REG_DWORD /d "0" /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "ogltriplebuffering_ui_component_na" /t REG_SZ /d "false" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "ogltriplebuffering_ui_component_def" /t REG_SZ /d "false" /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "PowerSaverAutoEnable_NA" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "PowerSaverAutoEnable_DEF" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "PowerSaverAutoEnable_DEF" /t REG_DWORD /d "0" /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD\DXC" "AllowDelag" /t REG_SZ /d "0" /f

rem # Disable FSAA
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "FSAAPerfMode" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "FSAAPerfMode_DEF" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "FSAAPerfMode_NA" /t REG_SZ /d "0" /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "PP_DisableULPS" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "KMD_FullScreenPowerManagement" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "FS_PWR_MGMT" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "FS_PWR_MGMT_NA" /t REG_SZ /d "0" /f


REM Adrenalin program settings (Update settings etc)
reg add "HKCU\Software\AMD\CN" /v "AllowWebContent" /t REG_SZ /d "false" /f
reg add "HKCU\Software\AMD\CN" /v "AnimationEffect" /t REG_SZ /d "false" /f
reg add "HKCU\Software\AMD\CN" /v "AutoUpdate" /t REG_DWORD /d "0" /f
reg add "HKCU\Software\AMD\CN" /v "AutoUpdateTriggered" /t REG_DWORD /d "0" /f
reg add "HKCU\Software\AMD\CN" /v "CN_Hide_FeatureData" /t REG_SZ /d "true" /f
reg add "HKCU\Software\AMD\CN" /v "CN_Hide_Toast_Notification" /t REG_SZ /d "true" /f
reg add "HKCU\Software\AMD\CN" /v "SystemTray" /t REG_SZ /d "false" /f
reg add "HKCU\Software\AMD\CN" /v "CN_Hide_Toast_Notification" /t REG_SZ /d "true" /f
reg add "HKCU\Software\AMD\CN\Performance" /v "MetricsOverlayState" /t REG_DWORD /d "0" /f
reg add "HKCU\Software\AMD\DVR" /v "HotkeysDisabled" /t REG_DWORD /d "1" /f

reg add "HKCU\Software\AMD\DVR" /v "DvrEnabled" /t REG_DWORD /d "0" /f
reg add "HKLM\Software\AMD\DVR" /v "DvrEnabled" /t REG_DWORD /d "0" /f

reg add "HKLM\SOFTWARE\AMD\AMDAnalytics" /v "AnalyticsAccepted" /t REG_SZ /d "false" /f
reg add "HKLM\SOFTWARE\WOW6432Node\AMD\AMDAnalytics" /v "AnalyticsAccepted" /t REG_SZ /d "false" /f

reg add "HKLM\SOFTWARE\AMD\Chill" /v "ProfileEnableDefault" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\AMD\Chill" /v "GlobalEnable" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\WOW6432Node\AMD\Chill" /v "ProfileEnableDefault" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\WOW6432Node\AMD\Chill" /v "GlobalEnable" /t REG_DWORD /d "0" /f


reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdkmdag" /v "DisableeRecord" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdkmdag" /v "EnableAmdLog" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdkmdag" /v "KMD_EVENT_LOG" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdkmdag" /v "KMD_EnableEventLog" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdkmdap" /v "DisableeRecord" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdkmdap" /v "EnableAmdLog" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdkmdap" /v "KMD_EVENT_LOG" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdkmdap" /v "KMD_EnableEventLog" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdkmpfd" /v "DisableeRecord" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdkmpfd" /v "EnableAmdLog" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdkmpfd" /v "KMD_EVENT_LOG" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdkmpfd" /v "KMD_EnableEventLog" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdwddmg" /v "DisableeRecord" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdwddmg" /v "EnableAmdLog" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdwddmg" /v "KMD_EVENT_LOG" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdwddmg" /v "KMD_EnableEventLog" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdgpuv" /v "DisableeRecord" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdgpuv" /v "EnableAmdLog" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdgpuv" /v "KMD_EVENT_LOG" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdgpuv" /v "KMD_EnableEventLog" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\atikmdag" /v "DisableeRecord" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\atikmdag" /v "EnableAmdLog" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\atikmdag" /v "KMD_EVENT_LOG" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\atikmdag" /v "KMD_EnableEventLog" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Atierecord" /v "eRecordEnable" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Atierecord" /v "eRecordEnablePopups" /t REG_DWORD /d "0" /f


reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "AdvancedMetrics_NA" /t REG_SZ /d "false" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "AdvancedMetrics_DEF" /t REG_SZ /d "false" /f

rem # High Quality Anisotropic Filtering
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "AreaAniso_NA" /t REG_SZ /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "AreaAniso_DEF" /t REG_SZ /d "1" /f

rem # Adaptive Sampled Transparent Textures AA
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "ASTT_NA" /t REG_SZ /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "ASTT_DEF" /t REG_SZ /d "1" /f

rem # AA extra options
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "AAF_NA" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "AAF_DEF" /t REG_SZ /d "0" /f

rem # Adaptive AA
rem # -1 = Off / 0 = Smooth / 1 = Smoother / 2 = Smoothest / 3 = Smooth (sharp)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "ATMS_NA" /t REG_SZ /d "-1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "ATMS_DEF" /t REG_SZ /d "-1" /f

rem # Super Sampling on Adaptive Anti Aliasing
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "ASE_NA" /t REG_SZ /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "ASE_DEF" /t REG_SZ /d "1" /f

rem # Super Sampling
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "ASD_NA" /t REG_SZ /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "ASD_DEF" /t REG_SZ /d "1" /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "AutoColorDepthReduction_NA" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "AutoColorDepthReduction_DEF" /t REG_DWORD /d "0" /f

rem # Enchanced Quality Mode for AA
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "EQAA_NA" /t REG_SZ /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "EQAA_DEF" /t REG_SZ /d "1" /f

rem # Geometry Instancing
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "GI_NA" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "GI_DEF" /t REG_SZ /d "0" /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "KMD_RadeonBoostEnabled" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "KMD_RadeonUpscalingEnabled" /t REG_DWORD /d "0" /f

rem # Morphological AA
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "MLF_NA" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "MLF_DEF" /t REG_SZ /d "0" /f

rem # Texture Filtering Quality
rem # 0 = High / 2 = Performance
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "TFQ_NA" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "TFQ_DEF" /t REG_SZ /d "0" /f

rem # Multi-GPU rendering mode
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "MVPU_NA" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "MVPU_DEF" /t REG_SZ /d "0" /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "AAAMethod_NA" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "AAAMethod_DEF" /t REG_SZ /d "0" /f

rem # Anisotropic Filtering: 0 = Off / 2x / 4x / 8x / 16x
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "AnisoDegree_NA" /t REG_SZ /d "16" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "AnisoDegree_DEF" /t REG_SZ /d "16" /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "AnisoType_NA" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "AnisoType_DEF" /t REG_SZ /d "0" /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "AntiAlias_NA" /t REG_SZ /d "2" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "AntiAlias_DEF" /t REG_SZ /d "2" /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "AntiAliasSamples_NA" /t REG_SZ /d "8" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "AntiAliasSamples_DEF" /t REG_SZ /d "8" /f

rem # Disable TAA (Temporal Anti-Aliasing)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "TemporalAAMultiplier" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "TemporalAAMultiplier_NA" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "TemporalAAMultiplier_DEF" /t REG_SZ /d "0" /f

reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdkmdag" /v "TemporalAAMultiplier" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdkmdag" /v "TemporalAAMultiplier_DEF" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdkmdag" /v "TemporalAAMultiplier_NA" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdkmdap" /v "TemporalAAMultiplier" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdkmdap" /v "TemporalAAMultiplier_DEF" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdkmdap" /v "TemporalAAMultiplier_NA" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdkmpfd" /v "TemporalAAMultiplier" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdkmpfd" /v "TemporalAAMultiplier_DEF" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdkmpfd" /v "TemporalAAMultiplier_NA" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdwddmg" /v "TemporalAAMultiplier" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdwddmg" /v "TemporalAAMultiplier_DEF" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdwddmg" /v "TemporalAAMultiplier_NA" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdgpuv" /v "TemporalAAMultiplier" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdgpuv" /v "TemporalAAMultiplier_DEF" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdgpuv" /v "TemporalAAMultiplier_NA" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\atikmdag" /v "TemporalAAMultiplier" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\atikmdag" /v "TemporalAAMultiplier_DEF" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\atikmdag" /v "TemporalAAMultiplier_NA" /t REG_SZ /d "0" /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "CatalystAI_NA" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "CatalystAI_DEF" /t REG_SZ /d "0" /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "EnableTripleBuffering_NA" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "EnableTripleBuffering_DEF" /t REG_SZ /d "0" /f

rem # Experimental buffering tweak
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "GLPBMode_NA" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "GLPBMode_DEF" /t REG_SZ /d "0" /f

rem # Surface Format Optimizations (LEGACY: DISABLE)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "SurfaceFormatReplacements_NA" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "SurfaceFormatReplacements_DEF" /t REG_SZ /d "0" /f

rem # 0 = AMD Optimized / 1 = Default On / 2 = Always On
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "Tessellation_OPTION_NA" /t REG_SZ /d "2" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "Tessellation_OPTION_DEF" /t REG_SZ /d "2" /f

rem # 1 = Off / 2 / 4 / 6 / 8 / 16 / 32 / 64
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "Tessellation_NA" /t REG_SZ /d "64" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "Tessellation_DEF" /t REG_SZ /d "64" /f

rem # Texture Optimizations
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "TextureOpt_NA" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "TextureOpt_DEF" /t REG_SZ /d "0" /f

rem # Texture Level of Detail
rem # 3 = High Performance / 2 = Performance / 1 = Quality / 0 = High Quality / -1 = Very High Quality
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "TextureLod_NA" /t REG_SZ /d "-1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "TextureLod_DEF" /t REG_SZ /d "-1" /f

rem # 0 = Always Off / 1 = Default Off / 2 = Default On / 3 = Always On
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "VSyncControl_NA" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "VSyncControl_DEF" /t REG_SZ /d "0" /f

rem # Truform Tessellation (LEGACY: DISABLE)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i" /v "TruformMode_NA" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\%%i\UMD" /v "TruformMode_DEF" /t REG_SZ /d "0" /f




echo.
echo All settings are set in amd adrenalin.
echo.

pause
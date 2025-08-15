----------------------------------------------------------
-- Simple Launch/Focus hotkeys（仅启动/聚焦，不做切换隐藏）
-- Ctrl+C  → ChatGPT（PWA 或原生 App）
-- Ctrl+J  → Firefox（火狐浏览器 Firefox）
-- Ctrl+K  → VS Code（Visual Studio Code）
-- Ctrl+H  → Finder（访达 Finder）
-- Ctrl+T  → Terminal（终端 Terminal）
-- Ctrl+Y  → GitHub Desktop
------------------------------------------------------------

local function openApp(target)
  -- target 可包含 bundleID（程序包标识 Bundle Identifier）、name（应用名 Application Name）、path（路径 Path）
  local ok = false
  if target.bundleID then
    ok = hs.application.launchOrFocusByBundleID(target.bundleID)
  end
  if not ok and target.name then
    ok = hs.application.launchOrFocus(target.name)
  end
  if not ok and target.path then
    hs.execute('open -a "' .. target.path .. '"', true)
  end
end

local function bindOpen(mods, key, target)
  hs.hotkey.bind(mods, key, function() openApp(target) end)
end

------------------------------------------------------------
-- 目标应用（Targets）
-- 提示：使用 bundleID（程序包标识 Bundle Identifier）更稳；name 作为后备
-- 查 bundleID：在终端（Terminal）执行
--   mdls -name kMDItemCFBundleIdentifier "/完整路径/YourApp.app"
------------------------------------------------------------
local TARGETS = {
  -- ChatGPT（若为 Chrome 安装的 PWA，bundleID 通常形如 com.google.Chrome.app.xxxxx）
  -- 先用 name="ChatGPT" 试用；若不行再把 bundleID 填上。
  chatgpt = { bundleID = nil, name = "ChatGPT" },

  firefox = { bundleID = "org.mozilla.firefox",     name = "Firefox" },
  vscode  = { bundleID = "com.microsoft.VSCode",    name = "Visual Studio Code" },
  finder  = { bundleID = "com.apple.finder",        name = "Finder" },
  terminal= { bundleID = "com.apple.Terminal",      name = "Terminal" },
  ghdesk  = { bundleID = "com.github.GitHub",       name = "GitHub Desktop" },
}

------------------------------------------------------------
-- 热键绑定（Hotkeys）
------------------------------------------------------------
bindOpen({ "ctrl" }, "c", TARGETS.chatgpt)   -- Ctrl+C → ChatGPT
bindOpen({ "ctrl" }, "j", TARGETS.firefox)   -- Ctrl+J → Firefox
bindOpen({ "ctrl" }, "k", TARGETS.vscode)    -- Ctrl+K → VS Code
bindOpen({ "ctrl" }, "h", TARGETS.finder)    -- Ctrl+H → Finder
bindOpen({ "ctrl" }, "t", TARGETS.terminal)  -- Ctrl+T → Terminal
bindOpen({ "ctrl" }, "y", TARGETS.ghdesk)    -- Ctrl+Y → GitHub Desktop

------------------------------------------------------------
-- Simple Launch/Focus hotkeys（仅启动/聚焦，不做切换隐藏）
-- Ctrl+A  → ChatGPT（PWA；在终端 Terminal 中禁用）
-- Ctrl+S  → Claude/Cloud（PWA；在终端 Terminal 中禁用）
-- Ctrl+D  → Gemini（PWA；在终端 Terminal 中禁用）
-- Ctrl+J  → Firefox（火狐浏览器 Firefox）
-- Ctrl+K  → VS Code（Visual Studio Code）
-- Ctrl+H  → Finder（访达 Finder）
-- Ctrl+T  → Terminal（终端 Terminal）
-- Ctrl+Y  → GitHub Desktop
-- Ctrl+X  → Chrome（Google Chrome）
-- Ctrl+Q  → ChatGPT Atlas
-- Ctrl+W  → Preview（预览 Preview）
------------------------------------------------------------

local function openApp(target)
  -- target 可包含 bundleID（程序包标识 Bundle Identifier）、name（应用名 Application Name，支持字符串或表）、path（路径 Path）
  local ok = false
  if target.bundleID then
    ok = hs.application.launchOrFocusByBundleID(target.bundleID)
  end
  if not ok and target.name then
    if type(target.name) == "table" then
      for _, n in ipairs(target.name) do
        ok = hs.application.launchOrFocus(n)
        if ok then break end
      end
    else
      ok = hs.application.launchOrFocus(target.name)
    end
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
-- Chrome PWA 通常在：~/Applications/Chrome Apps.localized/
------------------------------------------------------------
local TARGETS = {
  -- ChatGPT（PWA 名称可能是 "ChatGPT"）
  chatgpt = { bundleID = nil, name = { "ChatGPT" } },

  -- Claude (PWA 名称可能是 "Claude"、"Claude.ai"）
  claude  = { bundleID = nil, name = { "Claude", "Claude.ai"} },

  -- Gemini（PWA 名称可能是 "Gemini"、"Google Gemini"）
  gemini  = { bundleID = nil, name = { "Gemini", "Google Gemini" } },

  firefox = { bundleID = "org.mozilla.firefox",     name = "Firefox" },
  chrome  = { bundleID = "com.google.chrome",       name = "Chrome" },
  vscode  = { bundleID = "com.microsoft.VSCode",    name = "Visual Studio Code" },
  finder  = { bundleID = "com.apple.finder",        name = "Finder" },
  terminal= { bundleID = "com.apple.Terminal",      name = "Terminal" },
  ghdesk  = { bundleID = "com.github.GitHub",       name = "GitHub Desktop" },
  preview = { bundleID = "com.apple.Preview",       name = "Preview" },
  atlas   = { bundleID = "com.openai.atlas",        name = "ChatGPT Atlas" },
}

------------------------------------------------------------
-- 在这些应用前台时屏蔽（disable）Ctrl+A / Ctrl+S / Ctrl+D（用于 PWA）
-- Block list for frontmost apps（在这些前台应用里禁用热键）
------------------------------------------------------------
local BLOCK_BUNDLE_IDS = {
  ["com.apple.Terminal"] = true,       -- 终端（Terminal）
  -- 如也希望在 iTerm2 等里禁用，取消下面注释即可：
  -- ["com.googlecode.iterm2"] = true, -- iTerm2
  -- ["org.alacritty"] = true,         -- Alacritty
  -- ["com.github.wez.wezterm"] = true -- WezTerm
}

-- 判断当前是否在需屏蔽的前台应用（frontmost app）
local function inBlockedApp()
  local front = hs.application.frontmostApplication()
  local bid = front and front:bundleID() or ""
  return BLOCK_BUNDLE_IDS[bid] == true
end

------------------------------------------------------------
-- 三个可控热键对象（hotkey objects（热键对象））
-- 统一放到一个表里，便于一起启用/禁用
------------------------------------------------------------
local managedHotkeys = {
  hs.hotkey.new({ "ctrl" }, "a", function() openApp(TARGETS.chatgpt) end), -- Ctrl+A → ChatGPT
  hs.hotkey.new({ "ctrl" }, "s", function() openApp(TARGETS.claude)  end), -- Ctrl+S → Claude/Cloud
  hs.hotkey.new({ "ctrl" }, "d", function() openApp(TARGETS.gemini)  end), -- Ctrl+D → Gemini
}

-- 根据当前前台应用启用/禁用三组热键
local function refreshManagedHotkeys()
  if inBlockedApp() then
    for _, hk in ipairs(managedHotkeys) do hk:disable() end
  else
    for _, hk in ipairs(managedHotkeys) do hk:enable() end
  end
end

-- 应用监视器（application watcher（应用监视器））
local appWatcher = hs.application.watcher.new(function(_, eventType, _)
  if eventType == hs.application.watcher.activated then
    refreshManagedHotkeys()
  end
end)
appWatcher:start()

-- 初始化一次（initial state（初始状态））
refreshManagedHotkeys()

------------------------------------------------------------
-- 其它热键绑定（Hotkeys）
-- 注意：Ctrl+A / Ctrl+S / Ctrl+D 已由上面的 managedHotkeys 管理，这里不再 bind。
------------------------------------------------------------
bindOpen({ "ctrl" }, "j", TARGETS.firefox)   -- Ctrl+J → Firefox
bindOpen({ "ctrl" }, "k", TARGETS.vscode)    -- Ctrl+K → VS Code
bindOpen({ "ctrl" }, "h", TARGETS.finder)    -- Ctrl+H → Finder
bindOpen({ "ctrl" }, "t", TARGETS.terminal)  -- Ctrl+T → Terminal
bindOpen({ "ctrl" }, "y", TARGETS.ghdesk)    -- Ctrl+Y → GitHub Desktop
bindOpen({ "ctrl" }, "x", TARGETS.chrome)    -- Ctrl+X → Chrome
bindOpen({ "ctrl" }, "q", TARGETS.atlas)     -- Ctrl+Q → ChatGPT Atlas
bindOpen({ "ctrl" }, "w", TARGETS.preview)   -- Ctrl+W → Preview

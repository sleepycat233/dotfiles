------------------------------------------------------------
-- Simple Launch/Focus hotkeys（仅启动/聚焦，不做切换隐藏）
-- Ctrl+A  → ChatGPT（PWA；在终端 Terminal 中禁用）
-- Ctrl+S  → Claude/Cloud（PWA；在终端 Terminal 中禁用）
-- Ctrl+D  → Gemini（PWA；在终端 Terminal 中禁用）
-- Ctrl+J  → Firefox（火狐浏览器 Firefox）
-- Ctrl+K  → VS Code（Visual Studio Code）
-- Ctrl+H  → Finder（访达 Finder）
-- Ctrl+T  → iTerm2（终端 iTerm2）
-- Ctrl+G  → GitHub Desktop
-- Ctrl+X  → Chrome（Google Chrome）
-- Ctrl+Q  → ChatGPT Atlas
-- Ctrl+W  → Preview（预览 Preview）
-- Ctrl+Z  → Codex
-- Ctrl+F  → FreeCAD
-- Option+F       → FreeCAD 截图 → GPT Atlas 粘贴（Screenshot Workflow）
-- Option+Shift+F → 手动选区截图 → GPT Atlas 粘贴
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
  claude  = { bundleID = "com.anthropic.claudefordesktop", name = "Claude" },

  -- Gemini（PWA 名称可能是 "Gemini"、"Google Gemini"）
  gemini  = { bundleID = nil, name = { "Gemini", "Google Gemini" } },

  firefox = { bundleID = "org.mozilla.firefox",     name = "Firefox" },
  chrome  = { bundleID = "com.google.chrome",       name = "Chrome" },
  vscode  = { bundleID = "com.microsoft.VSCode",    name = "Visual Studio Code" },
  finder  = { bundleID = "com.apple.finder",        name = "Finder" },
  terminal= { bundleID = "com.googlecode.iterm2",   name = "iTerm2" },
  ghdesk  = { bundleID = "com.github.GitHub",       name = "GitHub Desktop" },
  preview = { bundleID = "com.apple.Preview",       name = "Preview" },
  atlas   = { bundleID = "com.openai.atlas",        name = "ChatGPT Atlas" },
  obsidian= { bundleID = "md.obsidian",             name = "Obsidian" },
  antigravity={ bundleID = "com.google.antigravity",      name = "Antigravity" },
  codex   = { bundleID = "com.openai.codex",        name = "Codex" },
  freecad = { bundleID = nil,                        name = "FreeCAD" },
}

------------------------------------------------------------
-- 在这些应用前台时屏蔽（disable）Ctrl+A / Ctrl+S / Ctrl+D（用于 PWA）
-- Block list for frontmost apps（在这些前台应用里禁用热键）
------------------------------------------------------------
local BLOCK_BUNDLE_IDS = {
  ["com.googlecode.iterm2"] = true,    -- iTerm2
  -- 如也希望在其它终端里禁用，取消下面注释即可：
  -- ["com.apple.Terminal"] = true,    -- Terminal
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
-- 截图 → GPT Atlas 工作流（Screenshot Workflow）
-- Option+F      ：截图当前 FreeCAD 窗口 → 粘贴到 GPT Atlas
-- Option+Shift+F：手动选区截图 → 粘贴到 GPT Atlas
------------------------------------------------------------

-- ▸ 配置区（Configuration）
local SCREENSHOT_CFG = {
  freecadName = "FreeCAD",       -- FreeCAD 应用名（application name）
  atlasTarget = TARGETS.atlas,   -- GPT Atlas 目标（target）
  defaultPrompt = nil,           -- 粘贴后自动输入的默认提示词（nil = 不输入）
                                 -- 示例: "请解释这个 FreeCAD 界面"
  delayAfterScreenshot = 0.3,    -- 截图后等待时间（秒）
  delayAfterSwitch     = 0.8,    -- 切换应用后等待时间（秒）
  delayBeforePaste     = 0.3,    -- 粘贴前等待时间（秒）
  playSound            = true,   -- 完成后播放提示音（play sound on completion）
}

-- ▸ 共用：切换到 GPT Atlas 并粘贴剪贴板中的截图
local function switchToAtlasAndPaste()
  hs.timer.doAfter(SCREENSHOT_CFG.delayAfterScreenshot, function()
    local atlasOk = false
    local atlas = SCREENSHOT_CFG.atlasTarget

    if atlas.bundleID then
      atlasOk = hs.application.launchOrFocusByBundleID(atlas.bundleID)
    end
    if not atlasOk and atlas.name then
      if type(atlas.name) == "table" then
        for _, n in ipairs(atlas.name) do
          atlasOk = hs.application.launchOrFocus(n)
          if atlasOk then break end
        end
      else
        atlasOk = hs.application.launchOrFocus(atlas.name)
      end
    end

    if not atlasOk then
      hs.alert.show("⚠️ 无法打开 GPT Atlas")
      return
    end

    hs.timer.doAfter(SCREENSHOT_CFG.delayAfterSwitch, function()
      local atlasApp = hs.application.frontmostApplication()
      local atlasName = atlasApp and atlasApp:name() or ""
      if not string.find(atlasName, "Atlas", 1, true)
         and not string.find(atlasName, "ChatGPT", 1, true)
         and not string.find(atlasName, "GPT", 1, true) then
        hs.alert.show("⚠️ GPT Atlas 未能切到前台，请手动切换")
        return
      end

      local atlasWin = atlasApp:focusedWindow()
      if atlasWin then atlasWin:focus() end

      hs.timer.doAfter(SCREENSHOT_CFG.delayBeforePaste, function()
        hs.eventtap.keyStroke({ "cmd" }, "v")

        if SCREENSHOT_CFG.defaultPrompt then
          hs.timer.doAfter(0.3, function()
            hs.eventtap.keyStrokes(SCREENSHOT_CFG.defaultPrompt)
          end)
        end

        if SCREENSHOT_CFG.playSound then
          hs.timer.doAfter(0.2, function()
            local sound = hs.sound.getByFile("/System/Library/Sounds/Glass.aiff")
            if sound then sound:play() end
            hs.alert.show("✅ 截图已粘贴到 GPT Atlas", 1.5)
          end)
        end
      end)
    end)
  end)
end

-- ▸ Option+F：截图当前 FreeCAD 窗口 → 粘贴到 Atlas
hs.hotkey.bind({ "alt" }, "f", function()
  local frontApp = hs.application.frontmostApplication()
  if not frontApp then
    hs.alert.show("⚠️ 无法获取当前前台应用")
    return
  end

  local appName = frontApp:name() or ""
  if not string.find(appName, SCREENSHOT_CFG.freecadName, 1, true) then
    hs.alert.show("⚠️ 当前前台应用不是 FreeCAD（当前: " .. appName .. "）")
    return
  end

  local win = frontApp:focusedWindow()
  if not win then
    hs.alert.show("⚠️ 无法获取 FreeCAD 当前窗口")
    return
  end

  local cmd = string.format("/usr/sbin/screencapture -c -o -x -l %d", win:id())
  local _, status, _, rc = hs.execute(cmd)
  if not status then
    hs.alert.show("⚠️ 截图失败（screencapture 返回: " .. tostring(rc) .. "）")
    return
  end

  if not hs.pasteboard.readImage() then
    hs.alert.show("⚠️ 截图失败：剪贴板中没有图片")
    return
  end

  switchToAtlasAndPaste()
end)

-- ▸ Option+Shift+F：手动选区截图 → 粘贴到 Atlas（不限于 FreeCAD）
hs.hotkey.bind({ "alt", "shift" }, "f", function()
  -- -c 写入剪贴板，-i 交互模式，-s 仅选区模式，-x 不播放快门声
  local _, status = hs.execute("/usr/sbin/screencapture -c -i -s -x")
  if not status then
    hs.alert.show("⚠️ 截图失败或已取消")
    return
  end

  if not hs.pasteboard.readImage() then
    -- 用户按了 Esc 取消选区，静默退出
    return
  end

  switchToAtlasAndPaste()
end)

------------------------------------------------------------
-- 其它热键绑定（Hotkeys）
-- 注意：Ctrl+A / Ctrl+S / Ctrl+D 已由上面的 managedHotkeys 管理，这里不再 bind。
------------------------------------------------------------
bindOpen({ "ctrl" }, "j", TARGETS.firefox)   -- Ctrl+J → Firefox
bindOpen({ "ctrl" }, "k", TARGETS.vscode)    -- Ctrl+K → VS Code
bindOpen({ "ctrl" }, "h", TARGETS.finder)    -- Ctrl+H → Finder
hs.hotkey.bind({ "ctrl" }, "t", function()   -- Ctrl+T → iTerm2（所有窗口）
  local app = hs.application.get(TARGETS.terminal.bundleID)
  if app then
    app:activate(true)  -- true = 将所有窗口带到前台
  else
    openApp(TARGETS.terminal)
  end
end)
bindOpen({ "ctrl" }, "g", TARGETS.ghdesk)    -- Ctrl+G → GitHub Desktop
bindOpen({ "ctrl" }, "x", TARGETS.chrome)    -- Ctrl+X → Chrome
bindOpen({ "ctrl" }, "q", TARGETS.atlas)     -- Ctrl+Q → ChatGPT Atlas
-- bindOpen({ "ctrl" }, "w", TARGETS.antigravity) -- Ctrl+W → Antigravity
bindOpen({ "ctrl" }, "w", TARGETS.preview) -- Ctrl+W → Preview
bindOpen({ "ctrl" }, "u", TARGETS.obsidian)     -- Ctrl+U → Obsidian
bindOpen({ "ctrl" }, "z", TARGETS.codex)        -- Ctrl+Z → Codex
bindOpen({ "ctrl" }, "f", TARGETS.freecad)       -- Ctrl+F → FreeCAD

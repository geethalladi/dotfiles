-- simple alert
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "w", function()
  hs.alert.show("hello, world!")
  -- did not work
  -- hs.notify.new({title="Hammerspoon", informativeText="Hello, World!"}):send()
  -- hs.notify.show("Hammerspoon", "notify", "hello, world!")
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "r", function()
  hs.alert.show('reload hs config')
  hs.reload()
end)

function emacsclientWatcher(appName, eventType, appObject)
 if (eventType == hs.application.watcher.activated) then
  -- hs.alert.show(appName)
  if (appName == "OrgProtocol") then
   -- Bring Emacs to Front
   hs.osascript.applescript('tell application "Emacs" to activate')
  end
  -- if (appName == "Emacs") then
  --  -- Bring Emacs to Front
  --  hs.osascript.applescript('tell application "Emacs" to activate')
  -- end
  -- if (appName == "emacsclient") then
  --  -- Bring Emacs to Front
  --  hs.osascript.applescript('tell application "Emacs" to activate')
  -- end
 end
end
appWatcher = hs.application.watcher.new(emacsclientWatcher)
appWatcher:start()

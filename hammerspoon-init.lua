-- Раскладки, которыми хотите управлять
local sources = {
    en = "com.apple.keylayout.ABC",
    ru = "com.apple.keylayout.RussianWin",
}

-- Определите порядок переключения
local cycle = {
    sources.en,
    sources.ru,
}

local suppress = false               -- флаг, чтобы не ловить собственные переключения
local currentDesired = hs.keycodes.currentSourceID()

-- Функция установки/запоминания текущей раскладки
local function applySource(id)
    if not id then return end
    if currentDesired ~= id then
        currentDesired = id
    end
    if hs.keycodes.currentSourceID() ~= id then
        suppress = true
        hs.keycodes.currentSourceID(id)
        hs.timer.doAfter(0.1, function() suppress = false end)
    end
end

-- Горячая клавиша: вперёд по списку (⌃Space)
hs.hotkey.bind({ "ctrl" }, "space", function()
    local idx = hs.fnutils.indexOf(cycle, currentDesired) or 1
    local nextIdx = (idx % #cycle) + 1
    applySource(cycle[nextIdx])
end)

-- Горячая клавиша: назад (⌃⇧Space)
hs.hotkey.bind({ "ctrl", "shift" }, "space", function()
    local idx = hs.fnutils.indexOf(cycle, currentDesired) or 1
    local prevIdx = ((idx - 2) % #cycle) + 1
    applySource(cycle[prevIdx])
end)

-- Если пользователь поменял раскладку любым другим способом,
-- запоминаем её (чтобы цикл продолжался с правильного места),
-- но не даём macOS удерживать отдельную раскладку «по окнам».
hs.keycodes.inputSourceChanged(function()
    if suppress then return end
    local newID = hs.keycodes.currentSourceID()
    currentDesired = newID
end)

-- Всегда возвращаемся к «глобальной» раскладке при смене окна/Space
local wf = hs.window.filter.new()
wf:subscribe(
    {
        hs.window.filter.windowFocused,
        hs.window.filter.windowCreated,
        hs.window.filter.windowsChanged,
    },
    function()
        applySource(currentDesired)
    end
)

-- На случай переключения Spaces без смены окна
local spaceWatcher = hs.spaces.watcher.new(function()
    applySource(currentDesired)
end)
spaceWatcher:start()

-- Применяем раскладку при запуске (чтобы macOS не навязала старые настройки)
applySource(currentDesired)


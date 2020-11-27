--[[ Ver.1.0 Вы можете делать практически всё что хотите с этим авто-ответчиком, но вы должны написать автора в видном месте и оставить ссылку на оригинальную тему (mhertz & https://www.blast.hk/threads/68215/). ]]--
script_name("IAH Reloaded")
script_authors("mhertz")
script_version(1.0)
IAH2_version_id = 1
local imgui = require 'imgui'
local encoding = require 'encoding'
require 'lib.moonloader'
local sp                    = require 'lib.samp.events'
local as_action             = require('moonloader').audiostream_state
local dl                    = require('moonloader').download_status
local https                 = require "ssl.https"

-- Тема

imgui.SwitchContext()
local style = imgui.GetStyle()
local colors = style.Colors
local clr = imgui.Col
local ImVec4 = imgui.ImVec4

function apply_custom_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    local ImVec2 = imgui.ImVec2

    style.WindowPadding = ImVec2(15, 15)
    style.WindowRounding = 5.0
    style.FramePadding = ImVec2(5, 5)
    style.FrameRounding = 4.0
    style.ItemSpacing = ImVec2(12, 8)
    style.ItemInnerSpacing = ImVec2(8, 6)
    style.IndentSpacing = 25.0
    style.ScrollbarSize = 15.0
    style.ScrollbarRounding = 9.0
    style.GrabMinSize = 5.0
    style.GrabRounding = 3.0

    colors[clr.Text] = ImVec4(0.80, 0.80, 0.83, 1.00)
    colors[clr.TextDisabled] = ImVec4(0.24, 0.23, 0.29, 1.00)
    colors[clr.WindowBg] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.ChildWindowBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
    colors[clr.PopupBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
    colors[clr.Border] = ImVec4(0.80, 0.80, 0.83, 0.88)
    colors[clr.BorderShadow] = ImVec4(0.92, 0.91, 0.88, 0.00)
    colors[clr.FrameBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.FrameBgHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
    colors[clr.FrameBgActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.TitleBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.TitleBgCollapsed] = ImVec4(1.00, 0.98, 0.95, 0.75)
    colors[clr.TitleBgActive] = ImVec4(0.07, 0.07, 0.09, 1.00)
    colors[clr.MenuBarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.ScrollbarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.ScrollbarGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
    colors[clr.ScrollbarGrabHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.ScrollbarGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.ComboBg] = ImVec4(0.19, 0.18, 0.21, 1.00)
    colors[clr.CheckMark] = ImVec4(0.80, 0.80, 0.83, 0.31)
    colors[clr.SliderGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
    colors[clr.SliderGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.Button] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.ButtonHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
    colors[clr.ButtonActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.Header] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.HeaderHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.HeaderActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.ResizeGrip] = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.ResizeGripHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
    colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
    colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
    colors[clr.PlotLines] = ImVec4(0.40, 0.39, 0.38, 0.63)
    colors[clr.PlotLinesHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
    colors[clr.PlotHistogram] = ImVec4(0.40, 0.39, 0.38, 0.63)
    colors[clr.PlotHistogramHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
    colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43)
    colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)
end
apply_custom_style()

encoding.default = 'CP1251'
u8 = encoding.UTF8

-- Числа
numbers = {
    ['ноль'] = 0,
    ['нулю'] = 0,
    ['один'] = 1,
    ['единице'] = 1,
    ['единица'] = 1,
    ['одному'] = 1,
    ['два'] = 2,
    ['двум'] = 2,
    ['три'] = 3,
    ['трем'] = 3,
    ['четыре'] = 4,
    ['четыри'] = 4,
    ['четырем'] = 4,
    ['пять'] = 5,
    ['пяти'] = 5,
    ['шесть'] = 6,
    ['шести'] = 6,
    ['восемь'] = 8,
    ['восьми'] = 8,
    ['восми'] = 8,
    ['%s+семь'] = 7,
    ['%s+семи'] = 7,
    ['девять'] = 9,
    ['девяти'] = 9,
    ['десять'] = 10,
    ['десяти'] = 10,
    ['одиннадацать'] = 11,
    ['одиннадцати'] = 11,
    ['одинадцать'] = 11,
    ['одинадцати'] = 11,
    ['двенадцать'] = 12,
    ['двенадцати'] = 12,
    ['тринадцать'] = 13,
    ['тринадцати'] = 13,
    ['тренадцать'] = 13,
    ['тренадцати'] = 13,
    ['четырнадцать'] = 14,
    ['четырнадцати'] = 14,
    ['пятнадцать'] = 15,
    ['пятнадцати'] = 15,
    ['шестнадцать'] = 16,
    ['шестнадцати'] = 16,
    ['шеснадцать'] = 16,
    ['шеснадцати'] = 16,
    ['семнадцать'] = 17,
    ['семнадцати'] = 17,
    ['семьнадцать'] = 17,
    ['семьнадцати'] = 17,
    ['восемнадцать'] = 18,
    ['восемнадцати'] = 18,
    ['восемьнадцать'] = 18,
    ['восемьнадцати'] = 18,
    ['девятнадцать'] = 19,
    ['девятнадцати'] = 19,
    ['двадцать'] = 20,
    ['двадцати'] = 20,
    ['тридцать'] = 30,
    ['тридцати'] = 30,
    ['сорок'] = 40,
    ['сорока'] = 40,
    ['сорокеду'] = 40,
    ['пятьдесят'] = 50,
    ['пятидесяти'] = 50,
    ['шестьдесят'] = 60,
    ['шестидесяти'] = 60,
    ['семьдесят'] = 70,
    ['семидесяти'] = 70,
    ['восемьдесят'] = 80,
    ['восьмидесяти'] = 80,
    ['девяносто'] = 90,
    ['сто'] = 100,
    ['стам'] = 100
}
-- Математические Действия текстом
maths = { -- 0 умножение 1 -- деление, 2 - вычитание, 3 - плюс
    ['жды'] = '*',
    ['отнять от'] = '-',
    ['поделить на'] = '/',
    ['ю%s+'] = '*',
    ['сложить с'] = '+',
    ['прибавить'] = '+',
    ['плюс'] = '+',
    ['минус'] = '-',
    ['умножить'] = '*',
    ['разделить'] = '/',
    ['умножить на'] = '*',
    ['разделить на'] = '/'
}
-- Стандартная Конфигурация
local oconfig = {
    {
        'Да, я тут.',
        'Да.',
        'Тут',
        'У компьютера',
        'Тут я',
        'da',
        '+',
        'тут',
        'да',
        'конечно',
        'yes',
        'я тут'
    },
    {
        'ну тут я',
        'тутц я',
        'Я тут...',
        'конечно тут я',
        'да',
        '+',
        '++',
        'y',
        'yes',
        'da',
        'tut',
        'я тута'
    },
    {
        'Харе меня спрашивать',
        'Сколько уже можно...',
        'Надоели',
        'Да, я тут.',
        'tut',
        'здесь',
        'нет, б***ь'
    },
    {
        'я тебе не эйнштейн',
        'я не эйлер',
        'слишком сложно',
        'вы уже совсем',
        'хз',
        'xz',
        'сам посчитай',
        'мне лень',
        'я не гений',
        'у меня нет золотой медали',
        'у меня по математике 3',
        'у меня по алгебре 3'
    },
    {
        'Я не бот',
        'Я не робот, проверено капчей',
        'уважаемый, я не ботовожу',
        'я читы не использую',
        'net',
        'ne bot'
    },
    'У меня всё нормально',
    'Я работаю, а что тебе?',
    'Arizona RP Mesa',
    'администратор',
    'ответил вам',
    'говорит:',
    '',
    false,
    false,
    {
        ['столиц'] = {'сша', 'Вашингтон'},
        ['никит'] = {'вы', '!name, я $name.'}
    },
    true,
    true,
    'Вася',
    '((',
    ']:',
    true,
    true,
    false,
    16,
    'Администратор (.+) ответил вам%:',
    '(.+)%[%d+%] говорит%:',
    '%(%( Администратор (.+)%[%d+%]%:',
    '.+%[(%d+)%] говорит%:',
    '%(%( Администратор .+%[(%d+)%]%:',
    '%(%( Администратор .+%[(%d+)%]%:',
    false,
    true, -- 1 ГРУППА Не знаю 32
    false, -- 2 ГРУППА Не Знаю 33
    false, -- 3 ГРУППА Не Знаю 34
    {
        'не знаю',
        'хз',
        'не понял',
        'пиши по-русски',
        'не е*у',
        'не мешай'
    }, -- 35
    false, -- 36 Ответы 1 ГР
    false, -- 37 Ответы 2 ГР
    false, -- 38 Ответы 3 ГР
    {
        'эээ ты шо',
        'не мешай',
        'отвали',
        'харэ',
        'что?',
        'ты чё?',
        'да что те нужно'
    }, -- 39
    true, -- 40 Включить юзер вопросы
    true, -- 41 Звук при слапе
    true, -- 42 Отвечать при слапе
    false, -- 43 verbose
    false, -- 44 паттерны
    'Пупкин', -- 45 Фамилия
    true, -- 46 Повтор вопросов
    {
        'эээ ты шо',
        'не мешай',
        'отвали',
        'харэ',
        'что?',
        'ты чё?',
        'да что те нужно'
    }, -- 47 ТП Обыкновенное
    {
        'эээ ты шо',
        'не мешай',
        'отвали',
        'харэ',
        'что?',
        'ты чё?',
        'да что те нужно'
    }, -- 48 ТП в жопу мира
    '/botoff', -- 49 КМД офф Бота
    false, -- 50 Откл Бота при ответе
    false, -- 51 Отключать бота при ТП OOB
    false, -- 52 Ливать из игры при тп OOB
    false, -- 53 Откл Фриз
    true -- 54 Умное распознование /b / НЕТ
}
-- Паттерны в ключах
patternon = true
-- Переменная конфигурации
config = {}
-- Переменные в ответах
vartovar = { -- Если вы хотите добавить новые переменные, пишите имя и функцию.
    ['name'] = 'config[18]',
    ['surname'] = 'config[45]',
    ['servername'] = 'config[8]',
    ['mood'] = 'config[6]',
    ['status'] = 'config[7]',
    ['age'] = 'config[24]',
    ['day'] = 'tostring(os.date("*t").day)',
    ['year'] = 'tostring(os.date("*t").year)',
    ['month'] = 'tostring(os.date("*t").month)'
}
-- Транслит
engchar = {'A','a','B','b','Ch','C','ch','cc','ck','c','D','d','E','e','F','f','G','g','H','h','I','i','J','j','K','k','L','l','M','m','N','n','O','o','P','p','Q','q','R','r','Sh','Sch','S','sh','sch','s','T','t','U','u','W','w','X','x','Y','y','Z','z','V','v'}
ruschar = {'А','а','Б','б','Ч','К','ч','ч','к','к','Д','д','Е','е','Ф','ф','Г','г','Х','х','И','и','Дж','дж','К','к','Л','л','М','м','Н','н','О','о','П','п','Кв','кв','Р','р','Ш','Щ','С','ш','щ','с','Т','т','У','у','В','в','Кс','кс','И','и','З','з','В','в'}
function translit(text)
    if text == nil then
        return
    end
    for i, y in ipairs(engchar) do
        text = text:gsub(y,ruschar[i])
    end
    return text
end
-- Стандартизация текста
cyrlower = {'А', 'Б', 'В', 'Г', 'Д', 'Е', 'Ё', 'Ж', 'З', 'И', 'Й', 'К', 'Л', 'М', 'Н', 'О', 'П', 'Р', 'С', 'Т', 'У', 'Ф', 'Х', 'Ц', 'Ч', 'Ш', 'Щ', 'Ь', 'Ы', 'Ъ', 'Э', 'Ю', 'Я', 'ё','b','e','h','k','x','c','m','t','o','p','a'}
cyrlower2 = {'а', 'б', 'в', 'г', 'д', 'е', 'е', 'ж', 'з', 'и', 'й', 'к', 'л', 'м', 'н', 'о', 'п', 'р', 'с', 'т', 'у', 'ф', 'х', 'ц', 'ч', 'ш', 'щ', 'ь', 'ы', 'ъ', 'э', 'ю', 'я', 'е','в','е','н','к','х','с','м','т','о','р','а'}
function lower_cyr(text)
    if text == nil then
        return
    end
    text = string.lower(text)
    for i, y in ipairs(cyrlower) do
        text = text:gsub(y,cyrlower2[i])
    end
    return text
end
-- Переменные
local ScreenWidth, ScreenHeight = getScreenResolution()
enabled = false
delayed = false
times = 0
lastanswer = 'я тут'
-- Счетчики
patterndetected1 = 0
patterndetected2 = 0
patterndetected3 = 0
patternanswered = 0
patternyour = 0
patternnotknow = 0
patternskipped = 0
patternslapped = 0
patterntp = 0
patternoob = 0
patternrepeated = 0
-- ImGui
local main_window_state = imgui.ImBool(false)
local bar_state = imgui.ImBool(false)
local big_buffer1 = imgui.ImBuffer(4096)
local big_buffer2 = imgui.ImBuffer(4096)
local big_buffer3 = imgui.ImBuffer(4096)
local big_buffer4 = imgui.ImBuffer(4096)
local big_buffer5 = imgui.ImBuffer(4096)
local big_buffer6 = imgui.ImBuffer(8192)
local big_buffer7 = imgui.ImBuffer(4096)
local big_buffer8 = imgui.ImBuffer(4096)
local big_buffer9 = imgui.ImBuffer(4096)
local big_buffer10 = imgui.ImBuffer(4096)
local small_buffer1 = imgui.ImBuffer(32)
local small_buffer2 = imgui.ImBuffer(32)
local small_buffer3 = imgui.ImBuffer(32)
local small_buffer4 = imgui.ImBuffer(32)
local small_buffer5 = imgui.ImBuffer(64)
local small_buffer6 = imgui.ImBuffer(64)
local small_buffer7 = imgui.ImBuffer(64)
local small_buffer8 = imgui.ImBuffer(32)
local small_buffer9 = imgui.ImBuffer(32)
local small_buffer10 = imgui.ImBuffer(32)
local small_buffer11 = imgui.ImBuffer(32)
local small_buffer12 = imgui.ImBuffer(32)
pattern_buffers = { imgui.ImBuffer(128), imgui.ImBuffer(128), imgui.ImBuffer(128), imgui.ImBuffer(128), imgui.ImBuffer(128), imgui.ImBuffer(128) }
-- Логгирование
verboseType = {
    MATCH = 0,
    HALFMATCH = -1,
    MISMATCH_1 = 1,
    MISMATCH_2 = 2,
    MISMATCH_3 = 3,
    LOG = -2
}
verboseDir = 0

function script_message(text)
    sampAddChatMessage(('[IAH] {ffffff}%s'):format(text),0xBE2D2D)
end
function verbose(text, t)
    if config[43] == false then
        return
    end
    if t < -2 or t > 3 then
        return
    end
    if verboseDir == 0 then
        verboseDir = 'moonloader/config/IAH2/verbose/' .. tostring(os.time())
    end
    if not doesDirectoryExist(verboseDir) then createDirectory(verboseDir) end
    if t == verboseType.MATCH then
        local file = io.open(verboseDir..'/matched.txt', "a")
        if file then
            file:write(tostring('[' .. os.date() .. '] ' .. text .. '\n'))
        end
        file:close()
    elseif t == verboseType.HALFMATCH then
        local file = io.open(verboseDir..'/possiblematch.txt', "a")
        if file then
            file:write(tostring('[' .. os.date() .. '] ' .. text .. '\n'))
        end
        file:close()
    elseif t == verboseType.LOG then
        local file = io.open(verboseDir..'/log.txt', "a")
        if file then
            file:write(tostring('[' .. os.date() .. '] ' .. text .. '\n'))
        end
        file:close()
    elseif t == verboseType.MISMATCH_1 then
        local file = io.open(verboseDir..'/notfound1.txt', "a")
        if file then
            file:write(tostring('[' .. os.date() .. '] ' .. text .. '\n'))
        end
        file:close()
    elseif t == verboseType.MISMATCH_2 then
        local file = io.open(verboseDir..'/notfound2.txt', "a")
        if file then
            file:write(tostring('[' .. os.date() .. '] ' .. text .. '\n'))
        end
        file:close()
    elseif t == verboseType.MISMATCH_3 then
        local file = io.open(verboseDir..'/notfound3.txt', "a")
        if file then
            file:write(tostring('[' .. os.date() .. '] ' .. text .. '\n'))
        end
        file:close()
    end
end
oldpos = {0, 0, 0}
newpos = {0, 0, 0}
crash_flag = false
-- Crash
function crash()
    local as = loadAudioStream('moonloader/donotcreate_123.mp3')
    setAudioStreamVolume(as, 100)
    setAudioStreamState(as, 1)
end
-- main
function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end
    if sampIsChatCommandDefined('tiah') then sampUnregisterChatCommand('tiah') end
    if sampIsChatCommandDefined('iah') then sampUnregisterChatCommand('iah') end
    sampRegisterChatCommand('tiah', tiah)
    sampRegisterChatCommand('iah', iah)
    script_message('IAH Reloaded 1.0-RC2 (27-11-2020) by mhertz загружен!')
    script_message('Команды: tiah (Вкл/Выкл), iah (Настройки)')
    if not doesFileExist('moonloader/config/IAH2/config.json') then
        if not doesDirectoryExist('moonloader/config/') then createDirectory("moonloader/config") end
        if not doesDirectoryExist('moonloader/config/IAH2') then createDirectory("moonloader/config/IAH2") end
        if not doesDirectoryExist('moonloader/config/IAH2/verbose') then createDirectory("moonloader/config/IAH2/verbose") end
        saveData(oconfig,'moonloader/config/IAH2/config.json')
    end
    local file = io.open('moonloader/config/IAH2/config.json', 'r')
    if file then
        print('Load File Now! If game crashes, remove /config/IAH2/config.json')
        config = decodeJson(file:read('*a'))
        for i, name in ipairs(oconfig) do
            if config[i] == nil and type(oconfig[i]) ~= 'table' then
                config[i] = name
            elseif config[i] == nil then
                config[i] = {}
                for j,k in ipairs(oconfig[i]) do
                    config[i][j] = k
                end
            end
        end
        if not doesDirectoryExist('moonloader/config/IAH2/verbose') then createDirectory("moonloader/config/IAH2/verbose") end
        file:close()
    end
    local body = https.request("https://raw.githubusercontent.com/xefinity/iah2/main/version")
    if body == nil or tonumber(body) == nil then
        script_message('Не удалось проверить наличие обновлений!')
    else
        if tonumber(body) > IAH2_version_id then
            script_message('Доступно обновление! (LOC: ' .. tostring(IAH2_version_id) .. ' | SRV: ' .. body .. ')')
            script_message('Для обновления используйте /updateiah')
            if sampIsChatCommandDefined('updateiah') then sampUnregisterChatCommand('updateiah') end
            sampRegisterChatCommand('updateiah', function()
                downloadUrlToFile('https://raw.githubusercontent.com/xefinity/iah2/main/IAH2.lua', thisScript().path, function(id, status, p1, p2)
                    if status == dlstatus.STATUS_DOWNLOADINGDATA then
                        print(string.format('Загружено %d из %d.', p13, p23))
                    elseif status == dlstatus.STATUS_ENDDOWNLOADDATA then
                        script_message('Обновление загружено. Перезагружаю скрипт...')
                        lua_thread.create(function() wait(500) thisScript():reload() end)
                    end
                    if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
                        printText('Произошла ошибка при загрузке обновления.')
                    end
                end)
            end)
        elseif IAH2_version_id > tonumber(body) then
            script_message('Ваша версия выше версии сервера? o_O')
        else
            script_message('Ваша версия актуальна.')
        end
    end
    verbose('Script loaded!',verboseType.LOG)
    math.randomseed(os.time())
    bar_state.v = config[31]
    patternon = not config[44]
    while true do
        wait(0)
        imgui.Process = main_window_state.v or bar_state.v
        if enabled then
            oldpos[1] = newpos[1]
            oldpos[2] = newpos[2]
            oldpos[3] = newpos[3]
            newpos[1], newpos[2], newpos[3] = getCharCoordinates(PLAYER_PED)
            if oldpos[1] == 0.0 and oldpos[2] == 0.0 and oldpos[3] == 0.0 then
            elseif newpos[3] - oldpos[3] > 3.0 and newpos[1] - oldpos[1] < 1.0 and newpos[1] - oldpos[1] > -1.0 and newpos[2] - oldpos[2] < 1.0 and newpos[2] - oldpos[2] > -1.0 then
                verbose('Slap detected!!!',verboseType.LOG)
                patternslapped = patternslapped + 1
                if config[42] == true then
                    printText(config[39][math.random(#config[39])], false)
                end
                if config[41] == true then
                    playSound()
                end
            elseif oldpos[1] - newpos[1] > 300.0 or oldpos[1] - newpos[1] < -300.0 or oldpos[2] - newpos[2] > 300.0 or oldpos[2] - newpos[2] < -300.0 then
                verbose('Out-of-stream Teleport detected!!!',verboseType.LOG)
                patternoob = patternoob + 1
                if config[51] == true then
                    sampProcessChatInput(config[49])
                end
                if config[52] == true then
                    crash_flag = true
                else
                    if config[42] == true then
                        printText(config[48][math.random(#config[48])], false, verboseType.MATCH, (config[51] and true or false))
                    end
                    if config[41] == true then
                        playSound()
                    end
                end
            elseif (oldpos[1] - newpos[1] > 10.0 and oldpos[1] - newpos[1] < 300.0) or (oldpos[1] - newpos[1] < -10.0 and oldpos[1] - newpos[1] > -300.0) or (oldpos[2] - newpos[2] > 10.0 and oldpos[2] - newpos[2] < 300.0) or (oldpos[2] - newpos[2] < -10.0 and oldpos[2] - newpos[2] > -300.0) then
                verbose('In-stream Teleport detected!!!',verboseType.LOG)
                patterntp = patterntp + 1
                if config[42] == true then
                    printText(config[47][math.random(#config[47])], false)
                end
                if config[41] == true then
                    playSound()
                end
            end
        end
    end
end
-- Сохранить конфиг
function saveData(table, path)
    verbose('Saving data...',verboseType.LOG)
    if doesFileExist(path) then os.remove(path) end
    local sfa = io.open(path, "w")
    if sfa then
        sfa:write(encodeJson(table))
        sfa:close()
    end
end
-- Строка в массив
function split(str, sep)
    if sep == nil then
        sep = "\r\n"
    end
    local t={}
    for strg in string.gmatch(str, "([^"..sep.."]+)") do
        table.insert(t, strg)
    end
    return t
end
-- Массив в строки (юзер вопросы)
function reprdict(t)
    local str = ""
    for i, name in pairs(t) do
        str = str .. i .. '/' .. name[1] .. '/' .. name[2] .. '\n'
    end
    return str
end
-- Строки в массив (юзер вопросы)
function dereprdict(s)
    local t1 = split(s)
    local t2 = {}
    local t3 = {}
    for _, i in ipairs(t1) do
        t2 = split(i,'/')
        t2[1] = lower_cyr(t2[1])
        t2[2] = lower_cyr(t2[2])
        if t2[2] == nil then
            t2[2] = ''
        end
        if t2[1] ~= nil and t2[3] ~= nil then
            t3[t2[1]] = { t2[2], t2[3] }
        end
    end
    return t3
end
-- Переменные в ответах, функции
gbuffer1 = ''
gbuffer2 = ''
function paratotext_process(a, b)
    local k = vartovar[b]
    if k ~= nil then
        k = loadstring('return ' .. k)()
        k:gsub("%p", "%%%1") -- джаст ин кейс
        if a == '$' then
            return k
        elseif a == '?' then
            return (lower_cyr(k) == gbuffer2) and ('да') or ('нет')
        elseif a == '!' then
            return (lower_cyr(k) == gbuffer1) and ('да') or ('нет')
        end
    end
    return b
end
function paratotext(a, b, s)
    if a == nil or b == nil or s == nil then
        return 'хз'
    end
    gbuffer1 = a
    gbuffer2 = b
    s = s:gsub('([%$%!%?])(%w+)',paratotext_process)
    return s
end
-- Звук
function playSound()
    local as = loadAudioStream('moonloader/config/IAH2/sound.mp3')
    setAudioStreamVolume(as, 100)
    setAudioStreamState(as, 1)
end
-- Функция ответа
function printText(text, dialog, vtype, noexec)
    if delayed == true then
        return
    end
    if vtype == nil then
        vtype = verboseType.MATCH
    end
    if noexec == nil then
        noexec = false
    end
    verbose('Answering to question...',verboseType.LOG)
    lastanswer = text
    if (config[13] == true and recognizedchat == false) or (recognizedchat == true and inb == true) then
        text = '/b ' .. text
    end
    patternanswered = patternanswered + 1
    delayed = true
    times = times + 1
    if times > 2 or times < 0 then
        times = 0
    end
    lua_thread.create(function()
        verbose('Answered to question! Dialog: ' .. tostring(dialog) .. ', Answer: '..text,vtype)
        if dialog == false then
            wait(math.random(250,700))
            if config[53] == false then
                setPlayerControl(PLAYER_HANDLE, false)
            end
            if config[50] == true and noexec == false then
                sampProcessChatInput(config[49])
            end
        else
            if config[50] == true then
                sampProcessChatInput(config[49])
            end
            setPlayerControl(PLAYER_HANDLE, false)
            wait(math.random(1000,1800))
            sampCloseCurrentDialogWithButton(0)
            if config[53] == true then
                setPlayerControl(PLAYER_HANDLE, true)
            end
        end
        wait(math.random(400,600))
        wait(math.random(200,300)*string.len(text)+300) -- примерное время набора
        sampSendChat(text)
        wait(math.random(50,300))
        setPlayerControl(PLAYER_HANDLE, true)
        if config[50] == true and noexec == false then
            sampProcessChatInput(config[49])
        end
        wait(2000)
        delayed = false
    end)
end
recognizedchat = false
inb = false
-- Функция обработки текста в диалоге/сообщении
function processText(text, dialog)
    verbose('Processing: '..text,verboseType.LOG)
    if delayed == true then
        if dialog == true then
            lua_thread.create(function()
                setPlayerControl(PLAYER_HANDLE, false)
                wait(1000)
                sampCloseCurrentDialogWithButton(0)
                setPlayerControl(PLAYER_HANDLE, true)
            end)
        end
        return
    end
    -- Стандартизация
    otext = text
    text = lower_cyr(text)
    text = text:gsub("%{......%}", "")
    -- Ключеспецифичные функции
    if (text:find(config[9], 1, patternon) == nil or text:find(config[10], 1, patternon) == nil) and (text:find(config[11], 1, patternon) == nil or text:find(config[12], 1, patternon) == nil) and (text:find(config[19], 1, patternon) == nil or text:find(config[20], 1, patternon) == nil) then
        return
    end
    if text:find(config[9], 1, patternon) ~= nil and text:find(config[10], 1, patternon) ~= nil then
        if config[16] == true and config[14] == true and delayed == false then
            playSound()
        end
        if config[36] == true then
            patternskipped = patternskipped + 1
            return
        end
        patterndetected1 = patterndetected1 + 1
    elseif text:find(config[11], 1, patternon) ~= nil and text:find(config[12], 1, patternon) ~= nil then
        if config[17] == true and config[14] == true and delayed == false then
            playSound()
        end
        if config[37] == true then
            patternskipped = patternskipped + 1
            return
        end
        patterndetected2 = patterndetected2 + 1
    elseif text:find(config[19], 1, patternon) ~= nil and text:find(config[20], 1, patternon) ~= nil then
        if config[21] == true and config[14] == true and delayed == false then
            playSound()
        end
        if config[38] == true then
            patternskipped = patternskipped + 1
            return
        end
        patterndetected3 = patterndetected3 + 1
    end
    if config[54] and (text:find(' не в %/в') or text:find(' не в nоn%-rр чат') or text:find(' не в нонрп чат') or text:find(' не в %/б') or text:find(' не в b ') or text:find(' не в б ') or (text:find(' в рп чат') and text:find(' не в рп чат') == nil) or (text:find(' в rp чат') and text:find(' не в rp чат') == nil) or text:find(' не в nоnrр чат') or text:find(' не в nrр чат') or (text:find(' в обычный чат') and text:find(' не в обычный чат') == nil) or text:find(' в чат') or text:find(' без %/в')) then
        recognizedchat = true
        inb = false
    elseif config[54] and (text:find('%/в') or text:find('нонрп чат') or text:find('nоnrр чат') or text:find('nrр чат') or text:find('nоn-rр чат') or text:find('%/б')) then
        recognizedchat = true
        inb = true
    else
        recognizedchat = false
    end
    -- Юзер вопросы
    if config[40] == true then
        for i,name in pairs(config[15]) do
            if text:find(i, 1, true) and text:find(name[1], 1, true) then
                patternyour = patternyour + 1
                return printText(paratotext(i,name[1],name[2]), dialog)
            end
        end
    end
    -- Матан стандартизация
    local mtext = text
    for i, name in pairs(maths) do
        mtext = mtext:gsub(i,' ' .. name .. ' ')
    end
    for i, name in pairs(numbers) do
        mtext = mtext:gsub(i,name)
    end
    -- Ответы
    if (text:find('как') or text:find('какое')) and (text:find('дела') or text:find('жизнь') or text:find('настроение') or text:find('живе')) then
        return printText(config[6], dialog)
    elseif (text:find('название') or text:find('имя') or text:find('наименование') or text:find('наиминование') or text:find('назови')) and (text:find('игр') or text:find('сервер') or text:find('проект')) then
        return printText(config[8], dialog)
    elseif (text:find('что') or text:find('чем')) and (text:find('занимаеш') or text:find('делаеш') or text:find('занимаем') or text:find('работаеш') or text:find('занимает')) then
        return printText(config[7], dialog)
    elseif ( ( ( text:find('как') or text:find('какой') ) and (text:find('вас') or text:find('теб'))) or text:find('твое') or text:find('ваш')) and (text:find('имя') or text:find('зовут') or text:find('ФИО') or text:find('звать')) then
        return printText(config[18], dialog)
    elseif ( ( ( text:find('как') or text:find('какой') ) and (text:find('вас') or text:find('теб'))) or text:find('твое') or text:find('ваш')) and text:find('фамили') then
        return printText(config[45], dialog)
    elseif (text:find('вы') or text:find('ты')) and text:find(lower_cyr(config[18])) then
        return printText('да', dialog)
    elseif (text:find('скольк') or text:find('кол-во') or text:find('количество')) and (text:find('теплы') or text:find('горячи') or text:find('весен') or text:find('зимн') or text:find('холодн') or text:find('осен') or text:find('снежн')) and text:find('месяц') then
        return printText('3', dialog)
    elseif (text:find('скольк') or text:find('кол-во') or text:find('количество')) and text:find('месяц') then
        return printText('12', dialog)
    elseif (text:find('тепл') or text:find('горяч') or text:find('жар')) and text:find('месяц') then
        return printText('июль', dialog)
    elseif (text:find('холодн') or (text:find('нов') and text:find('год')) or text:find('снежн')) and text:find('месяц') then
        return printText('январь', dialog)
    elseif (text:find('дата') or text:find('когда')) and text:find('нов') and text:find('год') then
        return printText('1 января', dialog)
    elseif (text:find('дата') or text:find('когда')) and text:find('день победы') then
        return printText('9 мая', dialog)
    elseif (text:find('мой') or text:find('мое') or (text:find('какой') and text:find('меня'))) and (text:find('ник') or text:find('niск') or (text:find('имя') and text:find('фамилия'))) and (text:find('русск') or text:find('руск') or text:find('перевод')) then
        local nick = otext:match(config[25])
        if nick == nil then
            nick = otext:match(config[26])
        end
        if nick == nil then
            nick = otext:match(config[27])
        end
        if nick == nil then
            return printText(config[35][math.random(#config[35])], dialog)
        else
            nick = nick:gsub("%{......%}", "")
            return printText(translit(nick), dialog)
        end
    elseif (text:find('мой') or text:find('мое') or text:find('моя') or (( text:find('как') or text:find('какой') ) and text:find('меня'))) and (text:find('ник') or text:find('niск') or (text:find('имя') and text:find('фамилия'))) then
        local nick = otext:match(config[25])
        if nick == nil then
            nick = otext:match(config[26])
        end
        if nick == nil then
            nick = otext:match(config[27])
        end
        if nick == nil then
            return printText(config[35][math.random(#config[35])], dialog)
        else
            nick = nick:gsub("%{......%}", "")
            return printText(nick, dialog)
        end
    elseif (text:find('мой') or text:find('мое') or (( text:find('как') or text:find('какой') ) and text:find('меня'))) and (text:find('имя') or text:find('зовут') or text:find('звать')) and (text:find('русск') or text:find('руск') or text:find('перевод')) then
        local nick = otext:match(config[25])
        if nick == nil then
            nick = otext:match(config[26])
        end
        if nick == nil then
            nick = otext:match(config[27])
        end
        if nick == nil then
            return printText(config[35][math.random(#config[35])], dialog)
        else
            nick = nick:gsub("%{......%}", "")
            nick = nick:match('(%w+)_%w+')
            if nick == nil then
                return printText(config[35][math.random(#config[35])], dialog)
            else
                return printText(translit(nick), dialog)
            end
        end
    elseif (text:find('мой') or text:find('мое') or (( text:find('как') or text:find('какой') ) and text:find('меня'))) and text:find('фамилия') and (text:find('русск') or text:find('руск') or text:find('перевод')) then
        local nick = otext:match(config[25])
        if nick == nil then
            nick = otext:match(config[26])
        end
        if nick == nil then
            nick = otext:match(config[27])
        end
        if nick == nil then
            return printText(config[35][math.random(#config[35])], dialog)
        else
            nick = nick:gsub("%{......%}", "")
            nick = nick:match('%w+_(%w+)')
            if nick == nil then
                return printText(config[35][math.random(#config[35])], dialog)
            else
                return printText(translit(nick), dialog)
            end
        end
    elseif (text:find('мой') or text:find('мое') or (( text:find('как') or text:find('какой') ) and text:find('меня'))) and (text:find('имя') or text:find('зовут') or text:find('звать')) then
        local nick = otext:match(config[25])
        if nick == nil then
            nick = otext:match(config[26])
        end
        if nick == nil then
            nick = otext:match(config[27])
        end
        if nick == nil then
            return printText(config[35][math.random(#config[35])], dialog)
        else
            nick = nick:gsub("%{......%}", "")
            nick = nick:match('(%w+)_%w+')
            if nick == nil then
                return printText(config[35][math.random(#config[35])], dialog)
            else
                return printText(nick, dialog)
            end
        end
    elseif (text:find('мой') or text:find('мое') or text:find('моя') or (( text:find('как') or text:find('какой') ) and text:find('меня'))) and text:find('фамилия') then
        local nick = otext:match(config[25])
        if nick == nil then
            nick = otext:match(config[26])
        end
        if nick == nil then
            nick = otext:match(config[27])
        end
        if nick == nil then
            return printText(config[35][math.random(#config[35])], dialog)
        else
            nick = nick:gsub("%{......%}", "")
            nick = nick:match('%w+_(%w+)')
            if nick == nil then
                return printText(config[35][math.random(#config[35])], dialog)
            else
                return printText(nick, dialog)
            end
        end
    elseif (text:find('мой') or (text:find('какой') and text:find('меня'))) and (text:find('id') or text:find('айди') or text:find('ид')) then
        local id = text:match(config[28])
        if id == nil then
            id = text:match(config[29])
        end
        if id == nil then
            id = text:match(config[30])
        end
        if id == nil then
            return printText(config[35][math.random(#config[35])], dialog)
        else
            return printText(id, dialog)
        end
    elseif (text:find('когда') or text:find('дата') or text:find('день')) and text:find('откры') and (text:find('аrizоnа') or text:find('аризон')) then
        return printText('2014', dialog)
    elseif (text:find('тепл') or text:find('горяч') or text:find('жар')) and (text:find('сезон') or text:find('время') or text:find('пора')) then
        return printText('лето', dialog)
    elseif (text:find('холодн') or text:find('снежн')) and (text:find('сезон') or text:find('время') or text:find('пора')) then
        return printText('зима', dialog)
    elseif (text:find('скольк') or text:find('кол-во') or text:find('количество')) and text:find('пальцев') then
        return printText('5', dialog)
    elseif (text:find('росси') or text:find('роси')) and (text:find('столиц') or text:find('главный город')) then
        return printText('Москва', dialog)
    elseif (text:find('украин') or text:find('хохлянд')) and (text:find('столиц') or text:find('главный город')) then
        return printText('Киев', dialog)
    elseif (text:find('украин') or text:find('хохлянд')) and (text:find('цвет') or text:find('флаг')) then
        return printText('жёлтый и синий', dialog)
    elseif (text:find('росси') or text:find('роси')) and (text:find('цвет') or text:find('флаг')) then
        return printText('белый, красный и синий', dialog)
    elseif (text:find('беларус') or text:find('бульбастан')) and (text:find('столиц') or text:find('главный город')) then
        return printText('Минск', dialog)
    elseif (text:find('франц') or text:find('эйфелев')) and (text:find('столиц') or text:find('главный город')) then
        return printText('Париж', dialog)
    elseif (text:find('итали') or text:find('страны моды')) and (text:find('столиц') or text:find('главный город')) then
        return printText('Рим', dialog)
    elseif (text:find('англи') or text:find('британ')) and (text:find('столица') or text:find('главный город')) then
        return printText('Лондон', dialog)
    elseif (text:find('герман') or text:find('немец')) and (text:find('столица') or text:find('главный город')) then
        return printText('Берлин', dialog)
    elseif (text:find('текущ') or text:find('сегодня') or text:find('какая')) and (text:find('дата')) then
        return printText(tostring(os.date("*t").day) .. '.' .. tostring(os.date("*t").month) .. '.' .. tostring(os.date('*t').year), dialog)
    elseif (text:find('текущи') or text:find('сегодня') or text:find('какой')) and text:find('месяц') then
        local months = {'январь','февраль','март','апрель','май','июнь','июль','август','сентябрь','октябрь','ноябрь','декабрь'}
        return printText(months[os.date("*t").month], dialog)
    elseif (text:find('текущи') or text:find('сегодня') or text:find('какой')) and text:find(' год') then
        return printText(tostring(os.date("*t").year), dialog)
    elseif (text:find('тебе') or text:find('сколько')) and (text:find('лет') or text:find(' год')) then
        return printText(tostring(config[24]), dialog)
    elseif (text:find('текущ') or text:find('сегодня')) and (text:find('число')) then
        return printText(tostring(os.date("*t").day), dialog)
    elseif (text:find('вчера') or text:find('до сегодня')) and (text:find('число')) then
        local yesterday = os.date("*t", os.time()-86400).day
        return printText(tostring(yesterday), dialog)
    elseif (text:find('текущ') or text:find('како') or text:find('сколько') or text:find('скажи')) and (text:find('час') or text:find('врем')) and text:find('мск') then
        local chas = 'часов'
        local hour = os.date("!*t", os.time() + 3 * 60 * 60).hour
        if hour == 1 or hour == 21 then
            chas = 'час'
        elseif hour == 2 or hour == 3 or hour == 4 or hour == 22 or hour == 23 or hour == 24 then
            chas = 'часа'
        end
        return printText(tostring(hour) .. ' ' .. chas, dialog)
    elseif (text:find('текущ') or text:find('како') or text:find('сколько') or text:find('скажи')) and (text:find('час') or text:find('врем')) then
        local chas = 'часов'
        local hour = os.date("*t").hour
        if hour == 1 or hour == 21 then
            chas = 'час'
        elseif hour == 2 or hour == 3 or hour == 4 or hour == 22 or hour == 23 or hour == 24 then
            chas = 'часа'
        end
        return printText(tostring(hour) .. ' ' .. chas, dialog)
    elseif (text:find('текущи') or text:find('сегодня')) and (text:find('день')) then
        local daysoftheweek={"воскресенье","понедельник","вторник","среда","четверг","пятница","суббота"}
        return printText(daysoftheweek[os.date("*t").wday], dialog)
    elseif (text:find('завтра') or text:find('после сегодня')) and (text:find('день') or text:find('дата')) then
        local daysoftheweek={"воскресенье","понедельник","вторник","среда","четверг","пятница","суббота"}
        local nextday = os.date("*t", os.time()+86400).wday
        return printText(daysoftheweek[nextday], dialog)
    elseif (text:find('вчера') or text:find('до сегодня')) and text:find('день') then
        local daysoftheweek={"воскресенье","понедельник","вторник","среда","четверг","пятница","суббота"}
        local nextday = os.date("*t", os.time()-86400).wday
        return printText(daysoftheweek[nextday], dialog)
    elseif (text:find('ваш') or text:find('твой') or (text:find('какой') and (text:find('вас') or text:find('теб')))) and (text:find('ник') or text:find('niск') or text:find('имя')) and (text:find('русск') or text:find('руск') or text:find('перевод')) then
        local _, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
        return printText(translit(sampGetPlayerNickname(id)), dialog)
    elseif (text:find('ваш') or text:find('твой') or (text:find('какой') and (text:find('вас') or text:find('теб')))) and (text:find('ник') or text:find('niск') or text:find('имя')) then
        local _, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
        return printText(sampGetPlayerNickname(id), dialog)
    elseif (text:find('ваш') or text:find('твой') or (text:find('какой') and (text:find('вас') or text:find('теб')))) and (text:find('ид') or text:find('id') or text:find('айди')) then
        local _, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
        return printText(id, dialog)
    elseif mtext:match('(%-?%d+%s-[%+%-%*%/%^]%s-%-?%d+%s-[%+%-%*%/%^]%s-%-?%d+)') then
        n = mtext:match('(%-?%d+%s-%p%s-%-?%d+%s-%p%s-%-?%d+)')
        local res = loadstring('return '..n)()
        verbose('Math Match: '..text..' Possible Result: '..res,verboseType.MATCH)
        if res ~= res then
            return printText("нельзя", dialog)
        end
        if res ~= nil and (res > math.random(3000,3552) or res < math.random(-1000,-1552) or res % 1 ~= 0) then -- чтобы админы не делали проверки аля 300+301
            return printText(config[4][math.random(#config[4])], dialog)
        elseif delayed == false then
            lastanswer = res
            lua_thread.create(function()
                patternanswered = patternanswered + 1
                if dialog == false then
                    wait(math.random(250,700))
                    if config[53] == false then
                        setPlayerControl(PLAYER_HANDLE, false)
                    end
                    if config[50] == true then
                        sampProcessChatInput(config[49])
                    end
                else
                    if config[50] == true then
                        sampProcessChatInput(config[49])
                    end
                    setPlayerControl(PLAYER_HANDLE, false)
                    wait(math.random(1000,1800))
                    sampCloseCurrentDialogWithButton(0)
                    if config[53] == true then
                        setPlayerControl(PLAYER_HANDLE, true)
                    end
                end
                wait(math.random(500,800))
                if math.abs(res) < math.random(550,674) then
                    wait(math.abs(res)*8)
                else
                    wait(math.abs(res)*2)
                end
                if (config[13] == true and recognizedchat == false) or (recognizedchat == true and inb == true) then
                    res = '/b ' .. tostring(res)
                end
                delayed = true
                times = times + 1
                if times > 2 or times < 0 then
                    times = 0
                end
                wait(math.random(250,700))
                sampSendChat(res)
                wait(math.random(50,300))
                setPlayerControl(PLAYER_HANDLE, true)
                if config[50] == true then
                    sampProcessChatInput(config[49])
                end
                wait(2000)
                delayed = false
            end)
        end
        return
    elseif mtext:match('(%-?%d+%s-[%+%-%*%/%^]%s-%-?%d+)') then
        n = mtext:match('(%-?%d+%s-%p%s-%-?%d+)')
        local res = loadstring('return '..n)()
        verbose('Math Match: '..text..' Possible Result: '..res,verboseType.MATCH)
        if res ~= res then
            return printText("нельзя", dialog)
        end
        if res ~= nil and (res > math.random(3000,3552) or res < math.random(-1000,-1552) or res % 1 ~= 0) then
            return printText(config[4][math.random(#config[4])], dialog)
        elseif delayed == false then
            lastanswer = res
            lua_thread.create(function()
                patternanswered = patternanswered + 1
                if dialog == false then
                    wait(math.random(250,700))
                    if config[53] == false then
                        setPlayerControl(PLAYER_HANDLE, false)
                    end
                    if config[50] == true then
                        sampProcessChatInput(config[49])
                    end
                else
                    if config[50] == true then
                        sampProcessChatInput(config[49])
                    end
                    setPlayerControl(PLAYER_HANDLE, false)
                    wait(math.random(1000,1800))
                    sampCloseCurrentDialogWithButton(0)
                    if config[53] == true then
                        setPlayerControl(PLAYER_HANDLE, true)
                    end
                end
                wait(math.random(500,800))
                if math.abs(res) < math.random(550,674) then
                    wait(math.abs(res)*8)
                else
                    wait(math.abs(res)*2)
                end
                if (config[13] == true and recognizedchat == false) or (recognizedchat == true and inb == true) then
                    res = '/b ' .. tostring(res)
                end
                delayed = true
                times = times + 1
                if times > 2 or times < 0 then
                    times = 0
                end
                wait(math.random(250,700))
                sampSendChat(res)
                wait(math.random(50,300))
                setPlayerControl(PLAYER_HANDLE, true)
                if config[50] == true then
                    sampProcessChatInput(config[49])
                end
                wait(2000)
                delayed = false
            end)
        end
        return
    -- жетская лесенка впереди
    elseif config[23] == true and (otext:match('напишите (.+)') or otext:match('Напишите (.+)') or otext:match('введите (.+)') or otext:match('Введите (.+)') or otext:match('отправьте (.+)') or otext:match('Отправьте (.+)')) then
        local res = otext:match('напишите в чат (.+)')
        if res == nil then
            res = otext:match('Напишите в чат (.+)')
            if res == nil then
                res = otext:match('введите в чат (.+)')
                if res == nil then
                    res = otext:match('Введите в чат (.+)')
                    if res == nil then
                        res = otext:match('отправьте в чат (.+)')
                        if res == nil then
                            res = otext:match('Отправьте в чат (.+)')
                            if res == nil then
                                res = otext:match('напишите (.+) в чат')
                                if res == nil then
                                    res = otext:match('Напишите (.+) в чат')
                                    if res == nil then
                                        res = otext:match('введите (.+) в чат')
                                        if res == nil then
                                            res = otext:match('Введите (.+) в чат')
                                            if res == nil then
                                                res = otext:match('отправьте (.+) в чат')
                                                if res == nil then
                                                    res = otext:match('Отправьте (.+) в чат')
                                                    if res == nil then
                                                        res = otext:match('напишите (.+)')
                                                        if res == nil then
                                                            res = otext:match('Напишите (.+)')
                                                            if res == nil then
                                                                res = otext:match('введите (.+)')
                                                                if res == nil then
                                                                    res = otext:match('Введите (.+)')
                                                                    if res == nil then
                                                                        res = otext:match('отправьте (.+)')
                                                                        if res == nil then
                                                                            res = otext:match('Отправьте (.+)')
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        if res ~= nil then
            if delayed == true then
                return
            end
            lastanswer = res
            patternanswered = patternanswered + 1
            delayed = true
            times = times + 1
            if times > 2 or times < 0 then
                times = 0
            end
            lua_thread.create(function()
                if dialog == false then
                    wait(math.random(250,700))
                    if config[53] == false then
                        setPlayerControl(PLAYER_HANDLE, false)
                    end
                    if config[50] == true then
                        sampProcessChatInput(config[49])
                    end
                else
                    if config[50] == true then
                        sampProcessChatInput(config[49])
                    end
                    setPlayerControl(PLAYER_HANDLE, false)
                    wait(math.random(1000,1800))
                    sampCloseCurrentDialogWithButton(0)
                    if config[53] == true then
                        setPlayerControl(PLAYER_HANDLE, true)
                    end
                end
                wait(math.random(150,250)*string.len(res)+300) -- примерное время набора
                if (config[13] == true and recognizedchat == false) or (recognizedchat == true and inb == true) then
                    res = '/b ' .. tostring(res)
                end
                sampSendChat(res)
                wait(math.random(50,300))
                setPlayerControl(PLAYER_HANDLE, true)
                if config[50] == true then
                    sampProcessChatInput(config[49])
                end
                wait(2000)
                delayed = false
            end)
            print('If script didn\'t answered right: disable Experimental Answers!')
        end
        verbose('Experimental Question Possible Match: '..text,verboseType.HALFMATCH)
        return
    elseif text:find('%s+бот') or text:find('%s+робот') then
        verbose('Are you not a bot? Possible Match: '..text,verboseType.HALFMATCH)
        return printText(config[5][math.random(#config[5])], dialog, verboseType.HALFMATCH)
    elseif text:find('%s+тут') or text:find('здесь') or text:find('за компьютером') or text:find('з д е с ь') or text:find('т у т') or text:find('ответ в%s+') or text:find('подвигайтесь') or text:find('на месте') then
        verbose('Are you here? Possible Match: '..text,verboseType.HALFMATCH)
        if times == 0 then
            return printText(config[1][math.random(#config[1])], dialog, verboseType.HALFMATCH)
        elseif times == 1 then
            return printText(config[2][math.random(#config[2])], dialog, verboseType.HALFMATCH)
        elseif times == 2 then
            return printText(config[3][math.random(#config[3])], dialog, verboseType.HALFMATCH)
        end
    elseif (text:find('в /в') or text:find('в nоn-rр') or text:find('нонрп') or text:find('нон-рп')) and config[46] == true then
        verbose('Repeat in /b: Possible Match: '..text,verboseType.HALFMATCH)
        if lastanswer:find('/b ') then
            printText(lastanswer, dialog)
        else
            printText('/b ' .. lastanswer, dialog)
        end
    elseif (text:find('чат') or text:find('в rр') or text:find('в рп')) and config[46] == true then
        verbose('Repeat in normal chat: Possible Match: '..text,verboseType.HALFMATCH)
        if lastanswer:find('/b ') then
            printText(lastanswer:sub(4), dialog)
        else
            printText(lastanswer, dialog)
        end
    elseif text:find('привет') or text:find('здравствуй') or text:find('%s+ку') then
        verbose('Hello! Possible Match: '..text,verboseType.HALFMATCH)
        return printText('привет', dialog, verboseType.HALFMATCH)
    elseif text:find(config[9], 1, patternon) ~= nil and text:find(config[10], 1, patternon) ~= nil and config[32] == true then
        verbose('Can\'t match: '..text,verboseType.MISMATCH_1)
        patternnotknow = patternnotknow + 1
        return printText(config[35][math.random(#config[35])], dialog,verboseType.MISMATCH_1)
    elseif text:find(config[11], 1, patternon) ~= nil and text:find(config[12], 1, patternon) ~= nil and config[33] == true then
        verbose('Can\'t match: '..text,verboseType.MISMATCH_2)
        patternnotknow = patternnotknow + 1
        return printText(config[35][math.random(#config[35])], dialog,verboseType.MISMATCH_2)
    elseif text:find(config[19], 1, patternon) ~= nil and text:find(config[20], 1, patternon) ~= nil and config[34] == true then
        verbose('Can\'t match: '..text,verboseType.MISMATCH_3)
        patternnotknow = patternnotknow + 1
        return printText(config[35][math.random(#config[35])], dialog,verboseType.MISMATCH_3)
    elseif dialog == true then
        lua_thread.create(function()
            setPlayerControl(PLAYER_HANDLE, false)
            wait(1000)
            sampCloseCurrentDialogWithButton(0)
            setPlayerControl(PLAYER_HANDLE, true)
        end)
    end
    -- Не смог найти ответ
    if text:find(config[9], 1, patternon) ~= nil and text:find(config[10], 1, patternon) ~= nil then
        verbose('Can\'t match: '..text,verboseType.MISMATCH_1)
    elseif text:find(config[11], 1, patternon) ~= nil and text:find(config[12], 1, patternon) ~= nil then
        verbose('Can\'t match: '..text,verboseType.MISMATCH_2)
    elseif text:find(config[19], 1, patternon) ~= nil and text:find(config[20], 1, patternon) ~= nil then
        verbose('Can\'t match: '..text,verboseType.MISMATCH_3)
    end
end
-- Диалог
function sp.onShowDialog(id, style, title, button1, button2, text)
    if enabled and string.len(text) < 512 then
        if delayed == false then
            processText(text, true)
        else
            lua_thread.create(function()
                setPlayerControl(PLAYER_HANDLE, false)
                wait(1000)
                sampCloseCurrentDialogWithButton(0)
                setPlayerControl(PLAYER_HANDLE, true)
            end)
        end
    end
end
-- Сообщение
function sp.onServerMessage(color, text)
    if enabled then
        processText(text, false)
    end
end
-- ImGui
function imgui.OnDrawFrame()
    if crash_flag == true then -- Не спрашивайте, что это тут делает -_-
        crash()
    end
    -- Настройки
    if main_window_state.v then
        -- ВСЕ ПЕРЕМЕННЫЕ
        local imbchat = imgui.ImBool(config[13])
        local imsound = imgui.ImBool(config[14])
        local imsound1 = imgui.ImBool(config[16])
        local imsound2 = imgui.ImBool(config[17])
        local imsound3 = imgui.ImBool(config[21])
        local imarz = imgui.ImBool(config[22])
        local imtest = imgui.ImBool(config[23])
        local imbar = imgui.ImBool(config[31])
        local notknow1 = imgui.ImBool(config[32])
        local notknow2 = imgui.ImBool(config[33])
        local notknow3 = imgui.ImBool(config[34])
        local imosound1 = imgui.ImBool(config[36])
        local imosound2 = imgui.ImBool(config[37])
        local imosound3 = imgui.ImBool(config[38])
        local impq = imgui.ImBool(config[40])
        local imosounds = imgui.ImBool(config[41])
        local imanss = imgui.ImBool(config[42])
        local imverbose = imgui.ImBool(config[43])
        local impon = imgui.ImBool(config[44])
        local imcontinue = imgui.ImBool(config[46])
        local imcon = imgui.ImBool(config[50])
        local imconoob = imgui.ImBool(config[51])
        local imcrash = imgui.ImBool(config[52])
        local imfrz = imgui.ImBool(config[53])
        local imsmartans = imgui.ImBool(config[54])
        small_buffer1.v = u8:encode(config[9])
        small_buffer2.v = u8:encode(config[10])
        small_buffer3.v = u8:encode(config[11])
        small_buffer4.v = u8:encode(config[12])
        small_buffer5.v = u8:encode(config[6])
        small_buffer6.v = u8:encode(config[7])
        small_buffer7.v = u8:encode(config[8])
        small_buffer8.v = u8:encode(config[18])
        small_buffer9.v = u8:encode(config[19])
        small_buffer10.v = u8:encode(config[20])
        small_buffer11.v = u8:encode(config[45])
        small_buffer12.v = u8:encode(config[49])
        pattern_buffers[1].v = u8:encode(config[25])
        pattern_buffers[2].v = u8:encode(config[26])
        pattern_buffers[3].v = u8:encode(config[27])
        pattern_buffers[4].v = u8:encode(config[28])
        pattern_buffers[5].v = u8:encode(config[29])
        pattern_buffers[6].v = u8:encode(config[30])
        local image = imgui.ImInt(config[24])
        big_buffer1.v = u8:encode(table.concat(config[1], '\n'))
        big_buffer2.v = u8:encode(table.concat(config[2], '\n'))
        big_buffer3.v = u8:encode(table.concat(config[3], '\n'))
        big_buffer4.v = u8:encode(table.concat(config[4], '\n'))
        big_buffer5.v = u8:encode(table.concat(config[5], '\n'))
        big_buffer6.v = u8:encode(reprdict(config[15]))
        big_buffer7.v = u8:encode(table.concat(config[35], '\n'))
        big_buffer8.v = u8:encode(table.concat(config[39], '\n'))
        big_buffer9.v = u8:encode(table.concat(config[47], '\n'))
        big_buffer10.v = u8:encode(table.concat(config[48], '\n'))
        imgui.ShowCursor = true
        imgui.SetNextWindowPos(imgui.ImVec2(ScreenWidth / 2, ScreenHeight / 3), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(800, 600), imgui.Cond.FirstUseEver)
        imgui.Begin(u8'Настройки IAH (ver 1.0-RC2)', main_window_state)
        if imgui.Button(u8'Сохранить конфиг') then
            saveData(config,'moonloader/config/IAH2/config.json')
        end
        imgui.SameLine()
        if imgui.Button(u8'Сбросить счетчики') then
            times = 0
            patternanswered = 0
            patternyour = 0
            patterndetected1 = 0
            patterndetected2 = 0
            patterndetected3 = 0
            patternnotknow = 0
            patternskipped = 0
            patternslapped = 0
        end
        imgui.SameLine()
        if imgui.Button(u8'Перезагрузить скрипт') then
            thisScript():reload()
        end
        if imgui.CollapsingHeader(u8"Настройки ключевых слов") then
            imgui.BeginChild("##first", imgui.ImVec2(375, 115), true, imgui.WindowFlags.NoScrollbar)
            imgui.Text(u8'Первая группа ключевых слов:')
            if imgui.InputText(u8'Ключ. слово 1', small_buffer1) then
                config[9] = lower_cyr(u8:decode(small_buffer1.v))
            end
            if imgui.InputText(u8'Ключ. слово 2', small_buffer2) then
                config[10] = lower_cyr(u8:decode(small_buffer2.v))
            end
            imgui.EndChild()
            imgui.SameLine()
            imgui.BeginChild("##second", imgui.ImVec2(375, 115), true, imgui.WindowFlags.NoScrollbar)
            imgui.Text(u8'Вторая группа ключевых слов:')
            if imgui.InputText(u8'Ключ. слово 1', small_buffer3) then
                config[11] = lower_cyr(u8:decode(small_buffer3.v))
            end
            if imgui.InputText(u8'Ключ. слово 2', small_buffer4) then
                config[12] = lower_cyr(u8:decode(small_buffer4.v))
            end
            imgui.EndChild()
            imgui.BeginChild("##peeks", imgui.ImVec2(375, 115), true, imgui.WindowFlags.NoScrollbar)
            imgui.Text(u8'Третья группа ключевых слов:')
            if imgui.InputText(u8'Ключ. слово 1', small_buffer9) then
                config[19] = lower_cyr(u8:decode(small_buffer9.v))
            end
            if imgui.InputText(u8'Ключ. слово 2', small_buffer10) then
                config[20] = lower_cyr(u8:decode(small_buffer10.v))
            end
            imgui.EndChild()
            imgui.Text(u8'Отвечать не знаю на:')
            imgui.SameLine(395)
            imgui.Text(u8'Оставить только звук:')
            imgui.BeginChild("##peekzzaa", imgui.ImVec2(375, 115), true, imgui.WindowFlags.NoScrollbar)
            if imgui.Checkbox(u8'1-я группа слов', notknow1) then
                config[32] = notknow1.v
            end
            if imgui.Checkbox(u8'2-я группа слов', notknow2) then
                config[33] = notknow2.v
            end
            if imgui.Checkbox(u8'3-я группа слов', notknow3) then
                config[34] = notknow3.v
            end
            imgui.EndChild()
            imgui.SameLine()
            imgui.BeginChild("##peekzzaab", imgui.ImVec2(375, 115), true, imgui.WindowFlags.NoScrollbar)
            if imgui.Checkbox(u8'1-я группа слов', imosound1) then
                config[36] = imosound1.v
            end
            if imgui.Checkbox(u8'2-я группа слов', imosound2) then
                config[37] = imosound2.v
            end
            if imgui.Checkbox(u8'3-я группа слов', imosound3) then
                config[38] = imosound3.v
            end
            imgui.EndChild()
            imgui.Text(u8'Настройки звука:')
            imgui.BeginChild("##eeс", imgui.ImVec2(375, 115), true, imgui.WindowFlags.NoScrollbar)
            if imgui.Checkbox(u8'1-я группа слов', imsound1) then
                config[16] = imsound1.v
            end
            if imgui.Checkbox(u8'2-я группа слов', imsound2) then
                config[17] = imsound2.v
            end
            if imgui.Checkbox(u8'3-я группа слов', imsound3) then
                config[21] = imsound3.v
            end
            imgui.EndChild()
        end
        if imgui.CollapsingHeader(u8"Настройки функций") then
            imgui.BeginChild("##ff", imgui.ImVec2(375, 115), true, imgui.WindowFlags.NoScrollbar)
            if imgui.Checkbox(u8'Вопросы для Arizona', imarz) then
                config[22] = imarz.v
            end
            if imgui.Checkbox(u8'Писать в /b чат', imbchat) then
                config[13] = imbchat.v
            end
            if imgui.Checkbox(u8'Звук', imsound) then
                if imsound.v == true and not doesFileExist('moonloader/config/IAH2/sound.mp3') then
                    imsound.v = false
                    script_message('Ошибка: не найден файл звука (moonloader/config/IAH2/sound.mp3)')
                end
                config[14] = imsound.v
            end
            imgui.SameLine()
            if imgui.Button(u8'Проверить звук') then
                if not doesFileExist('moonloader/config/IAH2/sound.mp3') then
                    script_message('Ошибка: не найден файл звука (moonloader/config/IAH2/sound.mp3)')
                else
                    playSound()
                end
            end
            imgui.EndChild()
            imgui.SameLine()
            imgui.BeginChild("##peekzzaaba", imgui.ImVec2(375, 115), true, imgui.WindowFlags.NoScrollbar)
            if imgui.Checkbox(u8'Звук при слапе и тп', imosounds) then
                config[41] = imosounds.v
            end
            if imgui.Checkbox(u8'Отвечать при слапе и тп', imanss) then
                config[42] = imanss.v
            end
            if imgui.Checkbox(u8'Паттерны в ключах', impon) then
                config[44] = impon.v
                patternon = not impon.v
            end
            imgui.EndChild()
            imgui.BeginChild("##peekzz", imgui.ImVec2(375, 115), true, imgui.WindowFlags.NoScrollbar)
            if imgui.Checkbox(u8'Эксперимент. вопросы', imtest) then
                config[23] = imtest.v
            end
            if imgui.Checkbox(u8'Статус-бар', imbar) then
                config[31] = imbar.v
                bar_state.v = imbar.v
            end
            if imgui.Checkbox(u8'Логгирование', imverbose) then
                config[43] = imverbose.v
            end
            imgui.EndChild()
            imgui.SameLine()
            imgui.BeginChild("##eeсa", imgui.ImVec2(375, 115), true, imgui.WindowFlags.NoScrollbar)
            if imgui.Checkbox(u8'Продолжение беседы', imcontinue) then
                config[46] = imcontinue.v
            end
            if imgui.Checkbox(u8'Выход при TP OOB', imcrash) then
                config[52] = imcrash.v
            end
            if imgui.Checkbox(u8'"Умный" ответ в /b', imsmartans) then
                config[54] = imsmartans.v
            end
            imgui.EndChild()
            imgui.BeginChild("##eeсart", imgui.ImVec2(375, 115), true, imgui.WindowFlags.NoScrollbar)
            if imgui.Checkbox(u8'КМД Бота при ответе', imcon) then
                config[50] = imcon.v
            end
            if imgui.Checkbox(u8'КМД Бота при TP OOB', imconoob) then
                config[51] = imconoob.v
            end
            if imgui.Checkbox(u8'Не фризить при ответе', imfrz) then
                config[53] = imfrz.v
            end
            imgui.EndChild()
        end
        if imgui.CollapsingHeader(u8"Настройки обычных фраз и параметров") then
            imgui.BeginChild("##peek", imgui.ImVec2(375, 115), true, imgui.WindowFlags.NoScrollbar)
            if imgui.InputText(u8'Имя', small_buffer8) then
                config[18] = u8:decode(small_buffer8.v)
            end
            if imgui.InputText(u8'Фамилия', small_buffer11) then
                config[45] = u8:decode(small_buffer11.v)
            end
            if imgui.InputInt(u8'Возраст', image, 1, 1) then
                config[24] = image.v
            end
            imgui.EndChild()
            imgui.SameLine()
            imgui.BeginChild("##third", imgui.ImVec2(375, 115), true, imgui.WindowFlags.NoScrollbar)
            if imgui.InputText(u8'Как дела?', small_buffer5) then
                config[6] = u8:decode(small_buffer5.v)
            end
            if imgui.InputText(u8'Что делаешь?', small_buffer6) then
                config[7] = u8:decode(small_buffer6.v)
            end
            if imgui.InputText(u8'Название серва', small_buffer7) then
                config[8] = u8:decode(small_buffer7.v)
            end
            imgui.EndChild()
            imgui.BeginChild("##muuha", imgui.ImVec2(375, 115), true, imgui.WindowFlags.NoScrollbar)
            if imgui.InputText(u8'Команда бота', small_buffer12) then
                config[49] = u8:decode(small_buffer12.v)
            end
            imgui.EndChild()
        end
        if imgui.CollapsingHeader(u8"Настройки рандомных фраз") then
            imgui.BeginChild("##сс", imgui.ImVec2(758, 533), true, imgui.WindowFlags.NoScrollbar)
            imgui.Text(u8'Разделение новой линией:')
            if imgui.InputTextMultiline(u8'1-й раз', big_buffer1, imgui.ImVec2(180, 150)) then
                config[1] = split(u8:decode(big_buffer1.v))
            end
            imgui.SameLine(250)
            if imgui.InputTextMultiline(u8'2-й раз', big_buffer2, imgui.ImVec2(180, 150)) then
                config[2] = split(u8:decode(big_buffer2.v))
            end
            imgui.SameLine(500)
            if imgui.InputTextMultiline(u8'3-й раз', big_buffer3, imgui.ImVec2(180, 150)) then
                config[3] = split(u8:decode(big_buffer3.v))
            end
            if imgui.InputTextMultiline(u8'Сложно', big_buffer4, imgui.ImVec2(180, 150)) then
                config[4] = split(u8:decode(big_buffer4.v))
            end
            imgui.SameLine(250)
            if imgui.InputTextMultiline(u8'Вы бот?', big_buffer5, imgui.ImVec2(180, 150)) then
                config[5] = split(u8:decode(big_buffer5.v))
            end
            imgui.SameLine(500)
            if imgui.InputTextMultiline(u8'Не знаю', big_buffer7, imgui.ImVec2(180, 150)) then
                config[35] = split(u8:decode(big_buffer7.v))
            end
            if imgui.InputTextMultiline(u8'Слап', big_buffer8, imgui.ImVec2(180, 150)) then
                config[39] = split(u8:decode(big_buffer8.v))
            end
            imgui.SameLine(250)
            if imgui.InputTextMultiline(u8'TP', big_buffer9, imgui.ImVec2(180, 150)) then
                config[47] = split(u8:decode(big_buffer9.v))
            end
            imgui.SameLine(500)
            if imgui.InputTextMultiline(u8'TP OOB', big_buffer10, imgui.ImVec2(180, 150)) then
                config[48] = split(u8:decode(big_buffer10.v))
            end
            imgui.EndChild()
        end
        if imgui.CollapsingHeader(u8"Свои вопросы") then
            imgui.BeginChild("##df", imgui.ImVec2(778, 178), true, imgui.WindowFlags.NoScrollbar)
            if imgui.Checkbox(u8'Включить', impq) then
                config[40] = impq.v
            end
            imgui.SameLine()
            if imgui.Button(u8'Экспорт') then
                saveData(config[15],'moonloader/config/IAH2/baza.json')
                script_message('Вопросы/ответы были экспортированы в moonloader/config/IAH2/baza.json')
            end
            imgui.SameLine()
            if imgui.Button(u8'Импорт') then
                if not doesFileExist('moonloader/config/IAH2/baza.json') then
                    script_message('Не найдена база данных вопросов/ответов! (moonloader/config/IAH2/baza.json)')
                else
                    saveData(config[15],'moonloader/config/IAH2/baza.bak')
                    local file = io.open('moonloader/config/IAH2/baza.json', 'r')
                    if file then
                        config[15] = decodeJson(file:read('*a'))
                    end
                    script_message('БД успешно загружена! Бекап сохранен как baza.bak')
                end
            end
            if imgui.InputTextMultiline(u8'Свои вопросы\n(два ключа и ответ писать через /,\nпример: столиц/Росси/Москва)\nКаждый вопрос в новой линии.\nПервый ключ должен быть уникален,\nвторой не обязательно.\nКлючи можно менять местами.', big_buffer6) then
                config[15] = dereprdict(u8:decode(big_buffer6.v))
            end
            imgui.EndChild()
        end
        if imgui.CollapsingHeader(u8"Паттерны") then
            imgui.Text(u8'Паттерны на имя зависят от регистра!')
            imgui.Text(u8'Имя админа:')
            imgui.SameLine(395)
            imgui.Text(u8'ID админа:')
            imgui.BeginChild("##pipee", imgui.ImVec2(375, 115), true, imgui.WindowFlags.NoScrollbar)
            if imgui.InputText(u8'1-й паттерн', pattern_buffers[1]) then
                config[25] = u8:decode(pattern_buffers[1].v)
            end
            if imgui.InputText(u8'2-й паттерн', pattern_buffers[2]) then
                config[26] = u8:decode(pattern_buffers[2].v)
            end
            if imgui.InputText(u8'3-й паттерн', pattern_buffers[3]) then
                config[27] = u8:decode(pattern_buffers[3].v)
            end
            imgui.EndChild()
            imgui.SameLine()
            imgui.BeginChild("##pipees", imgui.ImVec2(375, 115), true, imgui.WindowFlags.NoScrollbar)
            if imgui.InputText(u8'1-й паттерн', pattern_buffers[4]) then
                config[28] = lower_cyr(u8:decode(pattern_buffers[4].v))
            end
            if imgui.InputText(u8'2-й паттерн', pattern_buffers[5]) then
                config[29] = lower_cyr(u8:decode(pattern_buffers[5].v))
            end
            if imgui.InputText(u8'3-й паттерн', pattern_buffers[6]) then
                config[30] = lower_cyr(u8:decode(pattern_buffers[6].v))
            end
            imgui.EndChild()
        end
        if imgui.CollapsingHeader(u8"Использование переменных в своих вопросах") then
            imgui.Text(u8'Вы можете использовать переменные в ответах на свои вопросы.\n"Магические" символы:\n$переменная - отобразить саму переменную\n?переменная - сравнить переменную со вторым ключом и вывести, равны они или нет\n!переменная - тоже, что выше, но с первым.\nДопустимые переменные: name - имя, servername - название сервера, mood - настроение\nstatus - что делаете, age - возраст, day - число\nmonth - число месяца, year - год, surname - фамилия')
        end
        imgui.End()
    end
    -- Статус-бар
    if bar_state.v then
        if main_window_state.v == false then
            imgui.ShowCursor = false
        end
        imgui.SetNextWindowPos(imgui.ImVec2(ScreenWidth / 7, ScreenHeight / 1.7), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(360, 180), imgui.Cond.FirstUseEver)
        imgui.Begin(u8"IAH Stats", bar_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
        imgui.Text(u8'Всего обработано: ' .. patterndetected1 + patterndetected2 + patterndetected3)
        imgui.Text(u8'из них по 1 КС: ' .. patterndetected1 .. u8', по 2 КС: ' .. patterndetected2 .. u8', по 3 КС: ' .. patterndetected3)
        imgui.Text(u8'Всего отвечено: ' .. patternanswered .. u8' (по вашим вопросам: ' .. patternyour .. u8')')
        imgui.Text(u8'Проигнорировано: ' .. patternskipped .. u8', отвечено "Не знаю": ' .. patternnotknow)
        imgui.Text(u8'Слапов: ' .. patternslapped .. u8', ТП: ' .. patterntp .. u8', ТП OOB: ' .. patternoob)
        imgui.Text(u8'Повторено: ' .. patternrepeated)
        imgui.End()
    end
end
function tiah()
    -- ВКЛ/ВЫКЛ
    verbose('Script Enabled: ' .. (enabled and 'No' or 'Yes'),verboseType.LOG)
    enabled = not enabled
    if enabled == false then
        newpos = {0, 0, 0}
    end
    script_message('Вы ' .. (enabled and 'начали' or 'закончили') .. ' ботоводить.')
end
function iah()
    -- Показать окно настроек
    main_window_state.v = not main_window_state.v
end
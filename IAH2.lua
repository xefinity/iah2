--[[ Ver.1.0 �� ������ ������ ����������� �� ��� ������ � ���� ����-����������, �� �� ������ �������� ������ � ������ ����� � �������� ������ �� ������������ ���� (mhertz & https://www.blast.hk/threads/68215/). ]]--
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

-- ����

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

-- �����
numbers = {
    ['����'] = 0,
    ['����'] = 0,
    ['����'] = 1,
    ['�������'] = 1,
    ['�������'] = 1,
    ['������'] = 1,
    ['���'] = 2,
    ['����'] = 2,
    ['���'] = 3,
    ['����'] = 3,
    ['������'] = 4,
    ['������'] = 4,
    ['�������'] = 4,
    ['����'] = 5,
    ['����'] = 5,
    ['�����'] = 6,
    ['�����'] = 6,
    ['������'] = 8,
    ['������'] = 8,
    ['�����'] = 8,
    ['%s+����'] = 7,
    ['%s+����'] = 7,
    ['������'] = 9,
    ['������'] = 9,
    ['������'] = 10,
    ['������'] = 10,
    ['������������'] = 11,
    ['�����������'] = 11,
    ['����������'] = 11,
    ['����������'] = 11,
    ['����������'] = 12,
    ['����������'] = 12,
    ['����������'] = 13,
    ['����������'] = 13,
    ['����������'] = 13,
    ['����������'] = 13,
    ['������������'] = 14,
    ['������������'] = 14,
    ['����������'] = 15,
    ['����������'] = 15,
    ['�����������'] = 16,
    ['�����������'] = 16,
    ['����������'] = 16,
    ['����������'] = 16,
    ['����������'] = 17,
    ['����������'] = 17,
    ['�����������'] = 17,
    ['�����������'] = 17,
    ['������������'] = 18,
    ['������������'] = 18,
    ['�������������'] = 18,
    ['�������������'] = 18,
    ['������������'] = 19,
    ['������������'] = 19,
    ['��������'] = 20,
    ['��������'] = 20,
    ['��������'] = 30,
    ['��������'] = 30,
    ['�����'] = 40,
    ['������'] = 40,
    ['��������'] = 40,
    ['���������'] = 50,
    ['����������'] = 50,
    ['����������'] = 60,
    ['�����������'] = 60,
    ['���������'] = 70,
    ['����������'] = 70,
    ['�����������'] = 80,
    ['������������'] = 80,
    ['���������'] = 90,
    ['���'] = 100,
    ['����'] = 100
}
-- �������������� �������� �������
maths = { -- 0 ��������� 1 -- �������, 2 - ���������, 3 - ����
    ['���'] = '*',
    ['������ ��'] = '-',
    ['�������� ��'] = '/',
    ['�%s+'] = '*',
    ['������� �'] = '+',
    ['���������'] = '+',
    ['����'] = '+',
    ['�����'] = '-',
    ['��������'] = '*',
    ['���������'] = '/',
    ['�������� ��'] = '*',
    ['��������� ��'] = '/'
}
-- ����������� ������������
local oconfig = {
    {
        '��, � ���.',
        '��.',
        '���',
        '� ����������',
        '��� �',
        'da',
        '+',
        '���',
        '��',
        '�������',
        'yes',
        '� ���'
    },
    {
        '�� ��� �',
        '���� �',
        '� ���...',
        '������� ��� �',
        '��',
        '+',
        '++',
        'y',
        'yes',
        'da',
        'tut',
        '� ����'
    },
    {
        '���� ���� ����������',
        '������� ��� �����...',
        '�������',
        '��, � ���.',
        'tut',
        '�����',
        '���, �***�'
    },
    {
        '� ���� �� ��������',
        '� �� �����',
        '������� ������',
        '�� ��� ������',
        '��',
        'xz',
        '��� ��������',
        '��� ����',
        '� �� �����',
        '� ���� ��� ������� ������',
        '� ���� �� ���������� 3',
        '� ���� �� ������� 3'
    },
    {
        '� �� ���',
        '� �� �����, ��������� ������',
        '���������, � �� ��������',
        '� ���� �� ���������',
        'net',
        'ne bot'
    },
    '� ���� �� ���������',
    '� �������, � ��� ����?',
    'Arizona RP Mesa',
    '�������������',
    '������� ���',
    '�������:',
    '',
    false,
    false,
    {
        ['������'] = {'���', '���������'},
        ['�����'] = {'��', '!name, � $name.'}
    },
    true,
    true,
    '����',
    '((',
    ']:',
    true,
    true,
    false,
    16,
    '������������� (.+) ������� ���%:',
    '(.+)%[%d+%] �������%:',
    '%(%( ������������� (.+)%[%d+%]%:',
    '.+%[(%d+)%] �������%:',
    '%(%( ������������� .+%[(%d+)%]%:',
    '%(%( ������������� .+%[(%d+)%]%:',
    false,
    true, -- 1 ������ �� ���� 32
    false, -- 2 ������ �� ���� 33
    false, -- 3 ������ �� ���� 34
    {
        '�� ����',
        '��',
        '�� �����',
        '���� ��-������',
        '�� �*�',
        '�� �����'
    }, -- 35
    false, -- 36 ������ 1 ��
    false, -- 37 ������ 2 ��
    false, -- 38 ������ 3 ��
    {
        '��� �� ��',
        '�� �����',
        '������',
        '����',
        '���?',
        '�� ��?',
        '�� ��� �� �����'
    }, -- 39
    true, -- 40 �������� ���� �������
    true, -- 41 ���� ��� �����
    true, -- 42 �������� ��� �����
    false, -- 43 verbose
    false, -- 44 ��������
    '������', -- 45 �������
    true, -- 46 ������ ��������
    {
        '��� �� ��',
        '�� �����',
        '������',
        '����',
        '���?',
        '�� ��?',
        '�� ��� �� �����'
    }, -- 47 �� ������������
    {
        '��� �� ��',
        '�� �����',
        '������',
        '����',
        '���?',
        '�� ��?',
        '�� ��� �� �����'
    }, -- 48 �� � ���� ����
    '/botoff', -- 49 ��� ��� ����
    false, -- 50 ���� ���� ��� ������
    false, -- 51 ��������� ���� ��� �� OOB
    false, -- 52 ������ �� ���� ��� �� OOB
    false, -- 53 ���� ����
    true -- 54 ����� ������������� /b / ���
}
-- �������� � ������
patternon = true
-- ���������� ������������
config = {}
-- ���������� � �������
vartovar = { -- ���� �� ������ �������� ����� ����������, ������ ��� � �������.
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
-- ��������
engchar = {'A','a','B','b','Ch','C','ch','cc','ck','c','D','d','E','e','F','f','G','g','H','h','I','i','J','j','K','k','L','l','M','m','N','n','O','o','P','p','Q','q','R','r','Sh','Sch','S','sh','sch','s','T','t','U','u','W','w','X','x','Y','y','Z','z','V','v'}
ruschar = {'�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','��','��','�','�','�','�','�','�','�','�','�','�','�','�','��','��','�','�','�','�','�','�','�','�','�','�','�','�','�','�','��','��','�','�','�','�','�','�'}
function translit(text)
    if text == nil then
        return
    end
    for i, y in ipairs(engchar) do
        text = text:gsub(y,ruschar[i])
    end
    return text
end
-- �������������� ������
cyrlower = {'�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�','b','e','h','k','x','c','m','t','o','p','a'}
cyrlower2 = {'�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�','�','�','�','�','�','�','�','�','�','�','�'}
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
-- ����������
local ScreenWidth, ScreenHeight = getScreenResolution()
enabled = false
delayed = false
times = 0
lastanswer = '� ���'
-- ��������
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
-- ������������
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
    script_message('IAH Reloaded 1.0-RC2 (27-11-2020) by mhertz ��������!')
    script_message('�������: tiah (���/����), iah (���������)')
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
        script_message('�� ������� ��������� ������� ����������!')
    else
        if tonumber(body) > IAH2_version_id then
            script_message('�������� ����������! (LOC: ' .. tostring(IAH2_version_id) .. ' | SRV: ' .. body .. ')')
            script_message('��� ���������� ����������� /updateiah')
            if sampIsChatCommandDefined('updateiah') then sampUnregisterChatCommand('updateiah') end
            sampRegisterChatCommand('updateiah', function()
                downloadUrlToFile('https://raw.githubusercontent.com/xefinity/iah2/main/IAH2.lua', thisScript().path, function(id, status, p1, p2)
                    if status == dlstatus.STATUS_DOWNLOADINGDATA then
                        print(string.format('��������� %d �� %d.', p13, p23))
                    elseif status == dlstatus.STATUS_ENDDOWNLOADDATA then
                        script_message('���������� ���������. ������������ ������...')
                        lua_thread.create(function() wait(500) thisScript():reload() end)
                    end
                    if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
                        printText('��������� ������ ��� �������� ����������.')
                    end
                end)
            end)
        elseif IAH2_version_id > tonumber(body) then
            script_message('���� ������ ���� ������ �������? o_O')
        else
            script_message('���� ������ ���������.')
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
-- ��������� ������
function saveData(table, path)
    verbose('Saving data...',verboseType.LOG)
    if doesFileExist(path) then os.remove(path) end
    local sfa = io.open(path, "w")
    if sfa then
        sfa:write(encodeJson(table))
        sfa:close()
    end
end
-- ������ � ������
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
-- ������ � ������ (���� �������)
function reprdict(t)
    local str = ""
    for i, name in pairs(t) do
        str = str .. i .. '/' .. name[1] .. '/' .. name[2] .. '\n'
    end
    return str
end
-- ������ � ������ (���� �������)
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
-- ���������� � �������, �������
gbuffer1 = ''
gbuffer2 = ''
function paratotext_process(a, b)
    local k = vartovar[b]
    if k ~= nil then
        k = loadstring('return ' .. k)()
        k:gsub("%p", "%%%1") -- ����� �� ����
        if a == '$' then
            return k
        elseif a == '?' then
            return (lower_cyr(k) == gbuffer2) and ('��') or ('���')
        elseif a == '!' then
            return (lower_cyr(k) == gbuffer1) and ('��') or ('���')
        end
    end
    return b
end
function paratotext(a, b, s)
    if a == nil or b == nil or s == nil then
        return '��'
    end
    gbuffer1 = a
    gbuffer2 = b
    s = s:gsub('([%$%!%?])(%w+)',paratotext_process)
    return s
end
-- ����
function playSound()
    local as = loadAudioStream('moonloader/config/IAH2/sound.mp3')
    setAudioStreamVolume(as, 100)
    setAudioStreamState(as, 1)
end
-- ������� ������
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
        wait(math.random(200,300)*string.len(text)+300) -- ��������� ����� ������
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
-- ������� ��������� ������ � �������/���������
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
    -- ��������������
    otext = text
    text = lower_cyr(text)
    text = text:gsub("%{......%}", "")
    -- ���������������� �������
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
    if config[54] and (text:find(' �� � %/�') or text:find(' �� � n�n%-r� ���') or text:find(' �� � ����� ���') or text:find(' �� � %/�') or text:find(' �� � b ') or text:find(' �� � � ') or (text:find(' � �� ���') and text:find(' �� � �� ���') == nil) or (text:find(' � rp ���') and text:find(' �� � rp ���') == nil) or text:find(' �� � n�nr� ���') or text:find(' �� � nr� ���') or (text:find(' � ������� ���') and text:find(' �� � ������� ���') == nil) or text:find(' � ���') or text:find(' ��� %/�')) then
        recognizedchat = true
        inb = false
    elseif config[54] and (text:find('%/�') or text:find('����� ���') or text:find('n�nr� ���') or text:find('nr� ���') or text:find('n�n-r� ���') or text:find('%/�')) then
        recognizedchat = true
        inb = true
    else
        recognizedchat = false
    end
    -- ���� �������
    if config[40] == true then
        for i,name in pairs(config[15]) do
            if text:find(i, 1, true) and text:find(name[1], 1, true) then
                patternyour = patternyour + 1
                return printText(paratotext(i,name[1],name[2]), dialog)
            end
        end
    end
    -- ����� ��������������
    local mtext = text
    for i, name in pairs(maths) do
        mtext = mtext:gsub(i,' ' .. name .. ' ')
    end
    for i, name in pairs(numbers) do
        mtext = mtext:gsub(i,name)
    end
    -- ������
    if (text:find('���') or text:find('�����')) and (text:find('����') or text:find('�����') or text:find('����������') or text:find('����')) then
        return printText(config[6], dialog)
    elseif (text:find('��������') or text:find('���') or text:find('������������') or text:find('������������') or text:find('������')) and (text:find('���') or text:find('������') or text:find('������')) then
        return printText(config[8], dialog)
    elseif (text:find('���') or text:find('���')) and (text:find('��������') or text:find('������') or text:find('��������') or text:find('��������') or text:find('��������')) then
        return printText(config[7], dialog)
    elseif ( ( ( text:find('���') or text:find('�����') ) and (text:find('���') or text:find('���'))) or text:find('����') or text:find('���')) and (text:find('���') or text:find('�����') or text:find('���') or text:find('�����')) then
        return printText(config[18], dialog)
    elseif ( ( ( text:find('���') or text:find('�����') ) and (text:find('���') or text:find('���'))) or text:find('����') or text:find('���')) and text:find('������') then
        return printText(config[45], dialog)
    elseif (text:find('��') or text:find('��')) and text:find(lower_cyr(config[18])) then
        return printText('��', dialog)
    elseif (text:find('������') or text:find('���-��') or text:find('����������')) and (text:find('�����') or text:find('������') or text:find('�����') or text:find('����') or text:find('������') or text:find('����') or text:find('�����')) and text:find('�����') then
        return printText('3', dialog)
    elseif (text:find('������') or text:find('���-��') or text:find('����������')) and text:find('�����') then
        return printText('12', dialog)
    elseif (text:find('����') or text:find('�����') or text:find('���')) and text:find('�����') then
        return printText('����', dialog)
    elseif (text:find('������') or (text:find('���') and text:find('���')) or text:find('�����')) and text:find('�����') then
        return printText('������', dialog)
    elseif (text:find('����') or text:find('�����')) and text:find('���') and text:find('���') then
        return printText('1 ������', dialog)
    elseif (text:find('����') or text:find('�����')) and text:find('���� ������') then
        return printText('9 ���', dialog)
    elseif (text:find('���') or text:find('���') or (text:find('�����') and text:find('����'))) and (text:find('���') or text:find('ni��') or (text:find('���') and text:find('�������'))) and (text:find('�����') or text:find('����') or text:find('�������')) then
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
    elseif (text:find('���') or text:find('���') or text:find('���') or (( text:find('���') or text:find('�����') ) and text:find('����'))) and (text:find('���') or text:find('ni��') or (text:find('���') and text:find('�������'))) then
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
    elseif (text:find('���') or text:find('���') or (( text:find('���') or text:find('�����') ) and text:find('����'))) and (text:find('���') or text:find('�����') or text:find('�����')) and (text:find('�����') or text:find('����') or text:find('�������')) then
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
    elseif (text:find('���') or text:find('���') or (( text:find('���') or text:find('�����') ) and text:find('����'))) and text:find('�������') and (text:find('�����') or text:find('����') or text:find('�������')) then
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
    elseif (text:find('���') or text:find('���') or (( text:find('���') or text:find('�����') ) and text:find('����'))) and (text:find('���') or text:find('�����') or text:find('�����')) then
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
    elseif (text:find('���') or text:find('���') or text:find('���') or (( text:find('���') or text:find('�����') ) and text:find('����'))) and text:find('�������') then
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
    elseif (text:find('���') or (text:find('�����') and text:find('����'))) and (text:find('id') or text:find('����') or text:find('��')) then
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
    elseif (text:find('�����') or text:find('����') or text:find('����')) and text:find('�����') and (text:find('�riz�n�') or text:find('������')) then
        return printText('2014', dialog)
    elseif (text:find('����') or text:find('�����') or text:find('���')) and (text:find('�����') or text:find('�����') or text:find('����')) then
        return printText('����', dialog)
    elseif (text:find('������') or text:find('�����')) and (text:find('�����') or text:find('�����') or text:find('����')) then
        return printText('����', dialog)
    elseif (text:find('������') or text:find('���-��') or text:find('����������')) and text:find('�������') then
        return printText('5', dialog)
    elseif (text:find('�����') or text:find('����')) and (text:find('������') or text:find('������� �����')) then
        return printText('������', dialog)
    elseif (text:find('������') or text:find('�������')) and (text:find('������') or text:find('������� �����')) then
        return printText('����', dialog)
    elseif (text:find('������') or text:find('�������')) and (text:find('����') or text:find('����')) then
        return printText('����� � �����', dialog)
    elseif (text:find('�����') or text:find('����')) and (text:find('����') or text:find('����')) then
        return printText('�����, ������� � �����', dialog)
    elseif (text:find('�������') or text:find('����������')) and (text:find('������') or text:find('������� �����')) then
        return printText('�����', dialog)
    elseif (text:find('�����') or text:find('�������')) and (text:find('������') or text:find('������� �����')) then
        return printText('�����', dialog)
    elseif (text:find('�����') or text:find('������ ����')) and (text:find('������') or text:find('������� �����')) then
        return printText('���', dialog)
    elseif (text:find('�����') or text:find('������')) and (text:find('�������') or text:find('������� �����')) then
        return printText('������', dialog)
    elseif (text:find('������') or text:find('�����')) and (text:find('�������') or text:find('������� �����')) then
        return printText('������', dialog)
    elseif (text:find('�����') or text:find('�������') or text:find('�����')) and (text:find('����')) then
        return printText(tostring(os.date("*t").day) .. '.' .. tostring(os.date("*t").month) .. '.' .. tostring(os.date('*t').year), dialog)
    elseif (text:find('������') or text:find('�������') or text:find('�����')) and text:find('�����') then
        local months = {'������','�������','����','������','���','����','����','������','��������','�������','������','�������'}
        return printText(months[os.date("*t").month], dialog)
    elseif (text:find('������') or text:find('�������') or text:find('�����')) and text:find(' ���') then
        return printText(tostring(os.date("*t").year), dialog)
    elseif (text:find('����') or text:find('�������')) and (text:find('���') or text:find(' ���')) then
        return printText(tostring(config[24]), dialog)
    elseif (text:find('�����') or text:find('�������')) and (text:find('�����')) then
        return printText(tostring(os.date("*t").day), dialog)
    elseif (text:find('�����') or text:find('�� �������')) and (text:find('�����')) then
        local yesterday = os.date("*t", os.time()-86400).day
        return printText(tostring(yesterday), dialog)
    elseif (text:find('�����') or text:find('����') or text:find('�������') or text:find('�����')) and (text:find('���') or text:find('����')) and text:find('���') then
        local chas = '�����'
        local hour = os.date("!*t", os.time() + 3 * 60 * 60).hour
        if hour == 1 or hour == 21 then
            chas = '���'
        elseif hour == 2 or hour == 3 or hour == 4 or hour == 22 or hour == 23 or hour == 24 then
            chas = '����'
        end
        return printText(tostring(hour) .. ' ' .. chas, dialog)
    elseif (text:find('�����') or text:find('����') or text:find('�������') or text:find('�����')) and (text:find('���') or text:find('����')) then
        local chas = '�����'
        local hour = os.date("*t").hour
        if hour == 1 or hour == 21 then
            chas = '���'
        elseif hour == 2 or hour == 3 or hour == 4 or hour == 22 or hour == 23 or hour == 24 then
            chas = '����'
        end
        return printText(tostring(hour) .. ' ' .. chas, dialog)
    elseif (text:find('������') or text:find('�������')) and (text:find('����')) then
        local daysoftheweek={"�����������","�����������","�������","�����","�������","�������","�������"}
        return printText(daysoftheweek[os.date("*t").wday], dialog)
    elseif (text:find('������') or text:find('����� �������')) and (text:find('����') or text:find('����')) then
        local daysoftheweek={"�����������","�����������","�������","�����","�������","�������","�������"}
        local nextday = os.date("*t", os.time()+86400).wday
        return printText(daysoftheweek[nextday], dialog)
    elseif (text:find('�����') or text:find('�� �������')) and text:find('����') then
        local daysoftheweek={"�����������","�����������","�������","�����","�������","�������","�������"}
        local nextday = os.date("*t", os.time()-86400).wday
        return printText(daysoftheweek[nextday], dialog)
    elseif (text:find('���') or text:find('����') or (text:find('�����') and (text:find('���') or text:find('���')))) and (text:find('���') or text:find('ni��') or text:find('���')) and (text:find('�����') or text:find('����') or text:find('�������')) then
        local _, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
        return printText(translit(sampGetPlayerNickname(id)), dialog)
    elseif (text:find('���') or text:find('����') or (text:find('�����') and (text:find('���') or text:find('���')))) and (text:find('���') or text:find('ni��') or text:find('���')) then
        local _, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
        return printText(sampGetPlayerNickname(id), dialog)
    elseif (text:find('���') or text:find('����') or (text:find('�����') and (text:find('���') or text:find('���')))) and (text:find('��') or text:find('id') or text:find('����')) then
        local _, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
        return printText(id, dialog)
    elseif mtext:match('(%-?%d+%s-[%+%-%*%/%^]%s-%-?%d+%s-[%+%-%*%/%^]%s-%-?%d+)') then
        n = mtext:match('(%-?%d+%s-%p%s-%-?%d+%s-%p%s-%-?%d+)')
        local res = loadstring('return '..n)()
        verbose('Math Match: '..text..' Possible Result: '..res,verboseType.MATCH)
        if res ~= res then
            return printText("������", dialog)
        end
        if res ~= nil and (res > math.random(3000,3552) or res < math.random(-1000,-1552) or res % 1 ~= 0) then -- ����� ������ �� ������ �������� ��� 300+301
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
            return printText("������", dialog)
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
    -- ������� ������� �������
    elseif config[23] == true and (otext:match('�������� (.+)') or otext:match('�������� (.+)') or otext:match('������� (.+)') or otext:match('������� (.+)') or otext:match('��������� (.+)') or otext:match('��������� (.+)')) then
        local res = otext:match('�������� � ��� (.+)')
        if res == nil then
            res = otext:match('�������� � ��� (.+)')
            if res == nil then
                res = otext:match('������� � ��� (.+)')
                if res == nil then
                    res = otext:match('������� � ��� (.+)')
                    if res == nil then
                        res = otext:match('��������� � ��� (.+)')
                        if res == nil then
                            res = otext:match('��������� � ��� (.+)')
                            if res == nil then
                                res = otext:match('�������� (.+) � ���')
                                if res == nil then
                                    res = otext:match('�������� (.+) � ���')
                                    if res == nil then
                                        res = otext:match('������� (.+) � ���')
                                        if res == nil then
                                            res = otext:match('������� (.+) � ���')
                                            if res == nil then
                                                res = otext:match('��������� (.+) � ���')
                                                if res == nil then
                                                    res = otext:match('��������� (.+) � ���')
                                                    if res == nil then
                                                        res = otext:match('�������� (.+)')
                                                        if res == nil then
                                                            res = otext:match('�������� (.+)')
                                                            if res == nil then
                                                                res = otext:match('������� (.+)')
                                                                if res == nil then
                                                                    res = otext:match('������� (.+)')
                                                                    if res == nil then
                                                                        res = otext:match('��������� (.+)')
                                                                        if res == nil then
                                                                            res = otext:match('��������� (.+)')
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
                wait(math.random(150,250)*string.len(res)+300) -- ��������� ����� ������
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
    elseif text:find('%s+���') or text:find('%s+�����') then
        verbose('Are you not a bot? Possible Match: '..text,verboseType.HALFMATCH)
        return printText(config[5][math.random(#config[5])], dialog, verboseType.HALFMATCH)
    elseif text:find('%s+���') or text:find('�����') or text:find('�� �����������') or text:find('� � � � �') or text:find('� � �') or text:find('����� �%s+') or text:find('������������') or text:find('�� �����') then
        verbose('Are you here? Possible Match: '..text,verboseType.HALFMATCH)
        if times == 0 then
            return printText(config[1][math.random(#config[1])], dialog, verboseType.HALFMATCH)
        elseif times == 1 then
            return printText(config[2][math.random(#config[2])], dialog, verboseType.HALFMATCH)
        elseif times == 2 then
            return printText(config[3][math.random(#config[3])], dialog, verboseType.HALFMATCH)
        end
    elseif (text:find('� /�') or text:find('� n�n-r�') or text:find('�����') or text:find('���-��')) and config[46] == true then
        verbose('Repeat in /b: Possible Match: '..text,verboseType.HALFMATCH)
        if lastanswer:find('/b ') then
            printText(lastanswer, dialog)
        else
            printText('/b ' .. lastanswer, dialog)
        end
    elseif (text:find('���') or text:find('� r�') or text:find('� ��')) and config[46] == true then
        verbose('Repeat in normal chat: Possible Match: '..text,verboseType.HALFMATCH)
        if lastanswer:find('/b ') then
            printText(lastanswer:sub(4), dialog)
        else
            printText(lastanswer, dialog)
        end
    elseif text:find('������') or text:find('����������') or text:find('%s+��') then
        verbose('Hello! Possible Match: '..text,verboseType.HALFMATCH)
        return printText('������', dialog, verboseType.HALFMATCH)
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
    -- �� ���� ����� �����
    if text:find(config[9], 1, patternon) ~= nil and text:find(config[10], 1, patternon) ~= nil then
        verbose('Can\'t match: '..text,verboseType.MISMATCH_1)
    elseif text:find(config[11], 1, patternon) ~= nil and text:find(config[12], 1, patternon) ~= nil then
        verbose('Can\'t match: '..text,verboseType.MISMATCH_2)
    elseif text:find(config[19], 1, patternon) ~= nil and text:find(config[20], 1, patternon) ~= nil then
        verbose('Can\'t match: '..text,verboseType.MISMATCH_3)
    end
end
-- ������
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
-- ���������
function sp.onServerMessage(color, text)
    if enabled then
        processText(text, false)
    end
end
-- ImGui
function imgui.OnDrawFrame()
    if crash_flag == true then -- �� �����������, ��� ��� ��� ������ -_-
        crash()
    end
    -- ���������
    if main_window_state.v then
        -- ��� ����������
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
        imgui.Begin(u8'��������� IAH (ver 1.0-RC2)', main_window_state)
        if imgui.Button(u8'��������� ������') then
            saveData(config,'moonloader/config/IAH2/config.json')
        end
        imgui.SameLine()
        if imgui.Button(u8'�������� ��������') then
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
        if imgui.Button(u8'������������� ������') then
            thisScript():reload()
        end
        if imgui.CollapsingHeader(u8"��������� �������� ����") then
            imgui.BeginChild("##first", imgui.ImVec2(375, 115), true, imgui.WindowFlags.NoScrollbar)
            imgui.Text(u8'������ ������ �������� ����:')
            if imgui.InputText(u8'����. ����� 1', small_buffer1) then
                config[9] = lower_cyr(u8:decode(small_buffer1.v))
            end
            if imgui.InputText(u8'����. ����� 2', small_buffer2) then
                config[10] = lower_cyr(u8:decode(small_buffer2.v))
            end
            imgui.EndChild()
            imgui.SameLine()
            imgui.BeginChild("##second", imgui.ImVec2(375, 115), true, imgui.WindowFlags.NoScrollbar)
            imgui.Text(u8'������ ������ �������� ����:')
            if imgui.InputText(u8'����. ����� 1', small_buffer3) then
                config[11] = lower_cyr(u8:decode(small_buffer3.v))
            end
            if imgui.InputText(u8'����. ����� 2', small_buffer4) then
                config[12] = lower_cyr(u8:decode(small_buffer4.v))
            end
            imgui.EndChild()
            imgui.BeginChild("##peeks", imgui.ImVec2(375, 115), true, imgui.WindowFlags.NoScrollbar)
            imgui.Text(u8'������ ������ �������� ����:')
            if imgui.InputText(u8'����. ����� 1', small_buffer9) then
                config[19] = lower_cyr(u8:decode(small_buffer9.v))
            end
            if imgui.InputText(u8'����. ����� 2', small_buffer10) then
                config[20] = lower_cyr(u8:decode(small_buffer10.v))
            end
            imgui.EndChild()
            imgui.Text(u8'�������� �� ���� ��:')
            imgui.SameLine(395)
            imgui.Text(u8'�������� ������ ����:')
            imgui.BeginChild("##peekzzaa", imgui.ImVec2(375, 115), true, imgui.WindowFlags.NoScrollbar)
            if imgui.Checkbox(u8'1-� ������ ����', notknow1) then
                config[32] = notknow1.v
            end
            if imgui.Checkbox(u8'2-� ������ ����', notknow2) then
                config[33] = notknow2.v
            end
            if imgui.Checkbox(u8'3-� ������ ����', notknow3) then
                config[34] = notknow3.v
            end
            imgui.EndChild()
            imgui.SameLine()
            imgui.BeginChild("##peekzzaab", imgui.ImVec2(375, 115), true, imgui.WindowFlags.NoScrollbar)
            if imgui.Checkbox(u8'1-� ������ ����', imosound1) then
                config[36] = imosound1.v
            end
            if imgui.Checkbox(u8'2-� ������ ����', imosound2) then
                config[37] = imosound2.v
            end
            if imgui.Checkbox(u8'3-� ������ ����', imosound3) then
                config[38] = imosound3.v
            end
            imgui.EndChild()
            imgui.Text(u8'��������� �����:')
            imgui.BeginChild("##ee�", imgui.ImVec2(375, 115), true, imgui.WindowFlags.NoScrollbar)
            if imgui.Checkbox(u8'1-� ������ ����', imsound1) then
                config[16] = imsound1.v
            end
            if imgui.Checkbox(u8'2-� ������ ����', imsound2) then
                config[17] = imsound2.v
            end
            if imgui.Checkbox(u8'3-� ������ ����', imsound3) then
                config[21] = imsound3.v
            end
            imgui.EndChild()
        end
        if imgui.CollapsingHeader(u8"��������� �������") then
            imgui.BeginChild("##ff", imgui.ImVec2(375, 115), true, imgui.WindowFlags.NoScrollbar)
            if imgui.Checkbox(u8'������� ��� Arizona', imarz) then
                config[22] = imarz.v
            end
            if imgui.Checkbox(u8'������ � /b ���', imbchat) then
                config[13] = imbchat.v
            end
            if imgui.Checkbox(u8'����', imsound) then
                if imsound.v == true and not doesFileExist('moonloader/config/IAH2/sound.mp3') then
                    imsound.v = false
                    script_message('������: �� ������ ���� ����� (moonloader/config/IAH2/sound.mp3)')
                end
                config[14] = imsound.v
            end
            imgui.SameLine()
            if imgui.Button(u8'��������� ����') then
                if not doesFileExist('moonloader/config/IAH2/sound.mp3') then
                    script_message('������: �� ������ ���� ����� (moonloader/config/IAH2/sound.mp3)')
                else
                    playSound()
                end
            end
            imgui.EndChild()
            imgui.SameLine()
            imgui.BeginChild("##peekzzaaba", imgui.ImVec2(375, 115), true, imgui.WindowFlags.NoScrollbar)
            if imgui.Checkbox(u8'���� ��� ����� � ��', imosounds) then
                config[41] = imosounds.v
            end
            if imgui.Checkbox(u8'�������� ��� ����� � ��', imanss) then
                config[42] = imanss.v
            end
            if imgui.Checkbox(u8'�������� � ������', impon) then
                config[44] = impon.v
                patternon = not impon.v
            end
            imgui.EndChild()
            imgui.BeginChild("##peekzz", imgui.ImVec2(375, 115), true, imgui.WindowFlags.NoScrollbar)
            if imgui.Checkbox(u8'�����������. �������', imtest) then
                config[23] = imtest.v
            end
            if imgui.Checkbox(u8'������-���', imbar) then
                config[31] = imbar.v
                bar_state.v = imbar.v
            end
            if imgui.Checkbox(u8'������������', imverbose) then
                config[43] = imverbose.v
            end
            imgui.EndChild()
            imgui.SameLine()
            imgui.BeginChild("##ee�a", imgui.ImVec2(375, 115), true, imgui.WindowFlags.NoScrollbar)
            if imgui.Checkbox(u8'����������� ������', imcontinue) then
                config[46] = imcontinue.v
            end
            if imgui.Checkbox(u8'����� ��� TP OOB', imcrash) then
                config[52] = imcrash.v
            end
            if imgui.Checkbox(u8'"�����" ����� � /b', imsmartans) then
                config[54] = imsmartans.v
            end
            imgui.EndChild()
            imgui.BeginChild("##ee�art", imgui.ImVec2(375, 115), true, imgui.WindowFlags.NoScrollbar)
            if imgui.Checkbox(u8'��� ���� ��� ������', imcon) then
                config[50] = imcon.v
            end
            if imgui.Checkbox(u8'��� ���� ��� TP OOB', imconoob) then
                config[51] = imconoob.v
            end
            if imgui.Checkbox(u8'�� ������� ��� ������', imfrz) then
                config[53] = imfrz.v
            end
            imgui.EndChild()
        end
        if imgui.CollapsingHeader(u8"��������� ������� ���� � ����������") then
            imgui.BeginChild("##peek", imgui.ImVec2(375, 115), true, imgui.WindowFlags.NoScrollbar)
            if imgui.InputText(u8'���', small_buffer8) then
                config[18] = u8:decode(small_buffer8.v)
            end
            if imgui.InputText(u8'�������', small_buffer11) then
                config[45] = u8:decode(small_buffer11.v)
            end
            if imgui.InputInt(u8'�������', image, 1, 1) then
                config[24] = image.v
            end
            imgui.EndChild()
            imgui.SameLine()
            imgui.BeginChild("##third", imgui.ImVec2(375, 115), true, imgui.WindowFlags.NoScrollbar)
            if imgui.InputText(u8'��� ����?', small_buffer5) then
                config[6] = u8:decode(small_buffer5.v)
            end
            if imgui.InputText(u8'��� �������?', small_buffer6) then
                config[7] = u8:decode(small_buffer6.v)
            end
            if imgui.InputText(u8'�������� �����', small_buffer7) then
                config[8] = u8:decode(small_buffer7.v)
            end
            imgui.EndChild()
            imgui.BeginChild("##muuha", imgui.ImVec2(375, 115), true, imgui.WindowFlags.NoScrollbar)
            if imgui.InputText(u8'������� ����', small_buffer12) then
                config[49] = u8:decode(small_buffer12.v)
            end
            imgui.EndChild()
        end
        if imgui.CollapsingHeader(u8"��������� ��������� ����") then
            imgui.BeginChild("##��", imgui.ImVec2(758, 533), true, imgui.WindowFlags.NoScrollbar)
            imgui.Text(u8'���������� ����� ������:')
            if imgui.InputTextMultiline(u8'1-� ���', big_buffer1, imgui.ImVec2(180, 150)) then
                config[1] = split(u8:decode(big_buffer1.v))
            end
            imgui.SameLine(250)
            if imgui.InputTextMultiline(u8'2-� ���', big_buffer2, imgui.ImVec2(180, 150)) then
                config[2] = split(u8:decode(big_buffer2.v))
            end
            imgui.SameLine(500)
            if imgui.InputTextMultiline(u8'3-� ���', big_buffer3, imgui.ImVec2(180, 150)) then
                config[3] = split(u8:decode(big_buffer3.v))
            end
            if imgui.InputTextMultiline(u8'������', big_buffer4, imgui.ImVec2(180, 150)) then
                config[4] = split(u8:decode(big_buffer4.v))
            end
            imgui.SameLine(250)
            if imgui.InputTextMultiline(u8'�� ���?', big_buffer5, imgui.ImVec2(180, 150)) then
                config[5] = split(u8:decode(big_buffer5.v))
            end
            imgui.SameLine(500)
            if imgui.InputTextMultiline(u8'�� ����', big_buffer7, imgui.ImVec2(180, 150)) then
                config[35] = split(u8:decode(big_buffer7.v))
            end
            if imgui.InputTextMultiline(u8'����', big_buffer8, imgui.ImVec2(180, 150)) then
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
        if imgui.CollapsingHeader(u8"���� �������") then
            imgui.BeginChild("##df", imgui.ImVec2(778, 178), true, imgui.WindowFlags.NoScrollbar)
            if imgui.Checkbox(u8'��������', impq) then
                config[40] = impq.v
            end
            imgui.SameLine()
            if imgui.Button(u8'�������') then
                saveData(config[15],'moonloader/config/IAH2/baza.json')
                script_message('�������/������ ���� �������������� � moonloader/config/IAH2/baza.json')
            end
            imgui.SameLine()
            if imgui.Button(u8'������') then
                if not doesFileExist('moonloader/config/IAH2/baza.json') then
                    script_message('�� ������� ���� ������ ��������/�������! (moonloader/config/IAH2/baza.json)')
                else
                    saveData(config[15],'moonloader/config/IAH2/baza.bak')
                    local file = io.open('moonloader/config/IAH2/baza.json', 'r')
                    if file then
                        config[15] = decodeJson(file:read('*a'))
                    end
                    script_message('�� ������� ���������! ����� �������� ��� baza.bak')
                end
            end
            if imgui.InputTextMultiline(u8'���� �������\n(��� ����� � ����� ������ ����� /,\n������: ������/�����/������)\n������ ������ � ����� �����.\n������ ���� ������ ���� ��������,\n������ �� �����������.\n����� ����� ������ �������.', big_buffer6) then
                config[15] = dereprdict(u8:decode(big_buffer6.v))
            end
            imgui.EndChild()
        end
        if imgui.CollapsingHeader(u8"��������") then
            imgui.Text(u8'�������� �� ��� ������� �� ��������!')
            imgui.Text(u8'��� ������:')
            imgui.SameLine(395)
            imgui.Text(u8'ID ������:')
            imgui.BeginChild("##pipee", imgui.ImVec2(375, 115), true, imgui.WindowFlags.NoScrollbar)
            if imgui.InputText(u8'1-� �������', pattern_buffers[1]) then
                config[25] = u8:decode(pattern_buffers[1].v)
            end
            if imgui.InputText(u8'2-� �������', pattern_buffers[2]) then
                config[26] = u8:decode(pattern_buffers[2].v)
            end
            if imgui.InputText(u8'3-� �������', pattern_buffers[3]) then
                config[27] = u8:decode(pattern_buffers[3].v)
            end
            imgui.EndChild()
            imgui.SameLine()
            imgui.BeginChild("##pipees", imgui.ImVec2(375, 115), true, imgui.WindowFlags.NoScrollbar)
            if imgui.InputText(u8'1-� �������', pattern_buffers[4]) then
                config[28] = lower_cyr(u8:decode(pattern_buffers[4].v))
            end
            if imgui.InputText(u8'2-� �������', pattern_buffers[5]) then
                config[29] = lower_cyr(u8:decode(pattern_buffers[5].v))
            end
            if imgui.InputText(u8'3-� �������', pattern_buffers[6]) then
                config[30] = lower_cyr(u8:decode(pattern_buffers[6].v))
            end
            imgui.EndChild()
        end
        if imgui.CollapsingHeader(u8"������������� ���������� � ����� ��������") then
            imgui.Text(u8'�� ������ ������������ ���������� � ������� �� ���� �������.\n"����������" �������:\n$���������� - ���������� ���� ����������\n?���������� - �������� ���������� �� ������ ������ � �������, ����� ��� ��� ���\n!���������� - ����, ��� ����, �� � ������.\n���������� ����������: name - ���, servername - �������� �������, mood - ����������\nstatus - ��� �������, age - �������, day - �����\nmonth - ����� ������, year - ���, surname - �������')
        end
        imgui.End()
    end
    -- ������-���
    if bar_state.v then
        if main_window_state.v == false then
            imgui.ShowCursor = false
        end
        imgui.SetNextWindowPos(imgui.ImVec2(ScreenWidth / 7, ScreenHeight / 1.7), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(360, 180), imgui.Cond.FirstUseEver)
        imgui.Begin(u8"IAH Stats", bar_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
        imgui.Text(u8'����� ����������: ' .. patterndetected1 + patterndetected2 + patterndetected3)
        imgui.Text(u8'�� ��� �� 1 ��: ' .. patterndetected1 .. u8', �� 2 ��: ' .. patterndetected2 .. u8', �� 3 ��: ' .. patterndetected3)
        imgui.Text(u8'����� ��������: ' .. patternanswered .. u8' (�� ����� ��������: ' .. patternyour .. u8')')
        imgui.Text(u8'���������������: ' .. patternskipped .. u8', �������� "�� ����": ' .. patternnotknow)
        imgui.Text(u8'������: ' .. patternslapped .. u8', ��: ' .. patterntp .. u8', �� OOB: ' .. patternoob)
        imgui.Text(u8'���������: ' .. patternrepeated)
        imgui.End()
    end
end
function tiah()
    -- ���/����
    verbose('Script Enabled: ' .. (enabled and 'No' or 'Yes'),verboseType.LOG)
    enabled = not enabled
    if enabled == false then
        newpos = {0, 0, 0}
    end
    script_message('�� ' .. (enabled and '������' or '���������') .. ' ����������.')
end
function iah()
    -- �������� ���� ��������
    main_window_state.v = not main_window_state.v
end
local repo = 'https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
local Options = Library.Options
local Toggles = Library.Toggles



shared = shared or {}


if shared.isExecuted then
    shared.p()
end




local Window = Library:CreateWindow({
	-- Set Center to true if you want the menu to appear in the center
	-- Set AutoShow to true if you want the menu to appear when it is created
	-- Set Resizable to true if you want to have in-game resizable Window
	-- Set ShowCustomCursor to false if you don't want to use the Linoria cursor
	-- NotifySide = Changes the side of the notifications (Left, Right) (Default value = Left)
	-- Position and Size are also valid options here
	-- but you do not need to define them unless you are changing them :)

	Title = 'Piggy Exploit',
	Center = true,
	AutoShow = true,
	Resizable = true,
	ShowCustomCursor = true,
	NotifySide = "Left",
	TabPadding = 8,
	MenuFadeTime = 0.2
})




local Tabs = {
    ['Menu'] = Window:AddTab('Menu'),
    ['Game'] = Window:AddTab('Game')
}


do
    local VotingTabBox = Tabs.Menu:AddLeftTabbox()



    do
        local Map = VotingTabBox:AddTab('Map Voting')

        do
            local selection = 'House'


            Map:AddDropdown('MapVotedSelectedList', {
                Values = {
                    'House',
                    'Station',
                    'Gallery',
                    'Forest',
                    'School',
                    'Hospital',
                    'Metro',
                    'Carnival',
                    'City',
                    'Mall',
                    'Outpost',
                    'Plant'
                },


                Default = 1,
                Multi = false,


                Text = 'Vote Map',
                Tooltip = 'Select a map, to AutoVote for.',


                Callback = function(val)
                    selection = val
                end
            })



            _G.AutoVoteMapEnabled = false


            shared.Workspace = workspace or (game and game:GetService('Workspace')) or nil




            local function startAutoVote()
                if _G.AutoVoteMapEnabled then
                    while _G.AutoVoteMapEnabled == true do
                        task.wait(0.5)

                        if shared.Workspace then
                            if (shared.Workspace:FindFirstChild('GameFolder') and shared.Workspace:FindFirstChild('GameFolder', true):FindFirstChild('Phase')) then
                                if shared.Workspace:FindFirstChild('GameFolder', true):FindFirstChild('Phase', true).Value and shared.Workspace:FindFirstChild('GameFolder', true):FindFirstChild('Phase', true).Value:find('Map Voting') then
                                    pcall(function()
                                        game:GetService("ReplicatedStorage").Remotes.NewVote:FireServer("Map", selection)
                                    end)
                                end
                            end
                        end

                        if _G.AutoVoteMapEnabled ~= true then
                            break
                        end
                    end
                end
            end



            Map:AddToggle('AutoVoteMapToggle', {
                Text = 'AutoVote Map',
                Default = false,
                Tooltip = 'When Enabled, will Automaticly Vote for the Map Selected.',

                Callback = function(Value)
                    _G.AutoVoteMapEnabled = Value


                    if startAutoVote then
                        startAutoVote()
                    else
                        warn('[StartAutoVote] Error: missing function.')
                    end
                end
            })
        end



        local PiggyMode = VotingTabBox:AddTab('Mode')

        do
            local selection = ''


            PiggyMode:AddDropdown('PiggyVotedSelectedList', {
                Values = {
                    'Bot',
                    'Player',
                    'Player + Bot',
                    'Infection',
                    'Traitor',
                    'Swarm',
                    'Tag'
                },

                Default = 1,
                Multi = false,

                Text = 'Vote Mode',
                Tooltip = 'Select a mode, to AutoVote for.',

                Callback = function(val)
                    if val == 'Player + Bot' then
                        val = 'PlayerBot'
                    end

                    selection = val
                end
            })


            _G.AutoVotePiggyModeEnabled = false



            local function startAutoVote()
                if _G.AutoVotePiggyModeEnabled then
                    while _G.AutoVotePiggyModeEnabled == true do
                        task.wait(0.5)

                        if shared.Workspace then
                            if (shared.Workspace:FindFirstChild('GameFolder') and shared.Workspace:FindFirstChild('GameFolder', true):FindFirstChild('Phase')) then
                                if shared.Workspace:FindFirstChild('GameFolder', true):FindFirstChild('Phase', true).Value and shared.Workspace:FindFirstChild('GameFolder', true):FindFirstChild('Phase', true).Value:find('Piggy Voting') then
                                    pcall(function()
                                        game:GetService("ReplicatedStorage").Remotes.NewVote:FireServer("Piggy", selection)
                                    end)
                                end
                            end
                        end

                        if _G.AutoVotePiggyModeEnabled ~= true then
                            break
                        end
                    end
                end
            end



            PiggyMode:AddToggle('AutoVotePiggyModeToggle', {
                Text = 'AutoVote Mode',
                Default = false,
                Tooltip = 'When Enabled, will Automaticly Vote for the Mode Selected.',

                Callback = function(val)
                    _G.AutoVotePiggyModeEnabled = val

                    if startAutoVote then
                        startAutoVote()
                    else
                        warn('[StartAutoVote] Error: missing function.')
                    end
                end
            })
        end
    end
end

package.path = package.path .. ";Lua/?.lua;Lua/?/?.lua"
require "luarocks.require"
require "CDK"
require "Curses"
require "Curses.Application"
require "Curses.Window"

-- Local Variables {{{
-- Variables used to set constats {{{
local Width
local Height
local TRUE = 1
local FALSE = 0
local backgroundcolor = "</56>"
local screen
-- }}}
-- Variables used to store info {{{
local Status = {
	Position = 0,
	Holes = 0,
	NHole = 0,
	Status = "Stopped",
	WorkingHours = 0	
}
local ProgramName = nil
local FormatName = nil
local Format = {
	Drills= {}
}
-- }}}
-- Labels {{{
local load_programs_label = "Fichero:"
local load_programs_title = "<C></B/1>Selecciona un programa"
local console_title = "<C></B/2>Consola de Información<!2>"
local logo = CDK.toCharDblPtr([[<C></B/6>Utiles Galvanotecnia Lacalle, S.L.<!6>
<C></D>gDrill 1.0b
]],2)

local format_str = [[<C></B/2>Formato<!2>

<I=5><#DI> Formato: </45>%s<!45>         

<I=5><#DI> Taladros: </45>%s<!45>       

]] -- 5 lines

local info_str = [[<C></B/2>Estado<!2>

<I=5><#DI> Posición: </45>%s<!45>       

<I=5><#DI> Taladro: </45>%s/%s<!45>

<I=5><#DI> Estado: </45>%s<!45>

<I=5><#DI> Horas de Trabajo: </45>%s<!45>       

]] -- 9 lines

local inputs_label = CDK.toCharDblPtr([[</B/2>Inputs<!2>

<C>I0 </B/16><#DI>
<C>I1 </B/24><#DI>
<C>I2 </B/16><#DI>
<C>I3 </B/24><#DI>
<C>I4 </B/16><#DI>
<C>I5 </B/16><#DI>
]],8) -- 8 lines 24:green 16:red

local outputs_label = CDK.toCharDblPtr([[</B></2>Outputs<!2>

<C>O0 </B/16><#DI>
<C>O1 </B/24><#DI>
<C>O2 </B/16><#DI>
<C>O3 </B/24><#DI>
<C>O4 </B/16><#DI>
<C>O5 </B/16><#DI>
]],8) -- 7 lines
-- }}}
-- }}}
-- Local functions {{{
-- getInfoLabel {{{
local function getInfoLabel (pos, holes, nhole, status, whours)
	return CDK.toCharDblPtr(string.format(info_str,
		pos, holes, nhole, status, whours),9)
end -- }}}
-- setInfoLabel {{{
local function updateInfoLabel (cdklabel)
	CDK.setCDKLabel(cdklabel, getInfoLabel(Status.Position, Status.Holes,
		Status.NHole, Status.Status, Status.WorkingHours), 9, TRUE)
	CDK.drawCDKScreen(cdkScreen);
end -- }}}
-- getFormatLabel {{{
local function getFormatLabel (formatname, format)
	return CDK.toCharDblPtr(string.format(format_str,
		formatname, #format.Drills),5)
end -- }}}
-- setFormatLabel {{{
local function setFormatLabel (cdklabel)
	CDK.setCDKLabel(cdklabel, getFormatLabel(FormatName, Format), 5, TRUE)
	CDK.drawCDKScreen(cdkScreen)
end --}}
-- no_border {{{
local function no_border (window)
	local BLANK = string.byte(' ')
	Curses.WBorder(window,
		BLANK,
		BLANK, 
		BLANK, 
		BLANK, 
		BLANK, 
		BLANK, 
		BLANK,
		BLANK
	)
end -- }}}
-- load_program {{{
local function load_program (programname)
	local lines = CDK.CDKreadFile(programname, fileContent())
	CDK.setCDKViewer(fileViewer,
		string.format("<C></B/2>%s<!2!B>",
			programname),
		fileContent.info, fileContent.lines, 262144, TRUE, FALSE, TRUE)
	CDK.drawCDKScreen(cdkScreen)
	Program = programname
end -- }}}
-- load_format {{{
local function load_format (formatname)
	local status, err = pcall(dofile, formatname)
	if not status then
		print("ERROR")
		return false
	else
		Format, err = pcall(dofile, formatname)
		if not format then
			print("ERROR")
			return false
		end
	end
	setFormatLabel(formatLabel)
	return true
end -- }}}
-- Bind Functions {{{
-- show_help {{{
local bind_show_help = CDK.newBindFunction(function (cdktype, object, cdata, key)
	local msg = CDK.toCharDblPtr([[<C></U>Help for </U>Who<!U>
<C>When this button is picked the name of the current
<C>user is displayed on the screen in a popup window.
]], 3)

	CDK.popupLabel(CDK.screenOf(object), msg, 3)
end)-- }}}
-- _select_file {{{
local _select_file = function (object, dir, title)
	local fselect = CDK.newCDKFselect(
		CDK.screenOf(object),
		Width/2,
		Height/2,
		20,
		30,
		title,
		"<C>Fichero: ",
		CDK.A_NORMAL, string.byte(" "), CDK.A_REVERSE,
		"</5>", "</48>", "</N>", "</N>",
		TRUE, FALSE)
	CDK.setCDKFselect(fselect, dir,
		CDK.A_NORMAL, string.byte(" "), CDK.A_REVERSE,
		"</5>", "</48>", "</N>", "</N>",
		TRUE)
	local file = CDK.activateCDKFselect(fselect, nil)
	CDK.destroyCDKFselect(fselect);
	CDK.drawCDKScreen(cdkScreen);
	return file
end -- }}}
-- bind_load_program {{{
local bind_load_program = CDK.newBindFunction(function (cdktype, object, cdata, key)
	local file = _select_file(object, PREFIX.."/Programs", "<C>Programas")
	load_program(file)
end) --}}}
-- bind_load_format {{{
local bind_load_format = CDK.newBindFunction(function (cdktype, object, cdata, key)
	local format = _select_file(object, "/home/atuin/Projects/gDrill/Formats", "<C>Formatos")
	FormatName = format
end) --}}}
-- quit {{{
local bind_quit = CDK.newBindFunction(function (cdktype, object, cdata, key)
	if (ProgramName) then
		os.execute("echo " .. ProgramName .. " > " .. PREFIX .. "/.program")
	end
	if (FormatName) then
		os.execute("echo " .. FormatName .. " > " .. PREFIX .. "/.format")
	end
	CDK.endCDK()
	os.exit()
end) --}}}
-- start_pause_program {{{
local bind_start_pause_program = CDK.newBindFunction(function (cdktype, object, cdata, key)
	if Status.Status == "Started" then
		Status.Status = "Paused"
	elseif Status.Status == "Stopped" then
		Status.Status = "Started"
	elseif Status.Status == "Paused" then
		Status.Status = "Started"
	else
		return nil
	end
	updateInfoLabel(infoLabel)
end)-- }}}
-- }}}
-- Main function {{{
local main = function (argc, argv)
	-- Load main config file
	if not pcall(dofile, "Config/Config.lua") then
		PREFIX = os.getenv("HOME") .. "/gDrill"
	end
	-- Load latest values for program and format if possible
	local fd = io.open(PREFIX.."/.program")
	if not fd then
		ProgramName = nil
	else
		ProgramName = fd:read("*line")
		fd:close()
	end
	local fd = io.open(PREFIX.."/.format")
	if not fd then
		FormatName = nil
	else
		FormatName = fd:read("*line")
		fd:close()
	end

	-- start UI
	local win = Curses.InitCurses()
	Height =  Curses.GetMaxY(win)
	Width = Curses.GetMaxX(win)
	CDK.initCDKColor()
	CDK.startCDKDebug("cdk.log")

	cdkScreen = CDK.initCDKScreen(win)

	screen = cdkScreen

	-- Top Logo
	local logoLabel = CDK.newCDKLabel(cdkScreen, CDK.CENTER,
		CDK.TOP, logo, 2, 0, 0)


	-- Window to Show Program	
	fileViewer = CDK.newCDKViewer(cdkScreen, 0,
		5, Height -20, Width/2, 0, 0, 262144, TRUE, FALSE);
	CDK.setCDKViewerBackgroundColor(fileViewer, backgroundcolor)
	-- New FileContent
	fileContent = CDK.CDKFileContent:new()
	print("KK")
	if (ProgramName) then
		print("MERDA,",Program)
		load_program(ProgramName)
	end

	-- Format Label
	formatLabel = CDK.newCDKLabel(cdkScreen, Width/2 + 22,
		6, getFormatLabel(FormatName or "None Selected", Format), 5, TRUE, FALSE)
	CDK.setCDKLabelBackgroundColor(formatLabel, backgroundcolor)
	if (FormatName) then
		load_format(FormatName)
	end

	-- Outputs Label
	local outputsLabel = CDK.newCDKLabel(cdkScreen,
		Width/2 + 4, 26, outputs_label, 8, TRUE, FALSE)
	CDK.setCDKLabelBackgroundColor(outputsLabel, backgroundcolor)
	-- Info Label
	infoLabel = CDK.newCDKLabel(cdkScreen, Width/2 + 22,
		20, getInfoLabel(0, 0, 0, "Stopped", 0), 9, TRUE, FALSE)
	updateInfoLabel(infoLabel)
	CDK.setCDKLabelBackgroundColor(infoLabel, backgroundcolor)
	-- Inputs Label
	local inputsLabel = CDK.newCDKLabel(cdkScreen,
		Width/2 + 4, 7, inputs_label, 8, TRUE, FALSE)
	CDK.setCDKLabelBackgroundColor(inputsLabel, backgroundcolor)

	-- Console Window
	local consoleSwindow = CDK.newCDKSwindow(cdkScreen, 
		4, Height -11, 10, Width -10, console_title, 100, TRUE, FALSE)
	CDK.addCDKSwindow(consoleSwindow, "<L></5>Starting gDrill ..", CDK.BOTTOM)
	CDK.setCDKSwindowBackgroundColor(consoleSwindow, backgroundcolor)

	-- Set some bindings
	CDK.bindCDKObject(CDK.vSWINDOW, consoleSwindow, string.byte('p'), bind_load_program, nil) 
	CDK.bindCDKObject(CDK.vSWINDOW, consoleSwindow, string.byte('q'), bind_quit, nil) 
	CDK.bindCDKObject(CDK.vSWINDOW, consoleSwindow, string.byte('f'), bind_load_format, nil) 
	CDK.bindCDKObject(CDK.vSWINDOW, consoleSwindow, string.byte(' '), bind_start_pause_program, nil)

	-- Draw Screen
	CDK.drawCDKScreen(cdkScreen)

	while (true) do
		CDK.activateCDKSwindow(consoleSwindow, nil)
		CDK.drawCDKScreen(cdkScreen)
	end
	CDK.endCDK()
end -- }}}
-- Start the program {{{
main(#arg, arg)
-- }}}
---- vi: set foldmethod=marker foldlevel=0:

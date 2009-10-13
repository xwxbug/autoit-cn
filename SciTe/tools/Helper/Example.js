//  This - an example and descriptions of all available methods SciTE Helper:
//  Это - пример и описание всех доступных методов SciTE Helper:
//  ===============================================
//  In the beginning we create object
//  Вначале создаем объект
try {
	var SciTE=new ActiveXObject("SciTE.Helper");
} catch(e) {
	WScript.Echo("Please install SciTE Helper before!");
	WScript.Quit(1);
}

// Печать строки в окне консоли (без префикса и перевода строки)
// Writes string to the output pane (no prefix, no newlines)
SciTE.Trace("Example of all available methods:\\n\\n");

// SciTE window size and position
SciTE.Trace ("position.Left = " + SciTE.Left + "\\n");
SciTE.Trace ("position.top = " + SciTE.Top + "\\n");
SciTE.Trace ("position.width = " + SciTE.Width + "\\n");
SciTE.Trace ("position.height = " + SciTE.Height + "\\n\\n");

//  Get all text with active page
//  Извлекаем весь текст с активной страницы
var all_text = SciTE.GetText;

SciTE.Send ("find:scite");
//  Get only selected text with active page
//  Извлекаем только выделенный текст с активной страницы
var sel_text = SciTE.GetSelText;
SciTE.Trace ("Selected text: \"" + sel_text + "\"\\n");

//  Replace selected on active page text on our
//  Заменяем выделенный на активной странице текст на наш
//~ SciTE.ReplaceSel ("<http://scite.net.ru>");

//  Run command use SciTE Lua Scripting Extension
//  Запускаем LUA команду и получаем результат
var CurrentPos = SciTE.LUA("editor.CurrentPos");
SciTE.Trace ("editor.CurrentPos = " + CurrentPos + "\\n");

//  Задаем ключ в property и его значение
//  Set the value of a property
var value = WScript.FullName;
SciTE.Props("my.key") = WScript.Name;

//  Читаем значение заданного ключа
//  Return the value of a property
var prop = SciTE.Props ("my.key");
SciTE.Trace ("my.key = " + prop + "\\n");

//  Send actions use SciTE Director Interface
//  List of all available commands - in file SciTEDirector.html
//  Посылаем команду используя SciTE Director Interface
//  Список всех доступных команд - в файле SciTEDirector.html
var filename  = SciTE.Send ("askfilename:");
filename = filename.replace(/\\/g,"\\\\");
SciTE.Trace (filename + "\\n");

//  Run internal menu command SciTE (call "About" window)
//  List of all available commands - in file SciTE.h
//  Вызываем внутреннюю команду меню SciTE (окошко "О программе")
//  Список всех доступных команд - в файле SciTE.h
SciTE.MenuCommand (902);

//  Ну как же без этого :)
SciTE.About();

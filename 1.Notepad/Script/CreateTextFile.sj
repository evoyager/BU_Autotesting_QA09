function CreateTextFile()
{  
  var text = "I like to travel";
  var filePath = "C:\\Travel.txt";
  
  TestedApps.notepad.Run();
  //Enter our text
  Aliases.notepad.wndNotepad.Edit.Keys(text);
  Aliases.notepad.wndNotepad.MainMenu.Click("File|Save As...");
  Aliases.notepad.dlgSaveAs.SaveFile(filePath, "Text Documents (*.txt)");
  //Verify text
  aqObject.CompareProperty(Aliases.notepad.wndNotepad.Edit.wText, 0, text, false);
  Aliases.notepad.wndNotepad.Close();  
}

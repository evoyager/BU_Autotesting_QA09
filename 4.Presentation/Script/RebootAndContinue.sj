function RebootAndCont()
{
  aqEnvironment.RebootAndContinue("RebootAndContinue.Calc");
}

function Calc()
{
  var  edit;
  TestedApps.calc.Run();
  edit = Aliases.calc.wndCalculator.Edit;
  edit.Keys("9*9");
  for(i = 0; i < 100; i++)
    edit.Keys("=");
}


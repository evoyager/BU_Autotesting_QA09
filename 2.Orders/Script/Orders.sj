function RunOrders()
{
  TestedApps.Orders.Run();
}

function NewOrders()
{
  var  orders;
  var  orderForm;
  var  groupBox;
  var  textBox;
  var  dateTimePicker;
  
  var rows = 0;
  var mass = new Array();
  var driver = DDT.CSVDriver(Files.FileNameByName("Orders.txt"));
   
  while (!driver.EOF())  
  {
   mass[rows] = driver.Value(0);
   driver.Next();
   rows++;   
  }
   
  DDT.CloseDriver("driver");
   
  orders = Aliases.Orders;  
  
  var name, street, city, zip, creditCard, cardExpirationDate, orderDate;
  name = "Evgeniy Gusar";
  street = "Balzaka"; 
  city = "Kyiv";
  zip = "02097";
  creditCard = "1234567812345678";
  cardExpirationDate = "12/31/2015";
  orderDate = "7/23/2014";
   
  
  //Create 5 orders
  for(i = 0; i<5; i++){
    orders.MainForm.MainMenu.Click("Orders|New order...");
    orderForm = orders.OrderForm;
    groupBox = orderForm.Group;
    //Start iterate product for begining
    if (i>=3)
      groupBox.ProductNames.ClickItem(mass[i-3]);
    else
      groupBox.ProductNames.ClickItem(mass[i]);   
    textBox = groupBox.Customer;
    textBox.wText = name;
    textBox = groupBox.Street;
    textBox.wText = street;
    textBox = groupBox.City;
    textBox.wText = city;
    textBox = groupBox.Zip;
    textBox.wText = zip;
    groupBox.MasterCard.ClickButton();
    textBox = groupBox.CardNo;
    textBox.wText = creditCard;
    dateTimePicker = groupBox.ExpDate;

    dateTimePicker.wDate = cardExpirationDate;
    dateTimePicker = groupBox.Date;

    dateTimePicker.wDate = orderDate;
    orderForm.ButtonOK.ClickButton(); 
    SelectOrder_AndVerifyName(i, name);
  } 
}

function SelectOrder_AndVerifyName(item, verifiedString){
  var orders = Aliases.Orders;   
  var listView = orders.MainForm.OrdersView;
  listView.SelectItem(item);
  if (listView.FocusedItem.Text.OleValue != verifiedString)
    Log.Error("The property value does not equal the baseline value.");
  else 
    Log.message("OK");
}

function EditOrders()
{
  var  orders;
  var  listView;
  var  orderForm;
  var  textBox;
  orders = Aliases.Orders;
  listView = orders.MainForm.OrdersView;
  
  var newName = "EvgeniyGusar";
  
  for(i=0; i<5; i++){
    listView.DblClickItem(i, 0);
    orderForm = orders.OrderForm;
    textBox = orderForm.Group.Customer;
    textBox.wText = newName;
    orderForm.ButtonOK.ClickButton();
    SelectOrder_AndVerifyName(i, newName);
  }
}


function DeleteOrders()
{
  var orders = Aliases.Orders;   
  var listView = orders.MainForm.OrdersView;
  btnYes = orders.dlgConfirmation.btnYes;  
  for(i=0; i<5; i++){
    listView.FocusItem(0);
    listView.Keys("[Del]");
    //Delay(1000);
    btnYes.Keys("[Enter]");
  }
}

function Cleanup()
{
  var  orders;
  orders = Aliases.Orders;
  orders.MainForm.Close();
  Delay(500); 
  orders.dlgConfirmation.btnNo.ClickButton();
}

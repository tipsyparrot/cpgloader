class com.clubpenguin.util.JSONLoader extends com.clubpenguin.util.EventDispatcher
{
   var loadVars;
   static var COMPLETE = "complete";
   static var FAIL = "fail";
   static var CLASS_NAME = "com.clubpenguin.util.JSONLoader";
   var raw = "";
   var data = null;
   function JSONLoader()
   {
      super();
   }
   function load(url)
   {
      this.raw = "";
      this.data = null;
      this.loadVars = new LoadVars();
      this.loadVars.onData = com.clubpenguin.util.Delegate.create(this,this.onData);
      this.loadVars.load(url);
   }
   function onData(jsonText)
   {
      if(jsonText == undefined)
      {
         this.updateListeners(com.clubpenguin.util.JSONLoader.FAIL);
         return undefined;
      }
      try
      {
         this.raw = jsonText;
         this.data = com.clubpenguin.util.JSONParser.parse(jsonText);
         this.updateListeners(com.clubpenguin.util.JSONLoader.COMPLETE);
      }
      catch(ex)
      {
         this.updateListeners(com.clubpenguin.util.JSONLoader.FAIL);
      }
   }
   function toString()
   {
      return "[JSONLoader]";
   }
}

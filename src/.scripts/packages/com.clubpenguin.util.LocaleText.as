class com.clubpenguin.util.LocaleText
{
   static var eventSource;
   static var locale;
   static var localeDataMC;
   static var dataArray;
   static var localeDirectoryURL;
   static var EVENT_LOAD_COMPLETED = "onLoadComplete";
   static var LANG_ID_LOADERROR = 0;
   static var LANG_ID_EN = 1;
   static var LANG_ID_PT = 2;
   static var LANG_ID_FR = 3;
   static var LANG_ID_ES = 4;
   static var LANG_ID_DE = 5;
   static var LANG_ID_RU = 6;
   static var LANG_ID_DEFAULT = com.clubpenguin.util.LocaleText.LANG_ID_EN;
   static var LANG_LOC_FILENAME = "locale";
   static var LANG_LOC_FILETYPE = ".swf";
   static var LANG_LOC_DIRECTORY = "lang";
   static var LANG_LOC_EN = "en";
   static var LANG_LOC_PT = "pt";
   static var LANG_LOC_FR = "fr";
   static var LANG_LOC_ES = "es";
   static var LANG_LOC_DE = "de";
   static var LANG_LOC_RU = "ru";
   static var localeVersion = undefined;
   static var localeID = 0;
   static var ready = false;
   function LocaleText()
   {
   }
   static function init($parent, $languageID, $movieLocation, $versionNumber, $useLoader)
   {
      com.clubpenguin.util.LocaleText.debugTrace("initialise locale text");
      com.clubpenguin.util.LocaleText.ready = false;
      if(com.clubpenguin.util.LocaleText.eventSource == undefined)
      {
         com.clubpenguin.util.LocaleText.eventSource = new Object();
         mx.events.EventDispatcher.initialize(com.clubpenguin.util.LocaleText.eventSource);
      }
      if($useLoader == undefined)
      {
         $useLoader = false;
      }
      console.log("LocaleText.init() : $languageID is: " + $languageID);
      if($languageID == undefined)
      {
         $languageID = com.clubpenguin.util.LocaleText.getLocaleID();
      }
      // override language start:
      var langCodes = {en: 1, pt: 2, fr: 3, es: 4, de: 5, ru: 6};
      $languageID = langCodes[_global.playerLang] || localeID;
      // override language end
      com.clubpenguin.util.LocaleText.localeID = $languageID;
      var fileName = com.clubpenguin.util.LocaleText.getLocale(com.clubpenguin.util.LocaleText.localeID);
      com.clubpenguin.util.LocaleText.locale = com.clubpenguin.util.LocaleText.getLocale(com.clubpenguin.util.LocaleText.localeID);
      if($versionNumber == undefined)
      {
         if(com.clubpenguin.util.LocaleText.localeVersion == undefined)
         {
            fileName = com.clubpenguin.util.LocaleText.LANG_LOC_DIRECTORY + "/" + fileName + "/" + com.clubpenguin.util.LocaleText.LANG_LOC_FILENAME + com.clubpenguin.util.LocaleText.LANG_LOC_FILETYPE;
         }
         else
         {
            fileName = com.clubpenguin.util.LocaleText.LANG_LOC_DIRECTORY + "/" + fileName + "/" + com.clubpenguin.util.LocaleText.LANG_LOC_FILENAME + com.clubpenguin.util.LocaleText.localeVersion + com.clubpenguin.util.LocaleText.LANG_LOC_FILETYPE;
         }
      }
      else
      {
         fileName = com.clubpenguin.util.LocaleText.LANG_LOC_DIRECTORY + "/" + fileName + "/" + com.clubpenguin.util.LocaleText.LANG_LOC_FILENAME + $versionNumber + com.clubpenguin.util.LocaleText.LANG_LOC_FILETYPE;
      }
      com.clubpenguin.util.LocaleText.localeDataMC = $parent.createEmptyMovieClip("localeDataMC",$parent.getNextHighestDepth());
      var loadListener = new Object();
      var loader = new MovieClipLoader();
      if($languageID == com.clubpenguin.util.LocaleText.LANG_ID_LOADERROR)
      {
         loadListener.onLoadError = function($targetMC, $errorMessage)
         {
            com.clubpenguin.util.LocaleText.debugTrace("load error: " + $errorMessage,com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
            com.clubpenguin.util.LocaleText.handleLoadComplete($targetMC);
         };
      }
      else
      {
         loadListener.onLoadError = function($targetMC)
         {
            com.clubpenguin.util.LocaleText.init($targetMC,com.clubpenguin.util.LocaleText.LANG_ID_LOADERROR);
         };
      }
      // @DEBUG vvv
      //filename = "games/" + filename;
      if($movieLocation != undefined)
      {
         fileName = $movieLocation + fileName;
      }
      if($useLoader)
      {
         loadListener.onLoadProgress = function($targetMC, $loadProgress, $loadTotal)
         {
            com.clubpenguin.util.Loader.handleLoadProgress($targetMC,$loadProgress,$loadTotal);
         };
         loadListener.onLoadInit = function($targetMC)
         {
            com.clubpenguin.util.LocaleText.handleLoadComplete($targetMC);
            com.clubpenguin.util.Loader.handleLoadComplete($targetMC);
         };
         com.clubpenguin.util.LocaleText.debugTrace("load filename " + fileName + " using Loader class");
         loader.addListener(loadListener);
         loader.loadClip(fileName,com.clubpenguin.util.LocaleText.localeDataMC);
         com.clubpenguin.util.Loader.addProgressObject(loader.getProgress(com.clubpenguin.util.LocaleText.localeDataMC));
      }
      else
      {
         loadListener.onLoadInit = function($targetMC)
         {
            com.clubpenguin.util.LocaleText.handleLoadComplete($targetMC);
         };
         com.clubpenguin.util.LocaleText.debugTrace("load filename " + fileName + " standalone");
         loader.addListener(loadListener);
         loader.loadClip(fileName,com.clubpenguin.util.LocaleText.localeDataMC);
      }
   }
   static function handleLoadComplete($data)
   {
      com.clubpenguin.util.LocaleText.debugTrace("locale text loaded OK!");
      com.clubpenguin.util.LocaleText.dataArray = new Array();
      for(var i in $data.localeText)
      {
         com.clubpenguin.util.LocaleText.dataArray[$data.localeText[i].id] = $data.localeText[i].value;
         com.clubpenguin.util.LocaleText.debugTrace("dataArray[" + $data.localeText[i].id + "] = " + $data.localeText[i].value);
      }
      var eventObject = new Object();
      eventObject.target = com.clubpenguin.util.LocaleText;
      eventObject.type = com.clubpenguin.util.LocaleText.EVENT_LOAD_COMPLETED;
      com.clubpenguin.util.LocaleText.ready = true;
      com.clubpenguin.util.LocaleText.eventSource.dispatchEvent(eventObject);
      com.clubpenguin.util.LocaleText.debugTrace("dispatched LOAD_COMPLETED event");
   }
   static function addEventListener($listener)
   {
      if(com.clubpenguin.util.LocaleText.eventSource == undefined)
      {
         com.clubpenguin.util.LocaleText.eventSource = new Object();
         mx.events.EventDispatcher.initialize(com.clubpenguin.util.LocaleText.eventSource);
      }
      com.clubpenguin.util.LocaleText.eventSource.addEventListener(com.clubpenguin.util.LocaleText.EVENT_LOAD_COMPLETED,$listener);
   }
   static function removeEventListener($listener)
   {
      com.clubpenguin.util.LocaleText.eventSource.removeEventListener(com.clubpenguin.util.Loader.EVENT_LOAD_COMPLETED,$listener);
   }
   static function getText($stringID)
   {
      if(!com.clubpenguin.util.LocaleText.ready)
      {
         com.clubpenguin.util.LocaleText.debugTrace("getText called when not ready",com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
         return "[id:" + $stringID + " not ready]";
      }
      if(com.clubpenguin.util.LocaleText.dataArray[$stringID] == undefined)
      {
         com.clubpenguin.util.LocaleText.debugTrace("load error for string: " + $stringID,com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
         return "[id:" + $stringID + " undefined]";
      }
      return com.clubpenguin.util.LocaleText.dataArray[$stringID];
   }
   static function localizeField($field, $stringID, $verticalAlign, $minFontSize)
   {
      $field.text = com.clubpenguin.util.LocaleText.getText($stringID);
      com.clubpenguin.text.TextResize.scaleDown($field,$verticalAlign,$minFontSize);
   }
   static function getTextReplaced($stringID, $replacements)
   {
      var tempString = com.clubpenguin.util.LocaleText.getText($stringID);
      var arrayLength = $replacements.length;
      var i = 0;
      while(i < arrayLength)
      {
         tempString = tempString.split("%" + i).join($replacements[i]);
         i++;
      }
      return tempString;
   }
   static function getLocale($localeID)
   {
      switch($localeID)
      {
         case com.clubpenguin.util.LocaleText.LANG_ID_EN:
            return com.clubpenguin.util.LocaleText.LANG_LOC_EN;
         case com.clubpenguin.util.LocaleText.LANG_ID_PT:
            return com.clubpenguin.util.LocaleText.LANG_LOC_PT;
         case com.clubpenguin.util.LocaleText.LANG_ID_FR:
            return com.clubpenguin.util.LocaleText.LANG_LOC_FR;
         case com.clubpenguin.util.LocaleText.LANG_ID_ES:
            return com.clubpenguin.util.LocaleText.LANG_LOC_ES;
         case com.clubpenguin.util.LocaleText.LANG_ID_DE:
            return com.clubpenguin.util.LocaleText.LANG_LOC_DE;
         case com.clubpenguin.util.LocaleText.LANG_ID_RU:
            return com.clubpenguin.util.LocaleText.LANG_LOC_RU;
         case com.clubpenguin.util.LocaleText.LANG_ID_LOADERROR:
            com.clubpenguin.util.LocaleText.debugTrace("load error occurred! reload using default language",com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
            return com.clubpenguin.util.LocaleText.LANG_LOC_EN;
         default:
            com.clubpenguin.util.LocaleText.debugTrace("unknown language id: " + $localeID + ", using default language instead",com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
            return com.clubpenguin.util.LocaleText.LANG_LOC_EN;
      }
   }
   static function setLocaleVersion($localeVersion)
   {
      com.clubpenguin.util.LocaleText.localeVersion = $localeVersion;
   }
   static function setLocaleID($localeID)
   {
      com.clubpenguin.util.LocaleText.localeID = $localeID;
   }
   static function getLocaleID()
   {
      return com.clubpenguin.util.LocaleText.localeID;
   }
   static function isReady()
   {
      return com.clubpenguin.util.LocaleText.ready;
   }
   static function attachLocaleClip($stringID, $target)
   {
      var tempLocaleClip = com.clubpenguin.util.LocaleText.localeDataMC.attachMovie($stringID,$stringID + "_mc",com.clubpenguin.util.LocaleText.localeDataMC.getNextHighestDepth());
      var snapshot = new flash.display.BitmapData(tempLocaleClip._width,tempLocaleClip._height,true,0);
      snapshot.draw(tempLocaleClip,new flash.geom.Matrix(),new flash.geom.ColorTransform(),"normal");
      $target.attachBitmap(snapshot,$target.getNextHighestDepth());
      tempLocaleClip.removeMovieClip();
   }
   static function getGameDirectory($url)
   {
   /*
      if($url == undefined)
      {
         if(com.clubpenguin.util.LocaleText.localeDirectoryURL == undefined)
         {
            com.clubpenguin.util.LocaleText.debugTrace("using cached locale directory url that hasn\'t been set yet!",com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
         }
         return com.clubpenguin.util.LocaleText.localeDirectoryURL;
      }*/



      var locationAsArray = $url.split("/");
      var directory = "";
      var i = 0;
      while(i < locationAsArray.length - 1)
      {
         directory += locationAsArray[i] + "/";
         i++;
      }
      // DEBUGGING START
      if (directory.indexOf("file:///") !== 0) {
         console.log("NOT ABSOLUTE FILE!!!!!!!" + directory);
         console.log("updating game path:");
         directory = _global.exposedGameDir + directory;
         console.log("updated game path: " + directory);
      }
      // DEBUGGING END
      com.clubpenguin.util.LocaleText.localeDirectoryURL = directory;
      console.log("getGameDirectory -> DIRECTORY IS: " + directory);
      return com.clubpenguin.util.LocaleText.localeDirectoryURL;
   }
   static function debugTrace($message, $priority)
   {
   }
}

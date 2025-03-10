package com.clubpenguin.lib.security
{
   import flash.display.DisplayObject;
   import org.osflash.signals.ISignal;
   
   public interface ISecurityHandler
   {
      function doSecurityCheck(param1:DisplayObject) : void;
      
      function getSecurityCheckSuccess() : ISignal;
   }
}


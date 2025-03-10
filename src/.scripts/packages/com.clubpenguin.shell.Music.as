class com.clubpenguin.shell.Music
{
   var container;
   var globalVolume;
   var musicClip;
   var currentURL = "";
   var isMuted = false;
   var isSoundMuted = false;
   function Music(container)
   {
      this.container = container;
      this.globalVolume = new Sound(null);
   }
   function playMusicURL(url)
   {
      if(this.isMuted)
      {
         return false;
      }
      if(url.length)
      {
         this.musicClip = this.container.createEmptyMovieClip("music",0);
         this.currentURL = url;
         this.musicClip.loadMovie(url);
         return true;
      }
      this.stopMusic();
      return false;
   }
   function stopMusic()
   {
      if(!this.currentURL.length)
      {
         return false;
      }
      this.musicClip.removeMovieClip();
      this.currentURL = "";
      return true;
   }
   function muteMusic()
   {
      this.isMuted = true;
      this.stopMusic();
      _global.getCurrentShell().updateListeners(_global.getCurrentShell().UPDATE_MUSIC,null);
      _global.getCurrentShell().sendMuteMusicPlayer();
   }
   function unMuteMusic()
   {
      this.isMuted = false;
      _global.getCurrentShell().updateListeners(_global.getCurrentShell().UPDATE_MUSIC,null);
      _global.getCurrentShell().sendUnmuteMusicPlayer();
   }
   function isMusicMuted()
   {
      return this.isMuted;
   }
   function muteSound()
   {
      this.isSoundMuted = true;
      this.stopSound();
   }
   function stopSound()
   {
      this.globalVolume.setVolume(0);
      return true;
   }
   function unMuteSound()
   {
      this.globalVolume.setVolume(100);
      this.isSoundMuted = false;
   }
   function isAllSoundMuted()
   {
      return this.isSoundMuted;
   }
}

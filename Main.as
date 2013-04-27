package 
{
  import flash.display.Sprite;
	import flash.events.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;

	/**
	 * ...
	 * @author alex
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite 
	{
		private var _game:System;
		//private var _menu:Menu;
		private var _angar:Angar;
		private var _currentScreen:Screen;
		private var back_sound:SoundChannel = new SoundChannel;
		private var _voice:Voice;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_game = new System("Alckevich Alexander");
			//_menu = new Menu;
			_angar = new Angar(0);
			//_voice = new Voice();
			_currentScreen = _angar;
			_currentScreen.addEventListener(StatusEvent.STATUS, gameStatus);
			//_currentScreen.can = _currentScreen.back_music_1.play(0, 100, _currentScreen.tran);
			addChild(_currentScreen);
		}
		
		private function gameStatus(e:StatusEvent):void 
		{
			switch(e.level) {
				case "gotoGame":
					back_sound = _currentScreen.back_music.play(0, 100, _currentScreen.tran);
					_game = new System(_angar.current_name.text);
					_game.sip = _game.sip_list[_angar.main_sip.type-1];
					_game.sip.Container.rotationZ = 0;
					next_screen(_game);
					break;
				/*case "gotoMenu":
					back_sound = _currentScreen.back_music_1.play(0, 100, _currentScreen.tran);
					next_screen(_menu);
					break;*/
				case "gotoAngar":
					//back_sound = _currentScreen.back_music_1.play(0, 100, _currentScreen.tran);
					_angar = new Angar(_angar.main_sip.type);
					next_screen(_angar);
					break;
				default:break;
			}
		}
		private function next_screen(screen:Screen):void {
			_currentScreen.can.stop();
			removeChild(_currentScreen);
			_currentScreen.removeEventListener(StatusEvent.STATUS, gameStatus);
			
			_currentScreen = screen;
			_currentScreen.can = back_sound;
			_currentScreen..addEventListener(StatusEvent.STATUS, gameStatus);
			addChild(screen);
		}

	}

}

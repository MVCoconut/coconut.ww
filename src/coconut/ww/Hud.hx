package coconut.ww;

/**
 * A super-posed hud that fills its [containing block](https://developer.mozilla.org/en-US/docs/Web/CSS/All_About_The_Containing_Block).
 * 
 */
class Hud extends View {

  static final ROOT = css('
    position: absolute;
    pointer-events: none;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
    &>* {
      pointer-events: auto;
    }    
  ');

  @:attribute var className:ClassName = null;
  @:attribute var children:Children;

  function render() '
    <div class=${ROOT.add(className)}>
      ${...children}
    </div>
  ';
}
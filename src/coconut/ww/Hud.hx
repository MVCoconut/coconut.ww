package coconut.ww;

/**
 * A super-posed hud that fills its [containing block](https://developer.mozilla.org/en-US/docs/Web/CSS/All_About_The_Containing_Block).
 * 
 */
@:less("hud.less")
class Hud extends View {
  @:attribute var className:ClassName = null;
  @:attribute var children:Children;
  function render() '
    <div class={className.add("cc-hud")}>
      {...children}
    </div>
  ';
}
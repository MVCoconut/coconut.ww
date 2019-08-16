package coconut.ww;


class Stack extends View {
  static final ROOT = css('
    position: relative;
    &>* {
      position: absolute;
      pointer-events: none;
      top: 0;
      bottom: 0;
      left: 0;
      right: 0;
      &>* {
        pointer-events: auto;
      }
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
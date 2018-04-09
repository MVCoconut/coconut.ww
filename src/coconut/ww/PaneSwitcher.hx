package coconut.ww;

@:less("pane-switcher.less")
class PaneSwitcher extends View {

  @:attribute var className:ClassName = null;
  @:attribute var children:Children;
  @:attribute var selectedIndex:Int = -1;
  @:attribute var wraparound:Bool = false;
  
  @:attribute function onselect(index:Int);
  
  @:state var position:Float = Math.NaN;
  @:state var _ownIndex:Int = 0;
  @:state var dragging:Bool = false;

  @:computed var index:Int = switch selectedIndex {
    case -1: _ownIndex;
    case v: v;
  }

  function doSelect(index:Int) {
    this._ownIndex = index;
    onselect(index);
  }

  function render() {
    if (Math.isNaN(position))
      position = index;
    var count = children.length;
    
    var wrappedPos = position % count;

    if (wrappedPos <= -count) 
      wrappedPos += count;

    var min = Math.ceil(wrappedPos - 1),
        max = Math.floor(wrappedPos + 1);

    var wrap = 
      if (wraparound) function (f) return f;
      else function (f) return f;

    if (!dragging && position != index) 
      @in(.0) @do {  
        position = 
          if (Math.abs(position - index) < .01) index;
          else (4 * position + index) / 5;
      }

    inline function style(pos:Int):Style 
      return 
        if (Math.abs(pos - wrappedPos) <= 1)
          { transform: 'translateX(${100 * (pos - wrappedPos)}%)' }
        else
          { visibility: 'hidden' }

    return @hxx'
      <div class=${className.add("cc-pane-switcher")}>
        <ol onmousedown={startDrag()}>
          <for ${pos in 0...children.length}>
            <switch ${children[pos]}>
              <case ${c}>
                <li 
                    key=${pos} 
                    style=${style(pos)}
                  >
                  ${c}
                </li>
            </switch>
          </for>
        </ol>
      </div>
    ';
  }

  function startDrag() {

  }
}
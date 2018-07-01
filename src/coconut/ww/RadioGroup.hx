package coconut.ww;

private typedef Radio<Value> = {
  final value:Value;
  final children:Children;
}

class RadioGroup<Value> extends View {
  
  @:attribute var className:ClassName = null;
  @:attribute var selected:Value;
  @:attribute function onselect(value:Value):Void;
  @:attribute var options:{ radio: Radio<Value>->Radio<Value> }->Array<Radio<Value>>;//TODO: this should work if declared as `children`
  
  function render() '
    <div class=${className.add("cc-radio-group")}>
      <for ${o in options({ radio: r -> r })}>
        <label>
          <input type="radio" checked=${o.value == selected} onchange=${onselect(o.value)} />
          ${...o.children}
        </label>
      </for>
    </div>
  ';

  static function identity<X>(x:X):X return x;
}
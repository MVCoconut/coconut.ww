package coconut.ww;

class Checkbox extends View {
  @:attribute var className:ClassName = null;
  @:attribute var name:String = null;
  @:attribute var checked:Bool = false;
  @:attribute var children:Children;
  @:attribute function ontoggle(checked:Bool):Void;

  function render() '
    <label class=${className.add("cc-checkbox")}>
      <input type="checkbox" name={name} checked={checked} onchange={ontoggle(event.target.checked)} />
      {...children}
    </label>
  ';
}
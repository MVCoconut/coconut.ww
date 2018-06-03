package coconut.ww;

@:less('stack.less')
class Stack extends View {
  @:attribute var className:ClassName = null;
  @:attribute var children:Children;
  function render() '
    <div class={className.add("stack")}>
      {...children}
    </div>
  ';
}
package coconut.ww._internal;

@:fromHxx(transform = coconut.ww._internal.StyleProvider.interpretAttr(_))
abstract StyleProvider<T>(T->ClassName) from T->ClassName {
  public inline function getClass(value:T)
    return switch this {
      case null: null;
      case fn: fn(value);
    }

  static public function interpretAttr<T>(?c:ClassName, ?s:StyleProvider<T>)
    return 
      if (c == null) s;
      else ofClassName(c);

  @:from static inline function ofString<T>(s:String):StyleProvider<T> 
    return ofClassName(s);

  @:from static inline function ofClassName<T>(c:ClassName):StyleProvider<T> 
    return _ -> c;
}

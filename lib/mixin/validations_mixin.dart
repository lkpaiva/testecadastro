mixin ValidationsMixin{
  String? isNotEmpty(String? value, [String? message]){
    if(value! == null || value!.isEmpty){
      return message ?? "Este campo é obrigatório";
    }
    else {
      return null;
    }
  }
}
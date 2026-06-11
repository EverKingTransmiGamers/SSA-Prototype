class_name PlayerAnimNames extends Resource

# Los datos de tipo StringNames son nombres de referencia
# que se utilizan para que los nodos que accedan a el
# lo hagan mas rapido por memoria.

#region Nombres de las animaciones de las acciones generales
const Quieto:StringName = &"Quieto"
const Acelerando:StringName = &"Acelerando"
const FrenandoAcel:StringName = &"FrenandoAcel"
const Corriendo:StringName = &"Corriendo"
const FrenandoCorri:StringName = &"FrenandoCorri"
#endregion

#region Nombres de las animaciones que se realizaran si estas quieto en el sitio
const SaltandoQuieto:StringName = &"SaltandoQuieto"
const PreCayendoQuieto:StringName = &"PreCayendoQuieto"
const CayendoQuieto:StringName = "CayendoQuieto"
const AterrizQuieto:StringName = "AterrizQuieto"
const AterrizCorrer:StringName = "AterrizCorrer"
#endregion

#region Nombres de las animaciones que se realizaran si estas corriendo
const SaltandoCorri:StringName = "SaltandoCorri"
const PreCaidaCorri:StringName = "PreCaidaCorri"
const CaidaCorri:StringName = "CaidaCorri"
const AterrizCorri:StringName = "AterrizCorri"
const AterrizParando:StringName = "AterrizParando"
#endregion

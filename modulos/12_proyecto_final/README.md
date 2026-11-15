# 12 · Proyecto final: pedidos de El Comal Alegre

Llegó la hora de juntar todo. Vas a armar la app de pedidos de una pupusería: el cliente ve el menú, suma y resta pupusas y bebidas, revisa su pedido con el ISV y una promoción, deja su nombre y teléfono y confirma. Es pequeña, pero tiene lo mismo que una app de verdad: modelo con reglas de negocio, estado compartido entre pantallas, navegación, formulario con validación y tests de principio a fin.

El Comal Alegre es un negocio inventado para este curso. Los precios están en lempiras y son de ejemplo.

## Qué usa de cada módulo

| Módulo | Dónde aparece |
|---|---|
| 01 a 03 | El modelo `Producto`, los montos, `switch` y clases |
| 02 | `lineas`, `fold` y `where` para calcular totales |
| 04 y 05 | Las tres pantallas, `ListTile`, `Row`, `Badge` |
| 06 | `Pedido` es un `ChangeNotifier`; el menú y el contador lo escuchan con `ListenableBuilder` |
| 07 | `push` al pedido, `pushReplacement` a la confirmación y `pop` de vuelta al menú |
| 08 | El formulario de nombre y teléfono |
| 11 | Todo se prueba sin teléfono, con la lógica separada de las pantallas |

## Los archivos

```
modulos/12_proyecto_final/
├── modelos.dart     listo: Producto, el menú, lempiras(), redondear() y las constantes del negocio
├── pedido.dart      te toca: la clase Pedido con todas las reglas
├── pantallas.dart   te toca: menú, pedido y confirmación (AppPupuseria ya está lista)
└── main.dart        listo: arranca la app
```

## Las reglas del negocio

1. Agregar suma una unidad; quitar resta una. Si llega a cero, el producto sale del pedido.
2. Las líneas del pedido van en el orden en que se agregó cada producto por primera vez.
3. Promoción de la casa: con 12 pupusas o más en el pedido (sumando todos los sabores, sin contar bebidas), 10 % de descuento sobre lo que suman las pupusas.
4. El ISV es el 15 % de lo que queda después del descuento.
5. Cada monto se redondea a centavos.

Un caso para que lo calculés a mano antes de programar: 12 revueltas (L 25 cada una). Subtotal L 300.00, descuento L 30.00, ISV de L 270.00 que da L 40.50, total L 310.50. Si tu cuenta no da eso, todavía no entendiste la regla, y el código tampoco la va a entender.

## Cómo avanzar

No lo hagás todo de un solo. Este orden funciona:

1. `pedido.dart`, primero. Corré solo el grupo del pedido hasta que pase:

   ```
   flutter test test/m12_proyecto_final_test.dart --plain-name "Pedido"
   ```

2. `PantallaConfirmacion`, que es la más simple.
3. `PantallaMenu`. Fijate bien en las `Key` que pide el comentario de la clase; los tests tocan los botones por su key.
4. `PantallaPedido`, con el formulario.
5. Todo el módulo:

   ```
   flutter test test/m12_proyecto_final_test.dart
   ```

6. Mirala en pantalla:

   ```
   flutter run -t modulos/12_proyecto_final/main.dart
   ```

Cuando un test de widget falle, leé el mensaje completo: dice qué buscó y qué encontró. Si dice que no encontró una key, revisá que la escribiste igual que en la especificación.

## Decisiones de diseño, explicadas

1. ¿Por qué el pedido guarda ids y cantidades y no una lista de productos repetidos? Con `{'revuelta': 3}` la cantidad sale directo y quitar uno es restar. Con una lista habría que contar cada vez.
2. ¿Por qué `AppPupuseria` recibe un `Pedido` opcional? Para que los tests manden el suyo y puedan revisarlo desde afuera. La app real no manda nada y se crea uno. Es la misma inyección que usaste con el reloj y el cliente HTTP.
3. ¿Por qué se guarda el total antes de vaciar el pedido? Porque después de vaciar, el total es cero. El orden de las líneas importa.
4. ¿Por qué `pushReplacement` para la confirmación? Para que la flecha no regrese a un formulario de un pedido que ya se mandó. "Hacer otro pedido" hace `pop` y, como el pedido quedó en medio reemplazado, cae directo en el menú.

## Errores comunes

1. Calcular el descuento sobre todo el subtotal. Es solo sobre las pupusas.
2. Contar las bebidas para la promoción.
3. Redondear solo al final y que un centavo no cuadre con el test. Redondeá cada monto como dice la regla 5.
4. No usar `ListenableBuilder` en el menú. Tocás "+" y la cantidad no cambia en pantalla, aunque el pedido sí cambió.
5. Leer `pedido.total` después de `vaciar()`.
6. Escribir mal una key: `agregar_Revuelta` en vez de `agregar_revuelta`.

## Para ir más allá

Ya con todo en verde, estas mejoras son buenas para practicar y para tu portafolio. No tienen tests; escribí los tuyos.

1. Guardar el pedido en curso con el `Almacen` del módulo 10, para que no se pierda si la app se cierra.
2. Bajar el menú de un servidor con el `ServicioMenu` del módulo 09 y un cliente falso en los tests.
3. Notas por línea ("sin curtido", "bien tostadita").
4. Un selector de sucursal antes del menú.
5. Pantalla ancha: menú y pedido lado a lado con `LayoutBuilder` (módulo 05).
6. Modo oscuro con un `ValueNotifier` (módulo 06).

Si hacés una de estas, abrí un pull request en tu copia y mirá el check. Contanos en la comunidad: es la mejor forma de que alguien más aprenda de lo que hiciste.

## Repaso

1. ¿Qué partes de la app probaste sin dibujar nada? ¿Por qué eso es bueno?
2. Si mañana cambia el ISV, ¿cuántos archivos tenés que tocar?
3. ¿Qué pasaría si `PantallaMenu` no escuchara al pedido?
4. ¿Por qué la confirmación no tiene flecha de volver?
5. ¿Qué cambiarías si el menú tuviera 300 productos?

Solución en [`soluciones/12_proyecto_final`](../../soluciones/12_proyecto_final/). Miralo solo después de intentarlo en serio: es una forma de hacerlo, no la única.

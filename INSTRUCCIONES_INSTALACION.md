# 🚀 GUÍA RÁPIDA DE INSTALACIÓN - MACROCELL

Sigue estos pasos **EN ORDEN** para poner en marcha el proyecto.

---

## ⚡ PASO 1: Instalar Nuevas Dependencias

Abre la terminal en la raíz del proyecto y ejecuta:

```bash
npm install bcryptjs dotenv express-validator jsonwebtoken
```

Esto instalará los paquetes necesarios para seguridad.

---

## 🗄️ PASO 2: Arreglar Base de Datos

1. **Abre MySQL Workbench** o tu cliente MySQL favorito

2. **Ejecuta el script** `fix_database.sql` completo

   O desde terminal:
   ```bash
   mysql -u root -p proyecto_macrocell < fix_database.sql
   ```

3. **Verifica** que la tabla carrito se creó correctamente:
   ```sql
   USE proyecto_macrocell;
   DESCRIBE carrito;
   ```

   Deberías ver:
   ```
   +----------------+-------------+
   | Field          | Type        |
   +----------------+-------------+
   | id             | int(11)     |
   | id_cliente     | int(11)     |
   | id_producto    | int(11)     |
   | cantidad       | int(11)     |
   | fecha_agregado | timestamp   |
   +----------------+-------------+
   ```

---

## 🔐 PASO 3: Crear Archivo .env

1. **Crea** un archivo llamado `.env` en la raíz del proyecto (junto a package.json)

2. **Copia** el contenido del artifact ".env (archivo de configuración)"

3. **Modifica** solo estas líneas con tus datos:
   ```env
   DB_PASSWORD=tu_contraseña_de_mysql
   JWT_SECRET=clave_secreta_muy_larga_y_aleatoria
   ```

---

## 🧹 PASO 4: Limpiar Archivos Viejos

**Elimina estos archivos/carpetas que ya no sirven:**

1. `login.js` (archivo suelto en la raíz)
2. `node-v22.21.0-x64/` (carpeta de Node.js portable)

```bash
# En la raíz del proyecto
rm login.js
rm -rf node-v22.21.0-x64
```

---

## 🔧 PASO 5: Reemplazar Archivos del Backend

Reemplaza estos archivos con las versiones corregidas:

1. **backend/db.js** → Usa el artifact "backend/db.js (corregido)"
2. **backend/server.js** → Usa el artifact "backend/server.js (corregido)"
3. **backend/controllers/carritoController.js** → Usa el artifact corregido

---

## 📝 PASO 6: Crear Archivos Nuevos

Crea estos archivos nuevos en la raíz:

1. **.gitignore** → Copia del artifact
2. **README.md** → Copia del artifact

---

## ▶️ PASO 7: Iniciar el Proyecto

```bash
npm run dev
```

Deberías ver:

```
==================================================
🚀 Servidor corriendo en http://localhost:3000
📁 Sirviendo archivos desde: .../frontend
🌍 Entorno: development
==================================================
✅ Conexión exitosa a la base de datos MySQL
📊 Base de datos: proyecto_macrocell
```

---

## ✅ PASO 8: Verificar que Funciona

### Prueba 1: Abrir la página principal
```
http://localhost:3000
```

### Prueba 2: Login como Admin
```
Usuario: admin
Contraseña: 2801
```

### Prueba 3: Login como Empleado
```
Correo: laura.gomez@macrocell.com
Contraseña: pass123
```

### Prueba 4: Probar el carrito
1. Ve a la página principal
2. Agrega un producto al carrito
3. Ve a `http://localhost:3000/carrito.html`
4. Verifica que el producto aparezca

---

## 🐛 Solución de Problemas

### Error: "Cannot find module 'dotenv'"
```bash
npm install
```

### Error: "EADDRINUSE"
El puerto 3000 está ocupado. Cambia el puerto en `.env`:
```env
PORT=3001
```

### Error de conexión MySQL
1. Verifica que MySQL esté corriendo
2. Confirma usuario/contraseña en `.env`
3. Verifica que la base de datos exista:
   ```sql
   SHOW DATABASES LIKE 'proyecto_macrocell';
   ```

### La tabla carrito sigue con error
Ejecuta esto en MySQL:
```sql
USE proyecto_macrocell;
DROP TABLE IF EXISTS carrito;
-- Luego ejecuta de nuevo el CREATE TABLE del fix_database.sql
```

---

## 📊 Verificar que la DB está correcta

Ejecuta esto en MySQL:

```sql
USE proyecto_macrocell;

-- Ver todas las tablas
SHOW TABLES;

-- Debería mostrar 11 tablas:
-- administrador, carrito, cliente, empleados, pedido, 
-- producto, proveedor, servicio_tecnico, soporte, 
-- venta, venta_producto

-- Verificar estructura del carrito
DESCRIBE carrito;

-- Probar inserción en carrito
INSERT INTO carrito (id_cliente, id_producto, cantidad) VALUES (1, 1, 2);
SELECT * FROM carrito;
```

---

## 🎉 ¡Listo!

Si todo funcionó, tu proyecto Macrocell está completamente operativo.

### Próximos pasos recomendados:

1. **Seguridad:** Implementar hash de contraseñas
2. **JWT:** Agregar tokens de autenticación
3. **Validaciones:** Usar express-validator
4. **Testing:** Agregar pruebas unitarias

---

## 📞 ¿Necesitas ayuda?

Si algo no funciona:

1. Revisa los logs del servidor (terminal)
2. Revisa la consola del navegador (F12)
3. Verifica que todos los pasos se siguieron en orden
4. Compara tu código con los artifacts proporcionados

---

**¡Éxito con tu proyecto!** 🚀
# 📱 Sistema de Gestión Macrocell

Sistema completo de gestión para tienda de tecnología con manejo de productos, ventas, servicios técnicos y carrito de compras.

---

## 🚀 Características

- ✅ Gestión de productos y proveedores
- ✅ Control de inventario en tiempo real
- ✅ Sistema de ventas con facturación
- ✅ Servicio técnico y reparaciones
- ✅ Carrito de compras integrado
- ✅ Panel de administración completo
- ✅ Panel de empleados
- ✅ Reportes y estadísticas
- ✅ Sistema de soporte al cliente

---

## 📋 Requisitos Previos

Antes de instalar, asegúrate de tener:

- **Node.js** v14 o superior
- **MySQL** v5.7 o superior (o MariaDB 10.4+)
- **npm** v6 o superior

---

## 🔧 Instalación

### 1️⃣ Clonar el repositorio

```bash
git clone [URL_DEL_REPOSITORIO]
cd proyecto-macrocell
```

### 2️⃣ Instalar dependencias

```bash
npm install
```

### 3️⃣ Configurar base de datos

**a) Crear la base de datos:**

```bash
mysql -u root -p
```

```sql
CREATE DATABASE proyecto_macrocell;
```

**b) Importar el esquema:**

```bash
mysql -u root -p proyecto_macrocell < fix_database.sql
```

**c) Importar datos de ejemplo (opcional):**

```bash
mysql -u root -p proyecto_macrocell < proyecto_macrocell_*.sql
```

### 4️⃣ Configurar variables de entorno

Crea un archivo `.env` en la raíz del proyecto:

```bash
cp .env.example .env
```

Edita el archivo `.env` con tus credenciales:

```env
PORT=3000
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=tu_contraseña
DB_NAME=proyecto_macrocell
```

### 5️⃣ Iniciar el servidor

**Modo desarrollo:**
```bash
npm run dev
```

**Modo producción:**
```bash
npm start
```

El servidor estará disponible en: `http://localhost:3000`

---

## 📁 Estructura del Proyecto

```
proyecto-macrocell/
├── backend/
│   ├── controllers/          # Lógica de negocio
│   │   ├── carritoController.js
│   │   ├── clienteController.js
│   │   ├── productoController.js
│   │   ├── proveedorController.js
│   │   ├── servicioTecnicoController.js
│   │   └── ventaController.js
│   ├── routes/               # Definición de rutas
│   │   ├── carritoRoutes.js
│   │   ├── clienteRoutes.js
│   │   ├── productoRoutes.js
│   │   ├── proveedorRoutes.js
│   │   ├── servicioTecnicoRoutes.js
│   │   └── ventaRoutes.js
│   ├── db.js                 # Conexión a BD
│   └── server.js             # Servidor principal
├── frontend/
│   ├── js/                   # Scripts del frontend
│   ├── Imagenes/             # Imágenes del sitio
│   ├── admin.html            # Panel administrador
│   ├── empleado.html         # Panel empleado
│   ├── index.html            # Página principal
│   ├── login.html            # Inicio de sesión
│   ├── carrito.html          # Carrito de compras
│   └── ...
├── .env                      # Variables de entorno
├── .gitignore
├── package.json
└── README.md
```

---

## 🔐 Usuarios de Prueba

### Administrador
- **Usuario:** `admin`
- **Contraseña:** `2801`

### Empleado
- **Correo:** `laura.gomez@macrocell.com`
- **Contraseña:** `pass123`

---

## 🌐 API Endpoints

### Productos
- `GET /api/productos` - Obtener todos los productos
- `POST /api/productos` - Crear producto
- `PUT /api/productos/:id` - Actualizar producto
- `DELETE /api/productos/:id` - Eliminar producto

### Carrito
- `GET /api/carrito/:id_cliente` - Obtener carrito del cliente
- `POST /api/carrito` - Agregar al carrito
- `DELETE /api/carrito/:id` - Eliminar item del carrito

### Ventas
- `GET /api/ventas` - Obtener todas las ventas
- `POST /api/ventas` - Registrar venta
- `GET /api/ventas/:id/detalle` - Detalle de venta

### Servicios Técnicos
- `GET /api/servicios` - Obtener servicios
- `POST /api/servicios` - Registrar servicio
- `PUT /api/servicios/:id` - Actualizar servicio

### Clientes
- `GET /api/clientes` - Obtener clientes
- `POST /api/clientes` - Registrar cliente
- `PUT /api/clientes/:id` - Actualizar cliente

### Proveedores
- `GET /api/proveedores` - Obtener proveedores
- `POST /api/proveedores` - Registrar proveedor
- `PUT /api/proveedores/:id` - Actualizar proveedor

---

## 🗄️ Esquema de Base de Datos

### Tablas Principales

- **administrador** - Usuarios administradores
- **empleados** - Empleados del sistema
- **cliente** - Clientes registrados
- **producto** - Catálogo de productos
- **proveedor** - Proveedores
- **carrito** - Carrito de compras
- **venta** - Ventas realizadas
- **venta_producto** - Detalle de productos por venta
- **servicio_tecnico** - Servicios técnicos
- **soporte** - Mensajes de soporte
- **pedido** - Pedidos de clientes

---

## 🛠️ Tecnologías Utilizadas

### Backend
- **Node.js** - Entorno de ejecución
- **Express.js** - Framework web
- **MySQL2** - Cliente de base de datos
- **dotenv** - Variables de entorno
- **CORS** - Control de acceso

### Frontend
- **HTML5** - Estructura
- **CSS3** - Estilos
- **JavaScript** - Interactividad
- **Fetch API** - Llamadas al backend

---

## 📊 Características Adicionales

### Panel de Administración
- Gestión completa de productos
- Control de inventario
- Gestión de ventas
- Reportes de productos más vendidos
- Administración de servicios técnicos

### Panel de Empleados
- Registro de servicios técnicos
- Consulta de servicios
- Actualización de estados

### Tienda Online
- Catálogo de productos
- Carrito de compras persistente
- Sistema de pedidos
- Formulario de soporte

---

## 🐛 Solución de Problemas

### Error de conexión a la base de datos

```
❌ Error al conectar con la base de datos
```

**Solución:**
1. Verifica que MySQL esté corriendo
2. Confirma las credenciales en `.env`
3. Asegúrate de que la base de datos existe

### Puerto en uso

```
Error: listen EADDRINUSE: address already in use :::3000
```

**Solución:**
1. Cambia el puerto en `.env`
2. O cierra la aplicación que usa el puerto 3000

### Módulos no encontrados

```
Error: Cannot find module 'express'
```

**Solución:**
```bash
npm install
```

---

## 📈 Próximas Mejoras

- [ ] Autenticación con JWT
- [ ] Hash de contraseñas con bcrypt
- [ ] Sistema de roles más robusto
- [ ] Paginación en listados
- [ ] Búsqueda avanzada
- [ ] Exportación de reportes (PDF/Excel)
- [ ] Notificaciones en tiempo real
- [ ] Imágenes de productos
- [ ] Sistema de descuentos
- [ ] Integración con pasarelas de pago

---

## 👥 Contribuciones

Las contribuciones son bienvenidas. Por favor:

1. Haz un Fork del proyecto
2. Crea una rama para tu feature (`git checkout -b feature/nueva-funcionalidad`)
3. Commit tus cambios (`git commit -am 'Agregar nueva funcionalidad'`)
4. Push a la rama (`git push origin feature/nueva-funcionalidad`)
5. Abre un Pull Request

---

## 📞 Contacto

**Macrocell**
- 📧 Email: macrocellcomunicaciones@gmail.com
- 📱 Teléfono: (+57) 350 6332077 - 304 4066680
- 📍 Ubicación: Villavicencio, Meta - Colombia

---

## 📝 Licencia

Este proyecto es de uso educativo y pertenece a Macrocell.

---

## 🙏 Agradecimientos

Gracias a todos los que han contribuido al desarrollo de este sistema.

---

**Versión:** 1.0.0  
**Última actualización:** 2025-11-05
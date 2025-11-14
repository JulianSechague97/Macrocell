import express from "express";
import cors from "cors";
import dotenv from "dotenv";
import { conexion } from "./db.js";
import path from "path";
import { fileURLToPath } from "url";
import empleadoRoutes from './routes/empleadoRoutes.js';

// Cargar variables de entorno
dotenv.config();

// Importar rutas
import productoRoutes from "./routes/productoRoutes.js";
import proveedorRoutes from "./routes/proveedorRoutes.js";
import clienteRoutes from "./routes/clienteRoutes.js";
import ventaRoutes from "./routes/ventaRoutes.js";
import servicioTecnicoRoutes from "./routes/servicioTecnicoRoutes.js";
import carritoRoutes from "./routes/carritoRoutes.js";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();

// ============================================
// MIDDLEWARES
// ============================================
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Logging middleware (desarrollo)
if (process.env.NODE_ENV === 'development') {
  app.use((req, res, next) => {
    console.log(`${req.method} ${req.path}`);
    next();
  });
}

// ============================================
// SERVIR FRONTEND
// ============================================
app.use(express.static(path.join(__dirname, "../frontend")));
app.use("/Imagenes", express.static(path.join(__dirname, "../frontend/Imagenes")));

// ============================================
// RUTAS DE LA API
// ============================================
app.use("/api/productos", productoRoutes);
app.use("/api/proveedores", proveedorRoutes);
app.use("/api/clientes", clienteRoutes);
app.use("/api/empleados", empleadoRoutes);
app.use("/api/ventas", ventaRoutes);
app.use("/api/servicios", servicioTecnicoRoutes);
app.use("/api/carrito", carritoRoutes);  // ✅ SOLO UNA VEZ

// ============================================
// LOGIN EMPLEADOS
// ============================================
app.post("/loginEmpleado", (req, res) => {
  // aceptar en el mismo campo: correo o nombre o cédula
  const { correo, contrasena } = req.body;

  if (!correo || !contrasena) {
    return res.status(400).json({ 
      success: false, 
      message: "Correo/usuario y contraseña son requeridos" 
    });
  }

  const identifier = correo;
  // Intentamos primero buscar por una columna 'Usuario' (si existe) o por Correo
  const tryUsuarioQuery = "SELECT * FROM empleados WHERE (Correo = ? OR Usuario = ?) AND Contrasena_acceso = ?";

  conexion.query(tryUsuarioQuery, [identifier, identifier, contrasena], (error, results) => {
    if (error) {
      // Si falla por campo no existente (Usuario), hacemos fallback a buscar por Correo
      if (error.code === 'ER_BAD_FIELD_ERROR') {
        const fallbackQuery = "SELECT * FROM empleados WHERE Correo = ? AND Contrasena_acceso = ?";
        return conexion.query(fallbackQuery, [identifier, contrasena], (err2, results2) => {
          if (err2) {
            console.error("Error en login empleado (fallback):", err2);
            return res.status(500).json({ success: false, message: "Error en el servidor" });
          }
          if (results2.length > 0) {
            const { Contrasena_acceso, ...usuario } = results2[0];
            const tipoUsuario = usuario.rol || 'empleado';
            return res.json({ success: true, tipo: tipoUsuario, usuario });
          }
          return res.json({ success: false, message: "Credenciales incorrectas" });
        });
      }

      console.error("Error en login empleado:", error);
      return res.status(500).json({ success: false, message: "Error en el servidor" });
    }

    if (results.length > 0) {
      const { Contrasena_acceso, ...usuario } = results[0];
      const tipoUsuario = usuario.rol || 'empleado';
      return res.json({ success: true, tipo: tipoUsuario, usuario });
    }

    // Si no encontramos, devolver credenciales incorrectas
    return res.json({ success: false, message: "Credenciales incorrectas" });
  });
});

// ============================================
// LOGIN ADMINISTRADOR
// ============================================
app.post("/loginAdmin", (req, res) => {
  const { usuario, contrasena } = req.body;
  
  if (!usuario || !contrasena) {
    return res.status(400).json({ 
      success: false, 
      message: "Usuario y contraseña son requeridos" 
    });
  }

  const query = "SELECT * FROM administrador WHERE usuario = ? AND contrasena = ?";

  conexion.query(query, [usuario, contrasena], (error, results) => {
    if (error) {
      console.error("Error en login admin:", error);
      return res.status(500).json({ 
        success: false, 
        message: "Error en el servidor" 
      });
    }
    
    if (results.length > 0) {
      res.json({ 
        success: true, 
        tipo: "admin" 
      });
    } else {
      res.json({ 
        success: false, 
        message: "Usuario o contraseña incorrectos" 
      });
    }
  });
});

// ============================================
// SOPORTE
// ============================================
app.post("/api/soporte", (req, res) => {
  const { nombre, correo, mensaje } = req.body;
  
  if (!nombre || !correo || !mensaje) {
    return res.status(400).json({ 
      mensaje: "Todos los campos son requeridos" 
    });
  }

  const sql = "INSERT INTO soporte (Nombre, Correo, Mensaje) VALUES (?, ?, ?)";
  
  conexion.query(sql, [nombre, correo, mensaje], (err) => {
    if (err) {
      console.error("Error al guardar soporte:", err);
      return res.status(500).json({ 
        mensaje: "Error al guardar el mensaje" 
      });
    }
    res.json({ 
      mensaje: "Mensaje enviado correctamente" 
    });
  });
});

// ============================================
// PEDIDOS
// ============================================
app.post("/api/pedidos", (req, res) => {
  const { cliente, producto, cantidad, direccion } = req.body;
  
  if (!producto || !cantidad || !direccion) {
    return res.status(400).json({ 
      mensaje: "Producto, cantidad y dirección son requeridos" 
    });
  }

  const sql = "INSERT INTO pedido (ID_cliente, Producto, Cantidad, Direccion) VALUES (?, ?, ?, ?)";
  
  conexion.query(sql, [cliente || null, producto, cantidad, direccion], (err) => {
    if (err) {
      console.error("Error al registrar pedido:", err);
      return res.status(500).json({ 
        mensaje: "Error al registrar el pedido" 
      });
    }
    res.json({ 
      mensaje: "Pedido registrado correctamente" 
    });
  });
});

// ============================================
// TOP 5 PRODUCTOS MÁS VENDIDOS
// ============================================
app.get("/top5", (req, res) => {
  const query = `
    SELECT 
      p.ID_producto,
      p.Nombre,
      p.Precio_venta,
      p.Stock_actual,
      COALESCE(SUM(vp.Cantidad), 0) AS total_vendido
    FROM producto p
    LEFT JOIN venta_producto vp ON p.ID_producto = vp.ID_producto
    GROUP BY p.ID_producto, p.Nombre, p.Precio_venta, p.Stock_actual
    HAVING total_vendido > 0
    ORDER BY total_vendido DESC
    LIMIT 5;
  `;

  conexion.query(query, (err, results) => {
    if (err) {
      console.error("Error al obtener top 5:", err);
      return res.status(500).json({ 
        success: false, 
        error: err.message 
      });
    }
    res.json(results);
  });
});

// ============================================
// RUTA CATCH-ALL (debe ir al final)
// ============================================
app.get("*", (req, res) => {
  res.sendFile(path.join(__dirname, "../frontend/index.html"));
});

// ============================================
// MANEJO DE ERRORES GLOBAL
// ============================================
app.use((err, req, res, next) => {
  console.error("❌ Error no manejado:", err);
  res.status(500).json({ 
    error: "Error interno del servidor",
    message: process.env.NODE_ENV === 'development' ? err.message : undefined
  });
});

// ============================================
// INICIAR SERVIDOR
// ============================================
const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log("=".repeat(50));
  console.log(`🚀 Servidor corriendo en http://localhost:${PORT}`);
  console.log(`📁 Sirviendo archivos desde: ${path.join(__dirname, "../frontend")}`);
  console.log(`🌍 Entorno: ${process.env.NODE_ENV || 'development'}`);
  console.log("=".repeat(50));
});

// Manejo de cierre graceful
process.on('SIGINT', () => {
  console.log("\n⏸️  Cerrando conexión a la base de datos...");
  conexion.end((err) => {
    if (err) {
      console.error("Error al cerrar conexión:", err);
    } else {
      console.log("✅ Conexión cerrada correctamente");
    }
    process.exit(0);
  });
});
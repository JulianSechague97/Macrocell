import express from "express";
import cors from "cors";
import { conexion } from "./db.js";
import path from "path";
import { fileURLToPath } from "url";

import productoRoutes from "./routes/productoRoutes.js";
import proveedorRoutes from "./routes/proveedorRoutes.js";
import clienteRoutes from "./routes/clienteRoutes.js";
import ventaRoutes from "./routes/ventaRoutes.js";
import servicioTecnicoRoutes from "./routes/servicioTecnicoRoutes.js";
import carritoRoutes from "./routes/carritoRoutes.js";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();

//  MIDDLEWARES
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

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
app.use("/api/ventas", ventaRoutes);
app.use("/api/servicios", servicioTecnicoRoutes);
app.use("/api/carrito", carritoRoutes);

// ============================================
// LOGIN EMPLEADOS
// ============================================
app.post("/loginEmpleado", (req, res) => {
  const { correo, contrasena } = req.body;
  const query = "SELECT * FROM empleados WHERE Correo = ? AND Contrasena_acceso = ?";

  conexion.query(query, [correo, contrasena], (error, results) => {
    if (error) return res.status(500).json({ success: false, message: "Error en el servidor" });
    if (results.length > 0) {
      res.json({ success: true, tipo: "empleado", usuario: results[0] });
    } else {
      res.json({ success: false, message: "Credenciales incorrectas" });
    }
  });
});

// ============================================
// LOGIN ADMINISTRADOR
// ============================================
app.post("/loginAdmin", (req, res) => {
  const { usuario, contrasena } = req.body;
  const query = "SELECT * FROM administrador WHERE usuario = ? AND contrasena = ?";

  conexion.query(query, [usuario, contrasena], (error, results) => {
    if (error) return res.status(500).json({ success: false, message: "Error en el servidor" });
    if (results.length > 0) {
      res.json({ success: true, tipo: "admin" });
    } else {
      res.json({ success: false, message: "Usuario o contraseña incorrectos" });
    }
  });
});

// ============================================
// SOPORTE
// ============================================
app.post("/api/soporte", (req, res) => {
  const { nombre, correo, mensaje } = req.body;
  const sql = "INSERT INTO soporte (Nombre, Correo, Mensaje) VALUES (?, ?, ?)";
  conexion.query(sql, [nombre, correo, mensaje], (err) => {
    if (err) return res.status(500).json({ mensaje: "Error al guardar el mensaje" });
    res.json({ mensaje: "Mensaje enviado correctamente" });
  });
});

// ============================================
// PEDIDOS
// ============================================
app.post("/api/pedidos", (req, res) => {
  const { cliente, producto, cantidad, direccion } = req.body;
  const sql = "INSERT INTO pedido (ID_cliente, Producto, Cantidad, Direccion) VALUES (?, ?, ?, ?)";
  conexion.query(sql, [cliente || null, producto, cantidad, direccion], (err) => {
    if (err) return res.status(500).json({ mensaje: "Error al registrar el pedido" });
    res.json({ mensaje: "Pedido registrado correctamente" });
  });
});

// ============================================
// CARRITO
// ============================================

//  Agregar producto al carrito
app.post("/api/carrito", (req, res) => {
  console.log("📥 Datos recibidos en /api/carrito:", req.body);
  const { id_cliente, id_producto, cantidad } = req.body;

  if (!id_cliente || !id_producto || !cantidad) {
    return res.status(400).json({ mensaje: "Datos incompletos", datos: req.body });
  }

  const query = `
    INSERT INTO carrito (id_cliente, id_producto, cantidad)
    VALUES (?, ?, ?)
    ON DUPLICATE KEY UPDATE cantidad = cantidad + VALUES(cantidad)
  `;

  conexion.query(query, [id_cliente, id_producto, cantidad], (err) => {
    if (err) {
      console.error("Error al agregar al carrito:", err);
      return res.status(500).json({ mensaje: "Error al agregar al carrito", error: err });
    }
    res.json({ mensaje: "Producto agregado al carrito correctamente" });
  });
});


//  Obtener productos del carrito
app.get("/api/carrito/:id_cliente", (req, res) => {
  const { id_cliente } = req.params;
  const query = `
    SELECT c.id, p.Nombre, p.Precio_venta, p.Descripcion, c.cantidad, p.ID_producto
    FROM carrito c
    JOIN producto p ON c.id_producto = p.ID_producto
    WHERE c.id_cliente = ?;
  `;
  conexion.query(query, [id_cliente], (err, results) => {
    if (err) return res.status(500).json({ mensaje: "Error al cargar el carrito" });
    res.json(results);
  });
});

//  Eliminar un producto del carrito
app.delete("/api/carrito/:id", (req, res) => {
  const { id } = req.params;
  const query = "DELETE FROM carrito WHERE id = ?";
  conexion.query(query, [id], (err) => {
    if (err) return res.status(500).json({ mensaje: "Error al eliminar del carrito" });
    res.json({ mensaje: "Producto eliminado del carrito" });
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
      SUM(vp.Cantidad) AS total_vendido
    FROM producto p
    JOIN venta_producto vp ON p.ID_producto = vp.ID_producto
    GROUP BY p.ID_producto, p.Nombre, p.Precio_venta, p.Stock_actual
    ORDER BY total_vendido DESC
    LIMIT 5;
  `;

  conexion.query(query, (err, results) => {
    if (err) {
      console.error("Error al obtener top 5:", err);
      return res.status(500).json({ success: false, error: err });
    }
    res.json(results);
  });
});

// ============================================
// INICIAR SERVIDOR
// ============================================
const PORT = 3000;
app.listen(PORT, () => {
  console.log(`🚀 Servidor corriendo en http://localhost:${PORT}`);
  console.log(`📁 Sirviendo archivos desde: ${path.join(__dirname, "../frontend")}`);
});
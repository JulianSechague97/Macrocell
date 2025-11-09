// backend/controllers/productoController.js
import { conexion } from "../db.js";

// se optiene todos los productos
export const obtenerProductos = (req, res) => {
  const query = `
    SELECT 
      ID_producto AS id,
      Nombre AS nombre,
      Precio_venta AS precio,
      ID_proveedor AS categoria,
      Stock_actual AS stock
    FROM producto;
  `;

  conexion.query(query, (err, resultados) => {
    if (err) {
      console.error("Error al obtener productos:", err);
      return res.status(500).json({ error: "Error al obtener productos: " + err.message });
    }
    res.json(resultados);
  });
};


// se agrega un nuevo producto
export const agregarProducto = (req, res) => {
  const { nombre, precio, categoria, stock } = req.body; 
  
  // Mapeo a columnas reales
  conexion.query(
    "INSERT INTO producto (Nombre, Precio_venta, ID_proveedor, Stock_actual) VALUES (?, ?, ?, ?)",
    [nombre, precio, categoria, stock], 
    (err) => {
      if (err) {
        console.error("Error al agregar producto:", err);
        return res.status(500).json({ error: "Error al agregar producto: " + err.message });
      }
      res.json({ mensaje: "Producto agregado correctamente " });
    }
  );
};

// eliminar un producto
export const eliminarProducto = (req, res) => {
  const { id } = req.params;
  
  conexion.query("DELETE FROM producto WHERE ID_producto = ?", [id], (err) => {
    if (err) {
      console.error("Error al eliminar producto:", err);
      return res.status(500).json({ error: "Error al eliminar producto: " + err.message });
    }
    res.json({ mensaje: "Producto eliminado correctamente " });
  });
};

// actualizar un producto
export const actualizarProducto = (req, res) => {
  const { id } = req.params;
  const { nombre, precio, categoria, stock } = req.body;
  
  // Mapeo a columnas reales
  conexion.query(
    "UPDATE producto SET Nombre=?, Precio_venta=?, ID_proveedor=?, Stock_actual=? WHERE ID_producto=?",
    [nombre, precio, categoria, stock, id],
    (err) => {
      if (err) {
        console.error("Error al actualizar producto:", err);
        return res.status(500).json({ error: "Error al actualizar producto: " + err.message });
      }
      res.json({ mensaje: "Producto actualizado correctamente " });
    }
  );
};
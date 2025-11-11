// backend/controllers/ventaController.js
import { conexion } from "../db.js";

//  Obtener todas las ventas
export const obtenerVentas = (req, res) => {
  const query = `
    SELECT 
      v.ID_venta,
      v.Fecha_venta,
      v.Total,
      c.Nombre AS nombre_cliente,
      c.Cedula AS cedula_cliente,
      e.Nombre AS nombre_empleado
    FROM venta v
    LEFT JOIN cliente c ON v.ID_cliente = c.ID_cliente
    LEFT JOIN empleados e ON v.ID_usuario = e.ID_usuario
    ORDER BY v.Fecha_venta DESC
  `;
  
  conexion.query(query, (err, results) => {
    if (err) {
      console.error("Error al obtener ventas:", err);
      return res.status(500).json({ error: "Error al obtener ventas: " + err.message });
    }
    res.json(results);
  });
};

//  Obtener detalle de una venta
export const obtenerDetalleVenta = (req, res) => {
  const { id } = req.params;
  
  const query = `
    SELECT 
      vp.ID_producto,
      p.Nombre AS nombre_producto,
      vp.Cantidad,
      p.Precio_venta,
      (vp.Cantidad * p.Precio_venta) AS subtotal
    FROM venta_producto vp
    INNER JOIN producto p ON vp.ID_producto = p.ID_producto
    WHERE vp.ID_venta = ?
  `;
  
  conexion.query(query, [id], (err, results) => {
    if (err) {
      console.error("Error al obtener detalle de venta:", err);
      return res.status(500).json({ error: "Error al obtener detalle: " + err.message });
    }
    res.json(results);
  });
};

//  Registrar nueva venta
export const registrarVenta = (req, res) => {
  const { ID_usuario, ID_cliente, productos } = req.body;
  
  // Validar que hay al menos un producto
  if (!productos || productos.length === 0) {
    return res.status(400).json({ error: "Debe haber al menos un producto en la venta" });
  }
  
  // Validar y normalizar productos, calcular el total
  let total = 0;
  // Normalize products: accept ID_producto or id, and precio_venta or precio
  for (const prod of productos) {
    const idProd = prod.ID_producto ?? prod.id ?? prod.ID ?? null;
    const precio = prod.precio_venta ?? prod.precio ?? prod.precioVenta ?? 0;
    const cantidad = Number(prod.cantidad || 0);

    if (!idProd) {
      return res.status(400).json({ error: `Producto sin ID (ID_producto) en payload: ${JSON.stringify(prod)}` });
    }

    // ensure numeric
    total += cantidad * Number(precio);
    // attach normalized fields for later use
    prod._ID_producto = idProd;
    prod._precio_venta = Number(precio);
    prod.cantidad = cantidad;
  }
  
  // Insertar la venta (ID_usuario puede ser null si es compra de cliente)
  const queryVenta = "INSERT INTO venta (ID_usuario, ID_cliente, Fecha_venta, Total) VALUES (?, ?, NOW(), ?)";
  
  conexion.query(queryVenta, [ID_usuario || null, ID_cliente || null, total], (err, result) => {
    if (err) {
      console.error("Error al registrar venta:", err);
      return res.status(500).json({ error: "Error al registrar venta: " + err.message });
    }
    
    const ID_venta = result.insertId;

    // Insertar productos de la venta (incluyendo precio por unidad)
    const queryProductos = "INSERT INTO venta_producto (ID_venta, ID_producto, Cantidad, Precio) VALUES ?";
    const valores = productos.map(prod => [ID_venta, prod._ID_producto, prod.cantidad, prod._precio_venta]);

    conexion.query(queryProductos, [valores], (err2) => {
      if (err2) {
        console.error("Error al insertar productos:", err2);
        return res.status(500).json({ error: "Error al insertar productos: " + err2.message });
      }
      
      // Actualizar stock de productos
      productos.forEach(prod => {
        const queryStock = "UPDATE producto SET Stock_actual = Stock_actual - ? WHERE ID_producto = ?";
        conexion.query(queryStock, [prod.cantidad, prod._ID_producto], (errStock) => {
          if (errStock) console.error("Error al actualizar stock:", errStock);
        });
      });
      
      res.json({ 
        message: "Venta registrada correctamente", 
        ID_venta,
        total 
      });
    });
  });
};

//  Actualizar venta
export const actualizarVenta = (req, res) => {
  const { id } = req.params;
  const { Total, Fecha_venta } = req.body;
  
  const query = "UPDATE venta SET Total = ?, Fecha_venta = ? WHERE ID_venta = ?";
  
  conexion.query(query, [Total, Fecha_venta, id], (err) => {
    if (err) {
      console.error("Error al actualizar venta:", err);
      return res.status(500).json({ error: "Error al actualizar venta: " + err.message });
    }
    res.json({ message: "Venta actualizada correctamente " });
  });
};

//  Eliminar venta
export const eliminarVenta = (req, res) => {
  const { id } = req.params;
  
  // Primero eliminar los productos de la venta
  conexion.query("DELETE FROM venta_producto WHERE ID_venta = ?", [id], (err) => {
    if (err) {
      console.error("Error al eliminar productos de venta:", err);
      return res.status(500).json({ error: "Error al eliminar productos: " + err.message });
    }
    
    // Luego eliminar la venta
    conexion.query("DELETE FROM venta WHERE ID_venta = ?", [id], (err2) => {
      if (err2) {
        console.error("Error al eliminar venta:", err2);
        return res.status(500).json({ error: "Error al eliminar venta: " + err2.message });
      }
      res.json({ message: "Venta eliminada correctamente " });
    });
  });
};
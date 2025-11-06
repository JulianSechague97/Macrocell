import { conexion } from "../db.js";

// ============================================
// AGREGAR PRODUCTO AL CARRITO
// ============================================
export const agregarAlCarrito = (req, res) => {
  const { id_cliente, id_producto, cantidad } = req.body;

  // Validaciones
  if (!id_producto || !cantidad) {
    return res.status(400).json({ 
      error: "Producto y cantidad son requeridos" 
    });
  }

  if (cantidad <= 0) {
    return res.status(400).json({ 
      error: "La cantidad debe ser mayor a 0" 
    });
  }

  // SQL con ON DUPLICATE KEY para actualizar si ya existe
  const sql = `
    INSERT INTO carrito (id_cliente, id_producto, cantidad)
    VALUES (?, ?, ?)
    ON DUPLICATE KEY UPDATE cantidad = cantidad + VALUES(cantidad)
  `;

  conexion.query(sql, [id_cliente || null, id_producto, cantidad], (err, result) => {
    if (err) {
      console.error("Error al agregar al carrito:", err);
      return res.status(500).json({ 
        error: "Error al agregar al carrito",
        details: process.env.NODE_ENV === 'development' ? err.message : undefined
      });
    }
    
    res.json({ 
      success: true,
      message: "Producto agregado al carrito correctamente",
      carritoId: result.insertId
    });
  });
};

// ============================================
// OBTENER CARRITO DE UN CLIENTE
// ============================================
export const obtenerCarrito = (req, res) => {
  const { id_cliente } = req.params;

  if (!id_cliente || id_cliente === 'null' || id_cliente === 'undefined') {
    return res.status(400).json({ 
      error: "ID de cliente es requerido" 
    });
  }

  const sql = `
    SELECT 
      c.id,
      c.id_cliente,
      c.id_producto,
      c.cantidad,
      c.fecha_agregado,
      p.Nombre,
      p.Precio_venta,
      p.Descripcion,
      p.Stock_actual,
      (c.cantidad * p.Precio_venta) AS subtotal
    FROM carrito c
    INNER JOIN producto p ON c.id_producto = p.ID_producto
    WHERE c.id_cliente = ?
    ORDER BY c.fecha_agregado DESC
  `;

  conexion.query(sql, [id_cliente], (err, results) => {
    if (err) {
      console.error("Error al obtener carrito:", err);
      return res.status(500).json({ 
        error: "Error al obtener carrito",
        details: process.env.NODE_ENV === 'development' ? err.message : undefined
      });
    }

    // Calcular total del carrito
    const total = results.reduce((sum, item) => sum + parseFloat(item.subtotal), 0);

    res.json({
      items: results,
      total: total.toFixed(2),
      cantidad_items: results.length
    });
  });
};

// ============================================
// ACTUALIZAR CANTIDAD DE UN ITEM
// ============================================
export const actualizarCantidad = (req, res) => {
  const { id } = req.params;
  const { cantidad } = req.body;

  if (!cantidad || cantidad <= 0) {
    return res.status(400).json({ 
      error: "La cantidad debe ser mayor a 0" 
    });
  }

  const sql = `UPDATE carrito SET cantidad = ? WHERE id = ?`;

  conexion.query(sql, [cantidad, id], (err, result) => {
    if (err) {
      console.error("Error al actualizar cantidad:", err);
      return res.status(500).json({ 
        error: "Error al actualizar cantidad",
        details: process.env.NODE_ENV === 'development' ? err.message : undefined
      });
    }

    if (result.affectedRows === 0) {
      return res.status(404).json({ 
        error: "Item no encontrado en el carrito" 
      });
    }

    res.json({ 
      success: true,
      message: "Cantidad actualizada correctamente"
    });
  });
};

// ============================================
// ELIMINAR ITEM DEL CARRITO
// ============================================
export const eliminarCarritoItem = (req, res) => {
  const { id } = req.params;

  if (!id) {
    return res.status(400).json({ 
      error: "ID del item es requerido" 
    });
  }

  const sql = `DELETE FROM carrito WHERE id = ?`;

  conexion.query(sql, [id], (err, result) => {
    if (err) {
      console.error("Error al eliminar item del carrito:", err);
      return res.status(500).json({ 
        error: "Error al eliminar item",
        details: process.env.NODE_ENV === 'development' ? err.message : undefined
      });
    }

    if (result.affectedRows === 0) {
      return res.status(404).json({ 
        error: "Item no encontrado" 
      });
    }

    res.json({ 
      success: true,
      message: "Item eliminado del carrito"
    });
  });
};

// ============================================
// VACIAR CARRITO COMPLETO
// ============================================
export const vaciarCarrito = (req, res) => {
  const { id_cliente } = req.params;

  if (!id_cliente) {
    return res.status(400).json({ 
      error: "ID de cliente es requerido" 
    });
  }

  const sql = `DELETE FROM carrito WHERE id_cliente = ?`;

  conexion.query(sql, [id_cliente], (err, result) => {
    if (err) {
      console.error("Error al vaciar carrito:", err);
      return res.status(500).json({ 
        error: "Error al vaciar carrito",
        details: process.env.NODE_ENV === 'development' ? err.message : undefined
      });
    }

    res.json({ 
      success: true,
      message: "Carrito vaciado correctamente",
      items_eliminados: result.affectedRows
    });
  });
};
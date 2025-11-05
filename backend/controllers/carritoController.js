import { conexion } from "../db.js";

export const agregarAlCarrito = (req, res) => {
  const { id_cliente, id_producto, cantidad } = req.body;
  // Validaciones simples
  if (!id_producto || !cantidad) return res.status(400).json({ error: "Faltan datos" });

  const sql = `
    INSERT INTO carrito (id_cliente, id_producto, cantidad)
    VALUES (?, ?, ?)
    ON DUPLICATE KEY UPDATE cantidad = cantidad + VALUES(cantidad)
  `;
  conexion.query(sql, [id_cliente || null, id_producto, cantidad], (err, result) => {
    if (err) {
      console.error(err);
      return res.status(500).json({ error: "Error al agregar al carrito" });
    }
    res.json({ success: true });
  });
};

export const obtenerCarrito = (req, res) => {
  const { id_cliente } = req.params;
  const sql = `
    SELECT c.id, c.id_cliente, c.id_producto, c.cantidad, p.Nombre, p.Precio_venta, p.Descripcion
    FROM carrito c
    JOIN producto p ON c.id_producto = p.ID_producto
    WHERE c.id_cliente = ?
  `;
  conexion.query(sql, [id_cliente], (err, results) => {
    if (err) return res.status(500).json({ error: "Error al obtener carrito" });
    res.json(results);
  });
};

export const eliminarCarritoItem = (req, res) => {
  const { id } = req.params;
  const sql = `DELETE FROM carrito WHERE id = ?`;
  conexion.query(sql, [id], (err) => {
    if (err) return res.status(500).json({ error: "Error al eliminar item" });
    res.json({ success: true });
  });
};
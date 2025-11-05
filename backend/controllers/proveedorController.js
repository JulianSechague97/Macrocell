// backend/controllers/proveedorController.js
import { conexion } from "../db.js";

//  Obtener todos los proveedores
export const obtenerProveedores = (req, res) => {
  const query = "SELECT * FROM proveedor ORDER BY Nombre";
  
  conexion.query(query, (err, resultados) => {
    if (err) {
      console.error("Error al obtener proveedores:", err);
      return res.status(500).json({ error: "Error al obtener proveedores: " + err.message });
    }
    res.json(resultados);
  });
};

//  Agregar proveedor
export const agregarProveedor = (req, res) => {
  const { NIT, Nombre, Correo, Telefono, Direccion } = req.body;
  
  const query = "INSERT INTO proveedor (NIT, Nombre, Correo, Telefono, Direccion) VALUES (?, ?, ?, ?, ?)";
  
  conexion.query(query, [NIT, Nombre, Correo, Telefono, Direccion], (err, result) => {
    if (err) {
      console.error("Error al agregar proveedor:", err);
      return res.status(500).json({ error: "Error al agregar proveedor: " + err.message });
    }
    res.status(201).json({ 
      message: "Proveedor agregado correctamente ",
      ID_proveedor: result.insertId 
    });
  });
};

// Actualizar proveedor
export const actualizarProveedor = (req, res) => {
  const { id } = req.params;
  const { NIT, Nombre, Correo, Telefono, Direccion } = req.body;
  
  const query = `
    UPDATE proveedor 
    SET NIT = ?, Nombre = ?, Correo = ?, Telefono = ?, Direccion = ?
    WHERE ID_proveedor = ?
  `;
  
  conexion.query(query, [NIT, Nombre, Correo, Telefono, Direccion, id], (err) => {
    if (err) {
      console.error("Error al actualizar proveedor:", err);
      return res.status(500).json({ error: "Error al actualizar proveedor: " + err.message });
    }
    res.json({ message: "Proveedor actualizado correctamente " });
  });
};

//  Eliminar proveedor
export const eliminarProveedor = (req, res) => {
  const { id } = req.params;
  
  conexion.query("DELETE FROM proveedor WHERE ID_proveedor = ?", [id], (err) => {
    if (err) {
      console.error("Error al eliminar proveedor:", err);
      return res.status(500).json({ error: "Error al eliminar proveedor: " + err.message });
    }
    res.json({ message: "Proveedor eliminado correctamente " });
  });
};
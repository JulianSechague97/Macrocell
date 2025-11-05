// backend/controllers/servicioTecnicoController.js
import { conexion } from "../db.js";

//  Obtener todos los servicios técnicos
export const obtenerServicios = (req, res) => {
  const query = `
    SELECT 
      s.ID_servicio,
      s.Descripcion_falla,
      s.Fecha_ingreso,
      s.Fecha_entrega,
      s.Estado_servicio,
      s.Costo,
      c.Nombre AS nombre_cliente,
      c.Telefono AS telefono_cliente,
      e.Nombre AS nombre_empleado
    FROM servicio_tecnico s
    LEFT JOIN cliente c ON s.ID_cliente = c.ID_cliente
    LEFT JOIN empleados e ON s.ID_usuario = e.ID_usuario
    ORDER BY s.Fecha_ingreso DESC
  `;
  
  conexion.query(query, (err, results) => {
    if (err) {
      console.error("Error al obtener servicios:", err);
      return res.status(500).json({ error: "Error al obtener servicios: " + err.message });
    }
    res.json(results);
  });
};

//  Registrar nuevo servicio técnico
export const registrarServicio = (req, res) => {
  const { ID_usuario, ID_cliente, Descripcion_falla, Fecha_entrega, Estado_servicio, Costo } = req.body;
  
  const query = `
    INSERT INTO servicio_tecnico 
    (ID_usuario, ID_cliente, Descripcion_falla, Fecha_ingreso, Fecha_entrega, Estado_servicio, Costo) 
    VALUES (?, ?, ?, NOW(), ?, ?, ?)
  `;
  
  conexion.query(
    query, 
    [ID_usuario, ID_cliente, Descripcion_falla, Fecha_entrega, Estado_servicio, Costo], 
    (err, result) => {
      if (err) {
        console.error("Error al registrar servicio:", err);
        return res.status(500).json({ error: "Error al registrar servicio: " + err.message });
      }
      res.json({ 
        message: "Servicio técnico registrado correctamente ",
        ID_servicio: result.insertId 
      });
    }
  );
};

//  Actualizar servicio técnico
export const actualizarServicio = (req, res) => {
  const { id } = req.params;
  const { Descripcion_falla, Fecha_entrega, Estado_servicio, Costo } = req.body;
  
  const query = `
    UPDATE servicio_tecnico 
    SET Descripcion_falla = ?, Fecha_entrega = ?, Estado_servicio = ?, Costo = ?
    WHERE ID_servicio = ?
  `;
  
  conexion.query(
    query, 
    [Descripcion_falla, Fecha_entrega, Estado_servicio, Costo, id], 
    (err) => {
      if (err) {
        console.error("Error al actualizar servicio:", err);
        return res.status(500).json({ error: "Error al actualizar servicio: " + err.message });
      }
      res.json({ message: "Servicio actualizado correctamente " });
    }
  );
};

// Obtener un servicio técnico por su ID
export const obtenerServicioPorId = (req, res) => {
  const { id } = req.params;
  const query = "SELECT * FROM servicio_tecnico WHERE ID_servicio = ?";

  conexion.query(query, [id], (err, results) => {
    if (err) {
      console.error("Error al consultar servicio:", err);
      return res.status(500).json({ mensaje: "Error al consultar servicio" });
    }

    if (results.length === 0) {
      return res.status(404).json({ mensaje: "Servicio no encontrado" });
    }

    res.json(results[0]);
  });
};

//  Eliminar servicio técnico
export const eliminarServicio = (req, res) => {
  const { id } = req.params;
  
  conexion.query("DELETE FROM servicio_tecnico WHERE ID_servicio = ?", [id], (err) => {
    if (err) {
      console.error("Error al eliminar servicio:", err);
      return res.status(500).json({ error: "Error al eliminar servicio: " + err.message });
    }
    res.json({ message: "Servicio eliminado correctamente " });
  });
};

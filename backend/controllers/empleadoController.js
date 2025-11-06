// =====================================================
// CONTROLADOR DE EMPLEADOS - MACROCELL
// =====================================================

import { conexion } from "../db.js";

// ============================================
// LISTAR TODOS LOS EMPLEADOS
// ============================================
export const obtenerEmpleados = (req, res) => {
  const query = `
    SELECT 
      ID_usuario,
      Cedula,
      Nombre,
      Correo,
      Telefono,
      rol
    FROM empleados
    ORDER BY Nombre
  `;

  conexion.query(query, (err, results) => {
    if (err) {
      console.error("Error al obtener empleados:", err);
      return res.status(500).json({ 
        error: "Error al obtener empleados",
        details: process.env.NODE_ENV === 'development' ? err.message : undefined
      });
    }
    res.json(results);
  });
};

// ============================================
// OBTENER UN EMPLEADO POR ID
// ============================================
export const obtenerEmpleadoPorId = (req, res) => {
  const { id } = req.params;

  const query = `
    SELECT 
      ID_usuario,
      Cedula,
      Nombre,
      Correo,
      Telefono,
      rol
    FROM empleados
    WHERE ID_usuario = ?
  `;

  conexion.query(query, [id], (err, results) => {
    if (err) {
      console.error("Error al obtener empleado:", err);
      return res.status(500).json({ 
        error: "Error al obtener empleado" 
      });
    }

    if (results.length === 0) {
      return res.status(404).json({ 
        error: "Empleado no encontrado" 
      });
    }

    res.json(results[0]);
  });
};

// ============================================
// CREAR NUEVO EMPLEADO
// ============================================
export const crearEmpleado = (req, res) => {
  const { Cedula, Nombre, Correo, Telefono, Contrasena_acceso, rol } = req.body;

  // Validaciones
  if (!Nombre || !Correo || !Contrasena_acceso) {
    return res.status(400).json({ 
      error: "Nombre, correo y contraseña son obligatorios" 
    });
  }

  if (Contrasena_acceso.length < 6) {
    return res.status(400).json({ 
      error: "La contraseña debe tener al menos 6 caracteres" 
    });
  }

  // Validar rol
  const rolFinal = rol === 'admin' ? 'admin' : 'empleado';

  const query = `
    INSERT INTO empleados (Cedula, Nombre, Correo, Telefono, Contrasena_acceso, rol)
    VALUES (?, ?, ?, ?, ?, ?)
  `;

  conexion.query(
    query,
    [Cedula || null, Nombre, Correo, Telefono || null, Contrasena_acceso, rolFinal],
    (err, result) => {
      if (err) {
        console.error("Error al crear empleado:", err);
        
        // Error de duplicado (correo o cédula)
        if (err.code === 'ER_DUP_ENTRY') {
          return res.status(400).json({ 
            error: "Ya existe un empleado con ese correo o cédula" 
          });
        }

        return res.status(500).json({ 
          error: "Error al crear empleado",
          details: process.env.NODE_ENV === 'development' ? err.message : undefined
        });
      }

      res.status(201).json({
        message: "Empleado creado correctamente",
        ID_usuario: result.insertId,
        rol: rolFinal
      });
    }
  );
};

// ============================================
// ACTUALIZAR EMPLEADO
// ============================================
export const actualizarEmpleado = (req, res) => {
  const { id } = req.params;
  const { Cedula, Nombre, Correo, Telefono, Contrasena_acceso, rol } = req.body;

  // Validaciones
  if (!Nombre || !Correo) {
    return res.status(400).json({ 
      error: "Nombre y correo son obligatorios" 
    });
  }

  // Validar rol
  const rolFinal = rol === 'admin' ? 'admin' : 'empleado';

  // Si se proporciona contraseña, validarla
  if (Contrasena_acceso && Contrasena_acceso.length < 6) {
    return res.status(400).json({ 
      error: "La contraseña debe tener al menos 6 caracteres" 
    });
  }

  // Query base
  let query = `
    UPDATE empleados 
    SET Cedula = ?, Nombre = ?, Correo = ?, Telefono = ?, rol = ?
  `;
  
  let params = [Cedula || null, Nombre, Correo, Telefono || null, rolFinal];

  // Si se proporciona contraseña, incluirla en el update
  if (Contrasena_acceso) {
    query += `, Contrasena_acceso = ?`;
    params.push(Contrasena_acceso);
  }

  query += ` WHERE ID_usuario = ?`;
  params.push(id);

  conexion.query(query, params, (err, result) => {
    if (err) {
      console.error("Error al actualizar empleado:", err);

      if (err.code === 'ER_DUP_ENTRY') {
        return res.status(400).json({ 
          error: "Ya existe un empleado con ese correo o cédula" 
        });
      }

      return res.status(500).json({ 
        error: "Error al actualizar empleado",
        details: process.env.NODE_ENV === 'development' ? err.message : undefined
      });
    }

    if (result.affectedRows === 0) {
      return res.status(404).json({ 
        error: "Empleado no encontrado" 
      });
    }

    res.json({
      message: "Empleado actualizado correctamente",
      rol: rolFinal
    });
  });
};

// ============================================
// ELIMINAR EMPLEADO
// ============================================
export const eliminarEmpleado = (req, res) => {
  const { id } = req.params;

  // Verificar que no sea el único admin
  const queryVerificar = `
    SELECT COUNT(*) as total_admins 
    FROM empleados 
    WHERE rol = 'admin'
  `;

  conexion.query(queryVerificar, (err, results) => {
    if (err) {
      console.error("Error al verificar admins:", err);
      return res.status(500).json({ 
        error: "Error al eliminar empleado" 
      });
    }

    const totalAdmins = results[0].total_admins;

    // Verificar si el empleado a eliminar es admin
    const queryRol = "SELECT rol FROM empleados WHERE ID_usuario = ?";
    
    conexion.query(queryRol, [id], (err2, results2) => {
      if (err2) {
        console.error("Error al verificar rol:", err2);
        return res.status(500).json({ 
          error: "Error al eliminar empleado" 
        });
      }

      if (results2.length === 0) {
        return res.status(404).json({ 
          error: "Empleado no encontrado" 
        });
      }

      // Si es el último admin, no permitir eliminar
      if (results2[0].rol === 'admin' && totalAdmins === 1) {
        return res.status(400).json({ 
          error: "No se puede eliminar el último administrador del sistema" 
        });
      }

      // Proceder con la eliminación
      const queryEliminar = "DELETE FROM empleados WHERE ID_usuario = ?";
      
      conexion.query(queryEliminar, [id], (err3, result) => {
        if (err3) {
          console.error("Error al eliminar empleado:", err3);
          return res.status(500).json({ 
            error: "Error al eliminar empleado",
            details: process.env.NODE_ENV === 'development' ? err3.message : undefined
          });
        }

        res.json({
          message: "Empleado eliminado correctamente"
        });
      });
    });
  });
};

// ============================================
// CAMBIAR ROL DE EMPLEADO
// ============================================
export const cambiarRol = (req, res) => {
  const { id } = req.params;
  const { rol } = req.body;

  if (!rol || (rol !== 'admin' && rol !== 'empleado')) {
    return res.status(400).json({ 
      error: "Rol inválido. Debe ser 'admin' o 'empleado'" 
    });
  }

  const query = "UPDATE empleados SET rol = ? WHERE ID_usuario = ?";

  conexion.query(query, [rol, id], (err, result) => {
    if (err) {
      console.error("Error al cambiar rol:", err);
      return res.status(500).json({ 
        error: "Error al cambiar rol" 
      });
    }

    if (result.affectedRows === 0) {
      return res.status(404).json({ 
        error: "Empleado no encontrado" 
      });
    }

    res.json({
      message: "Rol actualizado correctamente",
      nuevo_rol: rol
    });
  });
};
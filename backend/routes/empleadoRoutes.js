// =====================================================
// RUTAS DE EMPLEADOS - MACROCELL
// =====================================================

import express from "express";
import {
  obtenerEmpleados,
  obtenerEmpleadoPorId,
  crearEmpleado,
  actualizarEmpleado,
  eliminarEmpleado,
  cambiarRol
} from "../controllers/empleadoController.js";

const router = express.Router();

// ============================================
// RUTAS DE EMPLEADOS
// ============================================

// GET /api/empleados - Obtener todos los empleados
router.get("/", obtenerEmpleados);

// GET /api/empleados/:id - Obtener un empleado por ID
router.get("/:id", obtenerEmpleadoPorId);

// POST /api/empleados - Crear nuevo empleado
router.post("/", crearEmpleado);

// PUT /api/empleados/:id - Actualizar empleado
router.put("/:id", actualizarEmpleado);

// DELETE /api/empleados/:id - Eliminar empleado
router.delete("/:id", eliminarEmpleado);

// PATCH /api/empleados/:id/rol - Cambiar rol de empleado
router.patch("/:id/rol", cambiarRol);

export default router;
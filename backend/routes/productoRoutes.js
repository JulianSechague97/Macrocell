// backend/routes/productoRoutes.js
import express from "express";
import { 
  obtenerProductos, 
  agregarProducto, 
  eliminarProducto, 
  actualizarProducto 
} from "../controllers/productoController.js";


const router = express.Router();

// GET /api/productos - Obtener todos
router.get("/", obtenerProductos);

// POST /api/productos - Agregar uno nuevo
router.post("/", agregarProducto);

// DELETE /api/productos/:id - Eliminar por ID
router.delete("/:id", eliminarProducto);

// PUT /api/productos/:id - Actualizar por ID
router.put("/:id", actualizarProducto);

export default router;
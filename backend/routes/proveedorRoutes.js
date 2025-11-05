// backend/routes/proveedorRoutes.js
import express from "express";
import { 
  obtenerProveedores, 
  agregarProveedor,
  actualizarProveedor,
  eliminarProveedor
} from "../controllers/proveedorController.js";

const router = express.Router();

router.get("/", obtenerProveedores);
router.post("/", agregarProveedor);
router.put("/:id", actualizarProveedor);
router.delete("/:id", eliminarProveedor);

export default router;
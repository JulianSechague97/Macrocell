// backend/routes/ventaRoutes.js
import express from "express";
import {
  obtenerVentas,
  obtenerDetalleVenta,
  registrarVenta,
  actualizarVenta,
  eliminarVenta
} from "../controllers/ventaController.js";

const router = express.Router();

router.get("/", obtenerVentas);
router.get("/:id/detalle", obtenerDetalleVenta);
router.post("/", registrarVenta);
router.put("/:id", actualizarVenta);
router.delete("/:id", eliminarVenta);

export default router;
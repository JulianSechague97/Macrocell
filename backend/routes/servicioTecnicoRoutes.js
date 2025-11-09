import express from "express";
import {
  obtenerServicios,
  obtenerServicioPorId,
  registrarServicio,
  actualizarServicio,
  eliminarServicio
} from "../controllers/servicioTecnicoController.js";

const router = express.Router();

router.get("/", obtenerServicios);
router.get("/:id", obtenerServicioPorId);
router.post("/", registrarServicio);
router.put("/:id", actualizarServicio);
router.delete("/:id", eliminarServicio);

export default router;
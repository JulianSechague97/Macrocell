import express from "express";
import {
  obtenerClientes,
  obtenerClientePorId,
  registrarCliente,
  actualizarCliente,
  eliminarCliente
} from "../controllers/clienteController.js";

const router = express.Router();

router.get("/", obtenerClientes);
router.get("/:id", obtenerClientePorId);
router.post("/", registrarCliente);
router.put("/:id", actualizarCliente);
router.delete("/:id", eliminarCliente);

export default router;

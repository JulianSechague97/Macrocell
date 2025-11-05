import express from "express";
import { agregarAlCarrito, obtenerCarrito, eliminarCarritoItem } from "../controllers/carritoController.js";
const router = express.Router();

router.post("/", agregarAlCarrito);
router.get("/:id_cliente", obtenerCarrito);
router.delete("/:id", eliminarCarritoItem);

export default router;
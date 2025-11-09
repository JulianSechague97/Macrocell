//  Agregar productos al carrito
document.querySelectorAll(".btn-agregar").forEach((boton) => {
  boton.addEventListener("click", (e) => {
    const productoEl = e.target.closest(".producto");
    const nombre = productoEl.querySelector("h3").textContent;
    const precio = parseInt(productoEl.querySelector(".precio").textContent.replace(/\D/g, ""));
    const imagen = productoEl.querySelector("img").src;

    let carrito = JSON.parse(localStorage.getItem("carrito")) || [];

    // Verificar si ya está en el carrito
    const existente = carrito.find(p => p.nombre === nombre);
    if (existente) {
      existente.cantidad++;
    } else {
      carrito.push({ nombre, precio, imagen, cantidad: 1 });
    }

    localStorage.setItem("carrito", JSON.stringify(carrito));
    mostrarAnimacionCarrito(nombre);
  });
});

//  Animación de confirmación
function mostrarAnimacionCarrito(nombre) {
  const mensaje = document.createElement("div");
  mensaje.classList.add("mensaje-carrito");
  mensaje.textContent = `🛒 ${nombre} agregado al carrito`;
  document.body.appendChild(mensaje);

  setTimeout(() => mensaje.classList.add("visible"), 50);
  setTimeout(() => {
    mensaje.classList.remove("visible");
    setTimeout(() => mensaje.remove(), 500);
  }, 2000);
}


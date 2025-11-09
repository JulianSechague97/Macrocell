let carrito = JSON.parse(localStorage.getItem("carrito")) || [];

const listaCarrito = document.getElementById("lista-carrito");
const totalPagar = document.getElementById("total-pagar");
const carritoCount = document.getElementById("carrito-count");

function actualizarContador() {
  if (!carritoCount) return;
  carritoCount.textContent = carrito.reduce((acc, p) => acc + p.cantidad, 0);
}

function calcularTotal() {
  const total = carrito.reduce((acc, p) => acc + (p.precio * p.cantidad), 0);
  totalPagar.textContent = "$" + total.toLocaleString("es-CO");
}

function cargarCarrito() {
  listaCarrito.innerHTML = "";

  carrito.forEach((producto, index) => {
    const item = document.createElement("div");
    item.classList.add("carrito-item");

    item.innerHTML = `
      <img src="${producto.imagen}" alt="${producto.nombre}">
      <div class="info">
        <h3>${producto.nombre}</h3>
        <p>Precio: $${producto.precio.toLocaleString("es-CO")}</p>
        <p>Cantidad: 
          <button onclick="cambiarCantidad(${index}, -1)">➖</button>
          ${producto.cantidad}
          <button onclick="cambiarCantidad(${index}, 1)">➕</button>
        </p>
        <p><strong>Total:</strong> $${(producto.precio * producto.cantidad).toLocaleString("es-CO")}</p>
      </div>
      <button class="eliminar" onclick="eliminarProducto(${index})">❌</button>
    `;

    listaCarrito.appendChild(item);
  });

  calcularTotal();
  actualizarContador();
}

function cambiarCantidad(index, cambio) {
  carrito[index].cantidad += cambio;
  if (carrito[index].cantidad <= 0) carrito.splice(index, 1);
  actualizarStorage();
}

function eliminarProducto(index) {
  carrito.splice(index, 1);
  actualizarStorage();
}

function actualizarStorage() {
  localStorage.setItem("carrito", JSON.stringify(carrito));
  cargarCarrito();
}

document.getElementById("vaciar-carrito").addEventListener("click", () => {
  if (confirm("¿Vaciar carrito?")) {
    carrito = [];
    actualizarStorage();
  }
});

cargarCarrito();

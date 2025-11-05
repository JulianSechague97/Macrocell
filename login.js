const usuarios = [
  
  { username: "admin", password: "12345" },
  { username: "usuario1", password: "abc123" }
];

document.getElementById("loginForm").addEventListener("submit", function (event) {
  event.preventDefault();

  const username = document.getElementById("username").value.trim();
  const password = document.getElementById("password").value.trim();
  const errorMessage = document.getElementById("errorMessage");

  const usuarioValido = usuarios.find(
    (user) => user.username === username && user.password === password
  );

  if (usuarioValido) {
    // Guardar el usuario en localStorage
    localStorage.setItem("usuarioActivo", username);
    // Redirigir a otra página
    window.location.href = "home.html";
  } else {
    errorMessage.textContent = "Usuario o contraseña incorrectos";
  }
});
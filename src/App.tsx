function App() {
  const apiUrl = window.__ENV__.API_URL;

  return (
    <div>
      <h1>React App</h1>
      <p>API URL: {apiUrl || "não definida"}</p>
    </div>
  );
}

export default App;

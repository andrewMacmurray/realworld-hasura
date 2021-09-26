import elmPlugin from "vite-plugin-elm";

export default {
  root: "./frontend/src",
  plugins: [elmPlugin()],
  server: {
    port: 1234,
  },
  build: {
    outDir: "../../dist",
  },
};

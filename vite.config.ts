import { defineConfig } from 'vite';

export default defineConfig({
  build: {
    rollupOptions: {
      input: [
        'src/index.ts',
        'src/data/recoveryCodes.ts',
        'src/data/webAuthnAuthenticate.ts',
        'src/data/webAuthnRegister.ts',
        'src/data/phoneNumberVerificationCode.ts',
        'node_modules/flowbite/dist/flowbite.min.js',
      ],
      output: {
        assetFileNames: '[name][extname]',
        dir: 'theme/keywind/login/resources/dist',
        entryFileNames: '[name].js',
      },
    },
  },
});

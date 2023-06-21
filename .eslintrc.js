module.exports = {
  root: true,
  env: {
    browser: true,
    es2021: true,
    node: true,
  },
  extends: [
    'plugin:@typescript-eslint/recommended',
    'plugin:nuxt/recommended',
    'plugin:vue/vue3-recommended',
    'plugin:prettier/recommended',
  ],
  parserOptions: {
    ecmaVersion: "latest",
    parser: "@typescript-eslint/parser",
    sourceType: "module",
  },
  plugins: [
    '@typescript-eslint',
  ],
  rules: {
    "vue/no-v-text-v-html-on-component": 0,
    'vue/no-v-html':  0,
    'no-console': process.env.NODE_ENV === 'production' ? 'warn' : 'off',
    'no-debugger': process.env.NODE_ENV === 'production' ? 'warn' : 'off',
    'max-len': ['error', { ignorePattern: 'd="([\\s\\S]*?)"', code: 120 }],
    'no-shadow': ['error', { allow: ['state'] }],
    'vue/multi-word-component-names': 0,
  },
  settings: {
    'import/resolver': {},
  },
};

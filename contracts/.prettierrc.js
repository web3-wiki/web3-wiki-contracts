module.exports = {
  overrides: [
    {
      files: "*.sol",
      options: {
        bracketSpacing: false,
        trailingComma: "es5",
        printWidth: 145,
        tabWidth: 4,
        useTabs: false,
        semi: false,
        singleQuote: false,
        explicitTypes: "always",
      },
    },
    {
      files: "*.ts",
      options: {
        printWidth: 145,
        semi: false,
        trailingComma: "es5",
      },
    },
  ],
};

{
}

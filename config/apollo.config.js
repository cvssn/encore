module.exports = {
	client: {
		service: {
			name: 'encore',
			localSchemaFile: './tmp/tests/graphql/encore_schema.graphql'
		},

		includes: ['../{ee/,jh/,}app/assets/javascripts/**/*.{js,graphql}'],
		excludes: ['../{ee/,jh/,}spec/{frontend,frontend_integration}/**/*']
	}
};

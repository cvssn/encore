const coreJSVersion = require('./node_modules/core-js/package.json').version;

if (process.env.DEBUG_BABEL_ENV === 'true') {
	console.debug(`babel_env dentro de configuração de babel é: ${process.env.BABEL_ENV}`);
}

let presets = [
	[
		'@babel/preset-env', {
			userBuiltIns: 'usage',
			bugfixes: true,
			corejs: { version: coreJSVersion, proposals: true },
			modules: false
		}
	]
];

// incluir propósitos de estágio 3
const plugins = [
	'@babel/plugin-transform-class-properties',
	'@babel/plugin-transform-json-strings',
	'@babel/plugin-transform-private-methods',

	// https://gitlab.com/gitlab-org/gitlab/-/issues/229146
	'@babel/plugin-transform-arrow-functions',

	// https://gitlab.com/gitlab-org/gitlab/-/issues/336216
	'@babel/plugin-transform-optional-chaining',

	// https://gitlab.com/gitlab-org/gitlab/-/issues/336216
	'@babel/plugin-transform-nullish-coalescing-operator',

	// https://gitlab.com/gitlab-org/gitlab/-/issues/336216
	'@babel/plugin-transform-logical-assignment-operators',

	'@babel/plugin-transform-class-static-block',
	'@babel/plugin-transform-export-namespace-from'
];

const env = {};

// jest está rodando em ambiente node
const isJest = Boolean(process.env.JEST_WORKER_ID);

if (isJest) {
	presets = [
		[
			'@babel/preset-env', {
				targets: {
					node: 'current'
				}
			}
		]
	];
} else {
	env.istanbul = {
		plugins: [
			[
				'istanbul', {
					extension: ['.js', '.vue', '.mjs', '.cjs']
				}
			]
		]
	};
}

module.exports = {
	presets,
	plugins,
	sourceType: 'unambiguous',
	env
};

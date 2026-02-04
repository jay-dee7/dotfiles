return {
	cmd = { "yaml-language-server", "--stdio" },
	filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.helm-values", "yml" },
	root_markers = { ".git" },
	settings = {
		yaml = {
			keyOrdering = false,
			schemas = {
				kubernetes = '*.{k8s.yaml,k8s.yml,yml,yaml}',
				-- ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master-standalone-strict/all.json"] =
				-- "*.{k8s.yaml,k8s.yml,yaml,yml}",
				['http://json.schemastore.org/github-workflow'] = '.github/workflows/*',
				['http://json.schemastore.org/github-action'] = '.github/action.{yml,yaml}',
				['http://json.schemastore.org/ansible-stable-2.9'] = 'roles/tasks/*.{yml,yaml}',
				['http://json.schemastore.org/prettierrc'] = '.prettierrc.{yml,yaml}',
				['http://json.schemastore.org/kustomization'] = 'kustomization.{yml,yaml}',
				['http://json.schemastore.org/ansible-playbook'] = '*play*.{yml,yaml}',
				['http://json.schemastore.org/chart'] = 'Chart.{yml,yaml}',
				['https://json.schemastore.org/dependabot-v2'] = '.github/dependabot.{yml,yaml}',
				['https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json'] =
				'*api*.{yml,yaml}',
				['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] =
				'*docker-compose*.{yml,yaml}',
				['https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json'] =
				'*flow*.{yml,yaml}',
			},
		},
	}
}

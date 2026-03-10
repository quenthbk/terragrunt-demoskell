# Terragrunt Skell

Template for duplicating infrastructure configuration across multiple environments and regions.

## Tree structure

The terragrunt files are stored in the `live` folder.

```sh
.
├── env # The file containing the specific configuration by region and environment
│   └── local                       # A specific region (in this case, local)
│       ├── dev                     # A specific environment (in this case, dev)
│       │   ├── debug-variables     # The terraform module to apply in this context
│       │   │   └── terragrunt.hcl  # syslink in -> _templates/terragrunt.hcl
│       │   └── env.hcl # Specific variables for the environment
│       └── region.hcl # Specific variables for the region
├── _modules
│   └── debug-variables.hcl # Specific variables to inject in the terraform module debug-variable
├── _providers              # List of provider terraform providers
│   └── debug.hcl           # One provider is added (debug)
├── _templates              # One provider is added (debug)
│   └── terragrunt.hcl      # The template used by all terragrunt module
├── terragrunt.hcl # The root file (terragrunt variable orchestrator)
└── _variables          # Variables for each environments / regions
    ├── aws.hcl         # Specific AWS variables
    ├── kubernetes.hcl  # Specific Kubernetes variables
    ├── main.hcl        # Common variables (dns, project name, env, region, ...)
    ├── network.hcl     # Network variables (VPC CIDR, subnets)
    ├── storage.hcl     # Storage class, buckets
    └── versions.hcl    # Versions and repositories
```

The terraform modules are stored in the `modules` folder.

- debug-variables is used to debug terragrunt `inputs` variables.

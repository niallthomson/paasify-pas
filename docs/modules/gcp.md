# Paasify PAS on GCP

## Required Inputs

The following input variables are required:

### dns\_suffix

Description: n/a

Type: `any`

### dns\_zone\_name

Description: The name of the Cloud DNS zone that managed the domain specified for dns\_suffix

Type: `any`

### env\_name

Description: n/a

Type: `any`

### pas\_version

Description: The major version of PAS to install

Type: `any`

### pivnet\_token

Description: n/a

Type: `any`

### project

Description: n/a

Type: `any`

### region

Description: n/a

Type: `any`

## Optional Inputs

The following input variables are optional (have default values):

### availability\_zones

Description: Optional list of availability zones, will be chosen automatically otherwise

Type: `list(string)`

Default: `[]`

### buckets\_location

Description: n/a

Type: `string`

Default: `"US"`

### encrypt\_pas\_buckets

Description: n/a

Type: `string`

Default: `"1"`

### ops\_manager\_instance\_type

Description: n/a

Type: `string`

Default: `"r4.large"`

### tiles

Description: n/a

Type: `list`

Default: `[]`

### vpc\_cidr

Description: n/a

Type: `string`

Default: `"10.0.0.0/20"`

## Outputs

The following outputs are exported:

### cf\_api\_endpoint

Description: n/a

### cf\_apps\_manager\_endpoint

Description: n/a

### ops\_manager\_domain

Description: n/a

### ops\_manager\_password

Description: n/a

### ops\_manager\_username

Description: n/a

### provisioner\_host

Description: n/a

### provisioner\_ssh\_private\_key

Description: n/a

### provisioner\_ssh\_username

Description: n/a


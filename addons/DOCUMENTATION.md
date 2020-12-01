# Masterfile.json documentation
## name
### Type: string
Name of package.
## author
### Type: string
Author of package.
## type
### Type: int
Type of package. (0 - custom answers, 1 - config, 2 - plugin, 3 - other)
## ctype
### Type: bool
Type of content. (true for file, false for string)
## cname
### Type: string
Name of file (only useful for ctype = true)
## cstring
### Type: string (logik xd)
Content string. If CType is true, script downloads the content file into /moonloader/, if false - applies content using lua's eval
## desc
### Type: string
Description of package.
## date
### Type: string
Date of package creation (or whatever you want).
## minver
### Type: int
Minimal version of script that package supports.
## maxver
### Type: int
Maximum verison of script that package supports. Can be -1 for any version.
## legacy
### Type: bool
Is package obsolete.

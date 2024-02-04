# Record Types

- A - maps a hostname to a IPv4 address
- AAAA - maps a hostname to a IPv6 address
- CNAME - maps a hostname to another hostname
    - The target is a domain name which must have a A or AAAA record
    - Can't create a CNAME record for the top node of a DNS namespace (Zone Apex). Meaning you can't create a CNAME for example.com, but you can create a CNAME for www.example.com
- NS - Name Servers for the hosted Zone
    - Control how traffic is routed to a domain
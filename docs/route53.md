# Route 53

- A higly available, scalable, fully managed and Authoritative DNS
    - Authoritative DNS: the customer (you) can update the DNS records
- Route 53 is also a Domain Registrar
- Ability to check the health of your resources
- The only AWS service which provides 100% availability SLA
- Why Route 53? 53 is a reference to the traditional DNS port


## Records

- How you want to route traffic to domain
- Each record contains:
    - Domain/subdomain Name - e.g., example.com
    - Record Type - e.g., A or AAAA
    - Value - e.g., 12.34.56.78
    - Routing Policy - how Route 53 responds to queries
    - TTL - amount of time the record cached at DNS Resolvers or in web browsers
- Route 53 supports the following DNS record types:
    - A/AAAA/CNAME/NS and many more


## References

https://tutorialsdojo.com/amazon-route-53/

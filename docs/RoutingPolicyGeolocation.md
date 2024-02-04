# Geolocation

- Different from latency-based
- This routing is based on user location
- Specify location by Continent, Country, or by US State (if there's overlaping, most precise location wins)
- Should create a "Default" record (in case there's no match on location)
- Use cases: website localized to a specific country, redirect to a localized website, restrict distribution of content to only certain countries, load balancing across resources in different parts of the world
- Can be associate with health checks
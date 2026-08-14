Spring 4.1 compliant app that demonstrates the authentication and authorization of a user via JWT

# TODO
## Aufgabe 1 Dockerfile
- [x] ≤ 250 MB Runtime Image
- [x] JRE Base Image – kein JDK
- [x] Multi Stage Build – Trennung Build und Runtime
- [x] Caching von Dependencies
- [x] Kein Hardcoding von Variablen – Konfiguration via ENV
- [x] Nur JAR im Runtime Image
- [x] Non Root User
- [x] Keine kritischen Warnings seitens Hadolint (siehe nächste Folie)

## Aufgabe 2 Compose
- [x] Persistentes Volume für PostgreSQL
- [x] Datenbank nur via Service Name postgres erreichbar
- [x] Verwendetes Image für PostgreSQL entspricht 16-alpine
- [x] Spring Boot Backend startet lediglich, falls die Datenbank healthy ist
- [x] Netzwerk ist explizit definiert
- [x] Backend und Datenbank als zwei getrennte Services
- [x] Kein Hardcoding von Variablen – Konfiguration via ENV
- [x] Das .env ist im .gitingore aufgelistet

## Aufgabe 3 Reverse Proxy
- [x] Traefik ist als seperater Service im docker-compose.yml definiert
- [x] Traefik nutzt den Docker Provider 
- [x] Traefik Dashboard ist aktiviert 
- [x] Zugriff auf das Backend erfolgt ausschliesslich über das Traefik Routing via localhost:80/api
- [x] Datenbank ist nicht exponiert

## Aufgabe 4 TLS
- [x] TLS wird über Traefik mittels ACME (Let’s Encrypt) konfiguriert
- [x] Traefik stellt HTTP (80) und HTTPS (443) als EntryPoints bereit
- [x] TLS Terminierung erfolgt über Traefik
- [x] Zugriff auf das Backend erfolgt ausschliesslich über https://localhost/api. HTTP Traffic wird automatisch auf HTTPS umgeleitet 

## Aufgabe 5 Deployment
- [x] Deployment erfolgt auf einem DigitalOcean Droplet (Linux VM)
- [x] Deployment wird via GitHub Actions bei Push auf Main automatisch ausgelöst
- [x] Deployment erfolgt mittels Docker Compose via SSH auf das Droplet
- [x] Alle benötigten Secrets werden über GitHub Secrets verwaltet
- [x] Backend ist über öffentliche Domain oder IP erreichbar

## Aufgabe 6 Frontend
- [x] Das bereitgestellte Next.js Frontend wird mittels eines Dockerfiles containerisiert
- [x] Das Frontend wird als zusätzlicher Service in das bestehende Docker Compose integriert
- [x] Das Routing erfolgt über Traefik
- [x] Das Frontend ist über HTTPS erreichbar (falls möglich) und kommuniziert mit dem Backend
- [x] Die bestehende GitHub Actions Pipeline wird erweitert, sodass das Frontend gemeinsam mit den übrigen Services automatisch auf die Cloud Umgebung deployt wird
- [x] Über das Frontend können sich Benutzer registrieren und einloggen

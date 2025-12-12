# Hermes Server Setup

Ansible playbook for deploying a home media and services stack on a Raspberry Pi.

## Services

- **Portainer** - Docker management UI
- **Pi-hole** - Network-wide ad blocking and DNS
- **Paperless-ngx** - Document management system
- **Jellyfin** - Media server
- **Uptime Kuma** - Service monitoring and uptime tracking
- **Nginx** - Reverse proxy for local domain routing

## Prerequisites

- Raspberry Pi with Ubuntu/Debian
- Ansible installed on your local machine
- SSH access to the Pi

## Initial Setup

### 1. Upload SSH Key to Pi

```bash
ssh-copy-id hermes
```

Or manually:
```bash
cat ~/.ssh/id_rsa.pub | ssh hermes 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys'
```

### 2. Configure Inventory

Edit `inventory.ini` with your Pi's IP address:
```ini
[hermes_servers]
hermes ansible_host=192.168.5.100 ansible_user=ubuntu
```

### 3. Set Vault Password

Create `vault.yml` with your Pi-hole password:
```bash
ansible-vault create vault.yml
```

Add:
```yaml
vault_pihole_password: "your_secure_password"
```

## Deployment

### Deploy All Services

```bash
ansible-playbook -i inventory.ini playbook.yml --ask-vault-pass
```

### Deploy Specific Role

```bash
ansible-playbook -i inventory.ini playbook.yml --tags nginx --ask-vault-pass
```

## SSH Access

```bash
ssh hermes
```

## Managing Docker Containers

### View Running Containers
```bash
docker ps
```

### Restart a Container
```bash
docker restart <container_name>
```

Examples:
```bash
docker restart portainer
docker restart pihole
docker restart paperless-webserver
docker restart jellyfin
docker restart uptime-kuma
docker restart nginx
```

### View Container Logs
```bash
docker logs <container_name>
docker logs -f <container_name>  # Follow logs
```

### Restart All Services
```bash
cd /srv/docker/<service_name>
docker compose restart
```

## Service URLs

Access these URLs from your local network (requires Pi-hole as DNS):

- **Portainer**: http://portainer.hermes.local
- **Pi-hole**: http://pihole.hermes.local:8080/admin
- **Paperless**: http://paperless.hermes.local
- **Jellyfin**: http://jellyfin.hermes.local
- **Uptime Kuma**: http://kuma.hermes.local

## DNS Configuration

Pi-hole automatically configures local DNS for all `.hermes.local` domains. Set your devices to use the Pi's IP (192.168.5.100) as their DNS server.

## Media Storage

Jellyfin media is stored at `/media` on the server. Organize as:
- `/media/movies`
- `/media/tv`
- `/media/music`

### Mount Network Share (Optional)

**NFS:**
```bash
sudo apt install nfs-common
sudo mount -t nfs 192.168.5.10:/share/media /media
```

**SMB/CIFS:**
```bash
sudo apt install cifs-utils
sudo mount -t cifs //192.168.5.10/media /media -o username=user,password=pass
```

Add to `/etc/fstab` for persistent mounts.

## Monitoring

Uptime Kuma monitors all services. Configure monitors in the web UI:

**HTTP Monitors:**
- Jellyfin: http://jellyfin.hermes.local
- Paperless: http://paperless.hermes.local
- Portainer: http://portainer.hermes.local
- Pi-hole: http://pihole.hermes.local:8080/admin

**Docker Container Monitors:**
- Container names: `jellyfin`, `pihole`, `paperless-webserver`, `portainer`, `uptime-kuma`

## Troubleshooting

### Service not accessible
```bash
docker ps  # Check if container is running
docker logs <container_name>  # Check logs
docker restart <container_name>  # Restart service
```

### DNS not resolving
- Verify Pi-hole is running: `docker ps | grep pihole`
- Check device DNS settings point to Pi's IP
- Restart Pi-hole: `docker restart pihole`

### Redeploy after changes
```bash
ansible-playbook -i inventory.ini playbook.yml --ask-vault-pass
```

## File Locations

- Docker compose files: `/srv/docker/<service>/`
- Pi-hole config: `/srv/docker/pihole/etc-pihole/`
- Jellyfin config: `/srv/docker/jellyfin/config/`
- Paperless data: `/srv/docker/paperless/`
- Nginx config: `/srv/docker/nginx/nginx.conf`

## Security Notes

- Pi-hole admin password is stored in Ansible vault
- Services are accessible only on local network
- For remote access, consider setting up Tailscale VPN
- Default nginx upload limit: 100MB (configurable in nginx.conf)
